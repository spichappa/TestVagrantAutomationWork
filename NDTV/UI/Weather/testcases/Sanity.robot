*** Settings ***
Library     SeleniumLibrary

Resource    ${CURDIR}${/}../../common/keywords/ndtv_main_page_keywords.robot
Resource    ${CURDIR}${/}../resources/ndtv_weather_page_keywords.robot


*** Test Cases ***
TC01 Validate Browser Navigation of NDTV Main Page
    [Tags]      TC01
    Open NDTV Main Page
    [Teardown]   Close Browser

TC02 Validate Browser Navigates to Weather Report Page
    [Tags]      TC02
    Open NDTV Main Page
    Navigate to Weather Report Page
    [Teardown]   Close Browser

TC03 Validate Weather Report Page Elements
    [Tags]      TC03
    Open NDTV Main Page
    Navigate to Weather Report Page
    Page Should Contain Element   ${pin_city_logo}
    Page Should Contain Element   ${pin_your_city_msg}
    Page Should Contain Element   ${reset_icon_id}
    Page Should Contain Element   ${search_box_id}
    Page Should Contain Element   ${cityList_element}
    [Teardown]   Close Browser

TC04 Search a Valid Pin City Name
    [Tags]      TC04
    Perform Search By City Action    Amritsar
    Verify Search By City Name for a Valid Input    Amritsar
    [Teardown]   Close Browser

TC05 Search an InValid Pin City Name
    [Tags]      TC05
    Perform Search By City Action    Tokyo
    Verify Search By City Name for an InValid Input     Tokyo
    [Teardown]   Close Browser

TC06 Search by a default Pin City Name
    [Tags]      TC06
    Perform Search By City Action    ${default_city_name}
    Verify Search by City Name for a default city value    ${default_city_name}
    [Teardown]   Close Browser







