*** Settings ***
Documentation   This is the Helper file or keyword file for ndtv weather report api calls

Library     JSONLibrary
Library   Collections
Library   RequestsLibrary
Library    BuiltIn
Library    String

Resource   ${CURDIR}${/}ndtv_weather_api_objects.robot

*** Variables ***
${TEST_CITY_VALUE}      Bengaluru

*** Keywords ***
Open NDTV Weather API Session
    Create session		ndtv_api_session	${NDTV_API_BASE_URL}

Default Suite Action at the end
   Delete All Sessions

#Do Basic API Response Validation     [Arguments]         ${responseJson}
#    [Documentation]    This keyword is to validate the response header, body and status code contents respectively
#
#    ${header_value}=		get from dictionary		${responseJson.headers}		Content-Type
#    should be equal as strings      ${header_value}		    ${HEADERS}

Search By City Name API Calls      [Arguments]     ${TEST_CITY_VALUE}       ${paramValue}=${SEARCH_BY_CITY_NAME_API}
    [Documentation]     This is to invoke get request of searching weather details for any given city
    ...     input param value:   city name
    ...     output param value:  response json

    ${response}=	Get Request		    ndtv_api_session      uri=None      params=${paramValue}

    Request Should Be Successful        ${response}
    Dictionary Should Contain Value     ${response.json()}       ${TEST_CITY_VALUE}

    ${get_city_value}=    Get Value From Json     ${response.json()}    ${city_name_json_path}
    log to console      ${get_city_value}

    Should Not Be Empty    ${get_city_value}
    List Should Contain Value   ${get_city_value}    ${TEST_CITY_VALUE}

    [return]        ${response.json()}

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

    [return]    ${get_val}

Get Fahrenheit Temperature Value API Call    [Arguments]      ${TEST_CITY_VALUE}
    ${response}=	Get Request		    ndtv_api_session      uri=None      params=${GET_FAHRENHEIT_VALUE_API}

    Request Should Be Successful        ${response}
    Dictionary Should Contain Value     ${response.json()}       ${TEST_CITY_VALUE}

    ${get_city_value}=    Get Value From Json     ${response.json()}    ${city_name_json_path}
    log to console      ${get_city_value}

    Should Not Be Empty    ${get_city_value}
    List Should Contain Value   ${get_city_value}    ${TEST_CITY_VALUE}

    [return]        ${response.json()}

Get Celsius Temperature Value API Call    [Arguments]      ${TEST_CITY_VALUE}
    ${response}=	Get Request		    ndtv_api_session      uri=None      params=${GET_CELSIUS_VALUE_API}

    Request Should Be Successful        ${response}
    Dictionary Should Contain Value     ${response.json()}       ${TEST_CITY_VALUE}

    ${get_city_value}=    Get Value From Json     ${response.json()}    ${city_name_json_path}
    log to console      ${get_city_value}

    Should Not Be Empty    ${get_city_value}
    List Should Contain Value   ${get_city_value}    ${TEST_CITY_VALUE}

    [return]        ${response.json()}

API Basic Response Validation     [Arguments]         ${responseData}        ${TEST_CITY_VALUE}
    [Documentation]    This keyword is to validate the response header, body and status code contents respectively

    ${body_content}=		convert to string    ${responseData.content}
    should contain match    ${body}	    ${TEST_CITY_VALUE}

    ${get_city_value}=      Set Variable        ${responseData["name"]}

    ${city_val}=    Get Value From Json     ${responseData}    ${city_name_json_path}
    log to console      ${city_val}

    [return]    True



