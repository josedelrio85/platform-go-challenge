#!/bin/sh

curl --request POST 'http://localhost:4567/user/a04c6d0e-0115-4931-9911-35d5fe61983e/fav/add' \
-d '{
  "type": "audience",
  "audience": {
    "id": "a85b8a66-15f4-49be-a0a0-90df6ce2b79f",
    "gender": "foobar",
    "born_country": "foo",
    "age_group": "bar",
    "daily_hours_social_media": "foo",
    "purchases_last_month": "bar"
  }
}'


curl --request GET 'http://localhost:4567/user/a04c6d0e-0115-4931-9911-35d5fe61983e/fav/list'


curl --request PUT 'http://localhost:4567/user/a04c6d0e-0115-4931-9911-35d5fe61983e/fav/edit' \
-d '{
  "type": "audience",
  "audience": {
    "id": "a85b8a66-15f4-49be-a0a0-90df6ce2b79f",
    "gender": "updated",
    "born_country": "foo_updated",
    "age_group": "bar_updated",
    "daily_hours_social_media": "foo_updated",
    "purchases_last_month": "bar_updated"
  }
}'

curl --request GET 'http://localhost:4567/user/ea486aa8-5533-4dc4-9fb8-ce4613fb751b/fav/list' | jq


curl --request GET 'http://localhost:4567/user/97fca777-2f3f-452d-8536-8950505d976f/fav/list' | jq
