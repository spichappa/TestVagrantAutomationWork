*** Settings ***
Documentation    This is the Integrated E2E/Regression/Comparator Test Suite of UI and API components of NDTV Weather Report Data

Resource   ${CURDIR}${/}../API/Weather/resources/ndtv_weather_api_keywords.robot
Resource   ${CURDIR}${/}../UI/Weather/resources/ndtv_weather_report_page_keywords.robot

Suite Setup     Provided precondition
Suite Teardown      Final Actions
*** Keywords ***
Provided precondition
    Launch NDTV Weather Report Page
    Open NDTV Weather API Session
Final Actions
    Close All Browsers
    Delete All Sessions

Find temperature variance between ui and api results    [Arguments]     ${tempFromUI}       ${tempFromAPI}
    [Documentation]     Find the variance between 2 temperature values

    log to console      ${tempFromUI[0]}       msg='temp from ui'
    log to console      ${tempFromAPI}      msg='temp from api'

    ${temp_diff}=     evaluate    ${tempFromUI}-${tempFromAPI[0]}
    ${status}=      run keyword and return status   Should Be True      ${temp_diff}<=${temp_variance_value} and ${temp_diff}>=-${temp_variance_value}

    Run Keyword If	${status} == 'True'	    Log	Passed
    Run Keyword If  ${status} == 'False' 	Log	Output contains FAIL

*** Variables ***
${temp_variance_value}       2

*** Test Cases ***
Comparator of city temparature values from API and UI
    [Documentation]     This is the integrated test to compare the temperature values of a test city

    ${city_temperature_data_UI}=   Fetch Weather Details for a city       ${DEFAULT_CITY_NAME}
    log to console      ${city_temperature_data_UI}

    ${city_data_from_API}=   Fetch Weather Details from API for a City   ${DEFAULT_CITY_NAME}
    log to console      ${city_data_from_API}

    ${city_temperature_data_API}=    Get From Dictionary    ${city_data_from_API}    tempCelsius

    ${find_diff}=       Find temperature variance between ui and api results    ${city_temperature_data_UI}     ${city_temperature_data_API}
