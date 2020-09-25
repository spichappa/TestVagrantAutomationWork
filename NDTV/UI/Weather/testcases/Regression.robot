*** Settings ***
Library     SeleniumLibrary

Resource    ${CURDIR}${/}../../common/keywords/ndtv_main_page_keywords.robot
Resource    ${CURDIR}${/}../resources/ndtv_weather_page_keywords.robot

Library DataDriver      ${CURDIR}${/}../../common/testdata/SearchCityWeatherSheet.xlsx      sheet_name=CityName

Test Template       Validate City Name Display

*** Keywords ***
Validate City Name Display
    [Arguments]    ${CityName}
    [Documentation]    This will find city names given in the input excel file are available in listed labels
    ...    Given input param: City Name column value from Excel Sheet passed through DataDriver library

*** Test Cases ***
TC01 SearchTest Using     ${CityName}










