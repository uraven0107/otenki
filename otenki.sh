#!/bin/bash

CONFIG_FILE='./.cfg'
if [[ ! -f $CONFIG_FILE ]]; then
	echo "設定ファイルが見つかりません。 file=${CONFIG_FILE}"
	exit 1
fi
source ./.cfg
ID=1859393 # 木更津

function fetch() {
				#local out=$(curl -X GET --connect-timeout 30 -s "https://api.openweathermap.org/data/2.5/weather?id=${ID}&units=metric&lang=ja&appid=${APP_KEY}")
				local out=$(cat './test_data/res_sample.json')

				# HTTP STATUS_CODE
				local status_cd=0
				if [[ $out =~ (\"cod\":[0-9]{3}) ]]; then
								status_cd=${BASH_REMATCH[1]}
				fi

				# お天気
				local main=0
				if [[ $out =~ (\"main\":\"[a-zA-Z]+\") ]]; then
								main=${BASH_REMATCH[1]}
				fi

				# 最低気温
				local temp_min=0
				if [[ $out =~ (\"temp_min\":[0-9]{1,3}\.[0-9]{1,3}) ]]; then
								temp_min=${BASH_REMATCH[1]}
				fi

				# 最高気温
				local temp_max=0
				if [[ $out =~ (\"temp_max\":[0-9]{1,3}\.[0-9]{1,3}) ]]; then
								temp_max=${BASH_REMATCH[1]}
				fi
				
				echo $status_cd
				echo $main
				echo $temp_min
				echo $temp_max
				
}

fetch
