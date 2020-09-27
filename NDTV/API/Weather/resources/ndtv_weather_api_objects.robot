*** Settings ***
Documentation   This is the test data file for ndtv weather report api


*** Variables ***

########################GLOBAL VARIABLES######################################
${NDTV_WEATHER_API_URL}        https://api.openweathermap.org/data/2.5/weather
${SEARCH_BY_CITY_NAME}      /name​
${SEARCH_BY_CITY_ID}      /id
${API_KEY}      7fe67bf08c80ded756e598d6f8fedaea
${HEADERS}        Content-Type=application/json
${API_TIMEOUT}   200

#Manual Query
#https://api.openweathermap.org/data/2.5/weather?q=chennai&appid=7fe67bf08c80ded756e598d6f8fedaea



