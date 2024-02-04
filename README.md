# Project for Cloudwalk

#### install
```shell
git clone git@github.com:xptavares/cloudwalk.git
cd cloudwalk
bundle install
rake db:create db:migrate
rake transaction:load_from_csv
```

#### Test
```shell
rspec
```

##### Run
```shell
rails s
```

#### Doc api

[POST] http://127.0.0.1:3000/api/transactions

body:
```json
{
	"transaction_id" : 2342357,
	"merchant_id" : 29744,
	"user_id" : 97051,
	"card_number" : "434505******9116",
	"transaction_date" : "2019-11-31T23:16:32.812632",
	"transaction_amount" : 373,
	"device_id" : 285475
}
```
response:
```json
{
	"transaction_id": "2342357",
	"recommendation": "approve"
}
```

curl cli:
```shell
curl --request POST \
  --url http://127.0.0.1:3000/api/transactions \
  --header 'Content-Type: application/json' \
  --header 'User-Agent: insomnia/8.6.0' \
  --data '{
	"transaction_id" : 2342357,
	"merchant_id" : 29744,
	"user_id" : 97051,
	"card_number" : "434505******9116",
	"transaction_date" : "2019-11-31T23:16:32.812632",
	"transaction_amount" : 373,
	"device_id" : 285475
}'
```
