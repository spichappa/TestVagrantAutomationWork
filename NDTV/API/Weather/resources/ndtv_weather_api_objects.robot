*** Settings ***
Documentation   This is the test data file for ndtv weather report api

*** Variables ***

########################GLOBAL VARIABLES######################################
${NDTV_API_BASE_URL}        https://api.openweathermap.org/data/2.5/weather?
${TEST_CITY_NAME}      Bengaluru
${TEST_CITY_ID}        1277333
${API_KEY}      7fe67bf08c80ded756e598d6f8fedaea
${SEARCH_BY_CITY_NAME_API}    q=${TEST_CITY_NAME}&appid=${API_KEY}
${SEARCH_BY_CITY_ID_API}      id=${TEST_CITY_ID}&appid=${API_KEY}
${METRIC}       metric
${IMPERIAL}       imperial
${INVALID_CITY_VALUE}   Africa
${SEARCH_BY_INVALID_CITY_NAME_API}    q=${INVALID_CITY_VALUE}&appid=${API_KEY}
${GET_FAHRENHEIT_VALUE_API}      q=${TEST_CITY_NAME}&units=${IMPERIAL}&appid=${API_KEY}
${GET_CELSIUS_VALUE_API}      q=${TEST_CITY_NAME}&units=${METRIC}&appid=${API_KEY}

${GET_DEGREE_TEMP}      q=${TEST_CITY_NAME}&appid=${API_KEY}

${HEADERS}        application/json; charset=utf-8 !
${API_TIMEOUT}   200

#####City Weather Information Related JSON Elements##################
${city_name_json_path}=   $.name
${city_id_json_path}=   $.id
${city_temp}=   $.main.temp
${city_temp_min}=   $.main.temp_min
${city_temp_max}=   $.main.temp_max
${city_humidity}=   $.main.humidity
${city_pressure}=   $.main.pressure
${city_wind_degree}=   $.wind.deg
${city_weather.id}=   $.weather.id
${city_weather.main}=   $.weather.main
${weather.description}=     $.weather.description
${date_value}=      $.dt




#Manual Query
#https://api.openweathermap.org/data/2.5/weather?q=chennai&appid=7fe67bf08c80ded756e598d6f8fedaea
