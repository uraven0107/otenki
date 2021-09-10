# otenki
CLI 天気予報

### 必要なもの

- [OpenWeatherMap](https://openweathermap.org/api)のAPIキー(要ユーザー登録)
- bash
- curl

### 利用方法

- インストール

  ```
  git clone https://github.com/uraven0107/otenki.git
  cd otenki
  chmod +x otenki.sh
  ```
 
- 設定

  - 設定ファイルを作成
  
  ```
  cp -p .cfg.sample .cfg
  ```
  
  - 設定値
  
  `API_KEY` ... OpenWeatherMapのAPIキー<br>
  `CITY_ID` ... 都市ID
  
  - 都市IDについて
  
   天気予報が知りたい都市のIDです。<br>
   `data/ja_id.csv` を利用するか、<br>
    [こちら](http://bulk.openweathermap.org/sample/)から`city.list.json.gz`をDLして解凍して参照してください。
   
   
- 実行

  ```
  ./otenki.sh
  ```
　

 
