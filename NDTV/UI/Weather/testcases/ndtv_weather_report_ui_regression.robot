*** Settings ***
Library     SeleniumLibrary

Resource    ${CURDIR}${/}../../common/keywords/ndtv_main_page_keywords.robot
Resource    ${CURDIR}${/}../resources/ndtv_weather_report_page_keywords.robot


Library  DataDriver      ${CURDIR}${/}../testdata/SearchCityWeatherSheet.xls      sheet_name=CityName

Test Template       Validate Search By City Name

*** Keywords ***
Validate Search By City Name    [Arguments]    ${CityNameVal}
    [Documentation]    This will find city names given in the input excel file are available in listed labels
    ...    Given input param: City Name column value from Excel Sheet passed through DataDriver library

    Launch NDTV Weather Report Page
    Validate Weather Report Page Elements are Visible and Available for testing
    ${search_action_output}=         Perform Search By City Name Action       ${CityNameVal}       ${IS_DEFAULT_CITY_VALUE}=N
    Should Be True      ${search_action_output}
    ${map_data_availablity}=    Validate City is available on the map with temperature information       ${CityNameVal}
    Should Be True      ${map_data_availablity}
    Perform Reset Button Click Action

Launch NDTV Weather Report Page
    [Documentation]  Prerequite Suite Settings Keyword and its Test Steps are as follows:
    ...                          1. Open the Chrome Browser via Selenium is working fine.
    ...                          2. Then Launch of the NDTV website
    ...                          3. And navigates to the required weather report page for this test suite

    Open NDTV Main Page
    Navigate to Weather Report Page
    Validate Weather Report Page Elements are Visible and Available for testing

Validate Weather Report Page Elements are Visible and Available for testing
    [Documentation]     Verify all major page elements of weather report page are visible and accessible

    Page Should Contain Element   ${pin_city_logo}
    Page Should Contain Element   ${pin_your_city_msg}
    Page Should Contain Element   ${reset_icon_id}
    Page Should Contain Element   ${search_box_id}
    Page Should Contain Element   ${cityList_parent_element}
    ${listCount}=    Get Element Count    ${cityList_dropdown_element}
    Should Be Equal As Integers     ${listCount}        ${cityCountValue}
    Wait Until Element is Visible		${map_img}      ${TIMEOUT}
    Wait Until Element is Visible		${full_map_page}      ${TIMEOUT}

*** Test Cases ***
SearchByCityWeatherData Using     ${CityName}










