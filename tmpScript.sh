#!/bin/bash
# set the offline token and checksum parameters
offline_token="eyJhbGciOiJIUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJhZDUyMjdhMy1iY2ZkLTRjZjAtYTdiNi0zOTk4MzVhMDg1NjYifQ.eyJpYXQiOjE2Mzc3NjUwODgsImp0aSI6IjNiYmFjZjIwLTQzM2ItNDNhMi05MjRjLTI5YTkxYWFkZGQ4YyIsImlzcyI6Imh0dHBzOi8vc3NvLnJlZGhhdC5jb20vYXV0aC9yZWFsbXMvcmVkaGF0LWV4dGVybmFsIiwiYXVkIjoiaHR0cHM6Ly9zc28ucmVkaGF0LmNvbS9hdXRoL3JlYWxtcy9yZWRoYXQtZXh0ZXJuYWwiLCJzdWIiOiJmOjUyOGQ3NmZmLWY3MDgtNDNlZC04Y2Q1LWZlMTZmNGZlMGNlNjpza29ieWRhIiwidHlwIjoiT2ZmbGluZSIsImF6cCI6InJoc20tYXBpIiwic2Vzc2lvbl9zdGF0ZSI6IjAyZDMwMjlkLThhNGQtNGQ2My1iZGM5LWQ1YzFjNWRiODIzNyIsInNjb3BlIjoib2ZmbGluZV9hY2Nlc3MifQ.PRp00NaYjPCM8B8iNgUtSjC2jw0wAYLhy2dpty6a2h0"
checksum="f2e70bfdafb3b4360beac338e6ac7bc0d5c5696d1f9efc5ec9e045f262efb09a"

# get an access token
echo "curl https://sso.redhat.com/auth/realms/redhat-external/protocol/openid-connect/token -d grant_type=refresh_token -d client_id=rhsm-api -d refresh_token=$offline_token | jq -r '.access_token'"
access_token=$(curl https://sso.redhat.com/auth/realms/redhat-external/protocol/openid-connect/token -d grant_type=refresh_token -d client_id=rhsm-api -d refresh_token=$offline_token | jq -r '.access_token')

# get the filename and download url
image=$(curl -H "Authorization: Bearer $access_token" "https://api.access.redhat.com/management/v1/images/$checksum/download")
filename=$(echo $image | jq -r .body.filename)
url=$(echo $image | jq -r .body.href)

# download the file
curl $url -o $filename
