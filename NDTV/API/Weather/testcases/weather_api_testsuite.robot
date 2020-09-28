*** Settings ***

Resource    ${CURDIR}${/}../resources/ndtv_weather_api_keywords.robot

Suite Setup     Open NDTV Weather API Session
Suite Teardown  Default Suite Action at the end

*** Variables ***
${TEST_CITY_VALUE}      Bengaluru
${INVALID_CITY_VALUE}   Africa
${SEARCH_INVALID_REQUEST}       invalidrequestValue
${ERROR_CODE}   400
${ERROR_MESSAGE}
*** Test Cases ***
Search By Valid City Name
    [Documentation]     It verifies the 'search by city name' get request with given input data
    ...     test_city_name and cross verify the response data
    [Tags]      TC01
    ${get_response}=    Search By City Name API Calls      ${TEST_CITY_VALUE}       ${SEARCH_BY_CITY_NAME_API}
    ${result}=       Fetch City ID from the response data    ${get_response}
    Should Be True      ${result}

Search By In Valid City Name
    [Documentation]     It verifies the 'search by city name' get request with given input data
    ...     test_city_name and cross verify the response data
    [Tags]      TC02
    ${get_response}=    Search By City Name API Calls      ${INVALID_CITY_VALUE}          ${SEARCH_BY_CITY_NAME_API}
    should not be empty     ${get_city_id}

Search By Valid City Name with In Valid API Key
    [Documentation]     It verifies the 'search by city name' get request with given input data
    ...     test_city_name and cross verify the response data
    [Tags]      TC03
    ${get_response}=    Search By City Name API Calls      ${TEST_CITY_VALUE}          ${SEARCH_BY_CITY_NAME_API}
    should not be empty     ${get_city_id}

Search By Valid City ID
    [Documentation]     It verifies the 'search by city name' get request with given input data
    ...     test_city_name and cross verify the response data
    ${get_response}=    Search By City ID API Calls      ${TEST_CITY_ID}     ${SEARCH_BY_CITY_ID_API}
    should not be empty     ${get_city_id}

Search By InValid City ID
    [Documentation]     It verifies the 'search by city name' get request with given input data
    ...     test_city_name and cross verify the response data
    ${get_response}=    Search By City ID API Calls      ${TEST_CITY_ID}     ${SEARCH_BY_CITY_ID_API}
    should not be empty     ${get_city_id}

Fetch Weather Fields for a Valid City Name
    [Documentation]     It verifies the 'search by city name' get request with given input data
    ...     test_city_name and cross verify the response data
    [Tags]      sanity
    ${get_response}=    Search By City Name API Calls      ${TEST_CITY_NAME}         ${GET_FAHRENHEIT_VALUE_API}
    ${temperature_InFahrenheit}=     Fetch search data from the response json      ${get_response}       ${city_temp_fahrenheit}

    ${get_response}=    Search By City Name API Calls      ${TEST_CITY_NAME}     ${GET_CELSIUS_VALUE_API}
    ${temperature_InCelsius}=     Fetch search data from the response json      ${get_response}       ${city_temp_fahrenheit}
    
    &{city_weather_details} =	    Create Dictionary	key=${TEST_CITY_NAME}	cityName=${TEST_CITY_NAME}      cityID=${TEST_CITY_ID}      tempFahrenheit=${temperature_InFahrenheit}      tempCelsius=${temperature_InCelsius}
#    Should Be True	${dict} == {'key': 'value', 'foo': 'bar'}
#    [return]    ${city_weather_details}