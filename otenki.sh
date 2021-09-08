#!/usr/bin/env bash

CONFIG_FILE='./.cfg'
if [[ ! -f $CONFIG_FILE ]]; then
	echo "設定ファイルが見つかりません。 file=${CONFIG_FILE}"
	exit 1
fi
source ./.cfg

data=''
status_cd=0
name=''
main=''
temp_min=''
temp_max=''

# v1.0 日本語未対応
data=$(curl -X GET --max-time 30 -s "https://api.openweathermap.org/data/2.5/weather?id=${ID}&units=metric&lang=en&appid=${APP_KEY}")
#data=$(cat './test_data/res_sample.json')

if [[ $? -ne 0 ]]; then
	echo "APIの実行で問題が発生しました。 \$?=$?"
	exit 1
fi

# HTTP STATUS_CODE
if [[ $data =~ (\"cod\":[0-9]{3}) ]]; then
	status_cd=$(echo ${BASH_REMATCH[1]} | awk -F '[:]' '{print $2}')
fi

if [[ $status_cd -ge 400 ]]; then
	echo "APIの実行で問題が発生しました。 HTTP_STATUS_CD=$status_cd"
	exit 1
fi

# 都市名
# v1.0 日本語未対応
if [[ $data =~ (\"name\":\"[a-zA-Z]+\") ]]; then
	name=${BASH_REMATCH[1]}
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

echo $name
echo $main
echo $temp_min
echo $temp_max
