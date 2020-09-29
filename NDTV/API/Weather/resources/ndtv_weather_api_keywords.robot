*** Settings ***
Documentation   This is the Helper file or keyword file for ndtv weather report api calls

Library     JSONLibrary
Library     Collections
Library     RequestsLibrary
Library     BuiltIn
Library     String

Resource   ${CURDIR}${/}ndtv_weather_api_objects.robot

*** Variables ***
${TEST_CITY_VALUE}      Bengaluru

*** Keywords ***
Open NDTV Weather API Session
    Create session		ndtv_api_session	${NDTV_API_BASE_URL}

Default Suite Action at the end
   Delete All Sessions

Search By City Name Query Request   [Arguments]     ${paramValue}
    ${response}=	Get Request		    ndtv_api_session      uri=None      params=${paramValue}
    [Return]    ${response}

Search By City Name API Calls      [Arguments]     ${TEST_CITY_VALUE}       ${paramValue}=${SEARCH_BY_CITY_NAME_API}
    [Documentation]     This is to invoke get request of searching weather details for any given city
    ...     input param value:   city name
    ...     output param value:  response json

    ${response}=	Search By City Name Query Request       ${paramValue}

    Request Should Be Successful        ${response}
    Dictionary Should Contain Value     ${response.json()}       ${TEST_CITY_VALUE}

    ${get_city_value}=    Get Value From Json     ${response.json()}    ${city_name_json_path}
    log to console      ${get_city_value}

    Should Not Be Empty    ${get_city_value}
    List Should Contain Value   ${get_city_value}    ${TEST_CITY_VALUE}

    [Return]       ${response.json()}

Fetch City ID from the response data   [Arguments]         ${responseJson}
    [Documentation]     This is to fetch the city id from the response data

    ${get_city_id}=    Get Value From Json     ${responseJson}      ${city_id_json_path}
    log to console      ${get_city_id}
    ${city_id}=     Convert To Integer      ${TEST_CITY_ID}
    Should Not Be Empty    ${get_city_id}
    List Should Contain Value   ${get_city_id}    ${city_id}
    [return]    True

Fetch search data from the response json   [Arguments]         ${responseJson}         ${searchField}
    [Documentation]     This is to invoke get request of searching weather details for any given city

    ${get_val}=    Get Value From Json     ${responseJson}    ${searchField}
    log to console      ${get_val}
    Should Not Be Empty    ${get_val}
#    Should Be Equal   ${get_val}    ${searchField}
    [Return]    ${get_val}

Search By In valid City Name    [Arguments]         ${responseJson}
    ${get_city_id}=    Search By City ID API Calls      ${TEST_CITY_ID}
    [Return]    ${response}

Verify Response for Valid inputs      [Arguments]        ${response}
     Request Should Be Successful        ${response}

Verify Response for Invalid inputs      [Arguments]        ${response}
     ${status}=     run keyword and return status   Status Should Be  200            ${response}
     should not be true     ${status}

Verify Valid City Search Response Data
    Request Should Be Successful        ${response}
    Dictionary Should Contain Value     ${response.json()}       ${TEST_CITY_VALUE}

    ${get_city_value}=    Get Value From Json     ${response.json()}    ${city_name_json_path}
    log to console      ${get_city_value}

    Should Not Be Empty    ${get_city_value}
    List Should Contain Value   ${get_city_value}    ${TEST_CITY_VALUE}
    [return]    True

API Basic Response Validation     [Arguments]         ${responseData}        ${TEST_CITY_VALUE}
    [Documentation]    This keyword is to validate the response header, body and status code contents respectively

    ${body_content}=		convert to string    ${responseData.content}
    should contain match    ${body}	    ${TEST_CITY_VALUE}

    ${get_city_value}=      Set Variable        ${responseData["name"]}

    ${city_val}=    Get Value From Json     ${responseData}    ${city_name_json_path}
    log to console      ${city_val}
    [Return]        True

Fetch Weather Details from API for a City      [Arguments]     ${TEST_CITY_NAME}
    [Documentation]     It verifies the 'search by city name' get request with given input data
    ...     test_city_name and cross verify the response data

    ${get_response}=    Search By City Name API Calls      ${TEST_CITY_NAME}         ${GET_FAHRENHEIT_VALUE_API}
    ${temperature_InFahrenheit}=     Fetch search data from the response json      ${get_response}       ${city_temp}

    ${get_response}=    Search By City Name API Calls      ${TEST_CITY_NAME}     ${GET_CELSIUS_VALUE_API}
    ${temperature_InCelsius}=     Fetch search data from the response json      ${get_response}       ${city_temp}

    &{city_weather_details} =	    Create Dictionary	key=${TEST_CITY_NAME}	cityName=${TEST_CITY_NAME}      cityID=${TEST_CITY_ID}      tempFahrenheit=${temperature_InFahrenheit}      tempCelsius=${temperature_InCelsius}

    Log To Console      ${TEST_CITY_VALUE}      msg="API Call to fetch the temperature value for a city name"
    Log To Console      ${temperature_InFahrenheit}     msg="TempF"
    Log To Console      ${temperature_InCelsius}     msg="TempC"
    [Return]        ${city_weather_details}

Do Basic API Response Validation     [Arguments]         ${responseJson}
    [Documentation]    This keyword is to validate the response header, body and status code contents respectively

    ${header_value}=		get from dictionary		${responseJson.headers}		Content-Type
    should be equal as strings      ${header_value}		    ${HEADERS}
