#!/bin/bash

CONFIG_FILE='./.cfg'
if [[ ! -f $CONFIG_FILE ]]; then
	echo "設定ファイルが見つかりません。 file=${CONFIG_FILE}"
	exit 1
fi
source ./.cfg
ID=1859393 # 木更津

data=''
status_cd=0
main=''
temp_min=0
temp_max=0

function fetch() {
				#local res=$(curl -X GET --connect-timeres 30 -s "https://api.openweathermap.org/data/2.5/weather?id=${ID}&units=metric&lang=ja&appid=${APP_KEY}")
				data=$(cat './test_data/res_sample.json')
}

function parse_data() {
				# HTTP STATUS_CODE
				if [[ $data =~ (\"cod\":[0-9]{3}) ]]; then
								status_cd=${BASH_REMATCH[1]}
				fi

				# お天気
				if [[ $data =~ (\"main\":\"[a-zA-Z]+\") ]]; then
								main=${BASH_REMATCH[1]}
				fi

				# 最低気温
				if [[ $data =~ (\"temp_min\":[0-9]{1,3}\.[0-9]{1,3}) ]]; then
								temp_min=${BASH_REMATCH[1]}
				fi

				# 最高気温
				if [[ $data =~ (\"temp_max\":[0-9]{1,3}\.[0-9]{1,3}) ]]; then
								temp_max=${BASH_REMATCH[1]}
				fi
				
}

fetch
parse_data
echo $status_cd
echo $main
echo $temp_min
echo $temp_max
