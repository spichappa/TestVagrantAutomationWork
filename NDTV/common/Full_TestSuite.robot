*** Settings ***
Documentation    This is the Integrated E2E/Regression/Comparator Test Suite of UI and API components of NDTV Weather Report Data

Resource   ${CURDIR}${/}../API/Weather/resources/ndtv_weather_api_keywords.robot
Resource   ${CURDIR}${/}../UI/Weather/resources/ndtv_weather_report_page_keywords.robot

Library  DataDriver      ${CURDIR}${/}../testdata/VarianceWeatherSheet.xls      sheet_name=CityName,temp_ui,temp_api,variance

Test Template       Comparator of city temparature values from API and UI

Suite Setup     Provided precondition
Suite Teardown      Final Actions
*** Keywords ***
Provided precondition
    Launch NDTV Weather Report Page
    Open NDTV Weather API Session
Final Actions
    Close All Browsers
    Delete All Sessions

Comparator of city temparature values from API and UI
    [Documentation]     This is the integrated test to compare the temperature values of a test city

    ${city_temperature_data_UI}=   Fetch Weather Details for a city       ${TEST_CITY_NAME}
    log to console      ${city_temperature_data_UI}

    ${city_temperature_data_API}=   Fetch Weather Details from API for a City   ${TEST_CITY_NAME}
    log to console      ${city_temperature_data_API}

    ${result}=      Run Keyword and Return Status   Find temperature result value difference and match with variance value      ${city_temperature_data_UI}     ${city_temperature_data_API}
    Should Be True       ${result}


*** Variables ***
${TEMP_VARIANCE_TESTCITY}       4
${TEST_CITY_NAME}       Bengaluru

*** Test Cases ***
CompareCityTemperatureResultDifference Using    ${TEST_CITY_NAME}


