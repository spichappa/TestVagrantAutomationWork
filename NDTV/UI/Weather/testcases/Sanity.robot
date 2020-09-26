*** Settings ***
Library     SeleniumLibrary

Resource    ${CURDIR}${/}../../common/keywords/ndtv_main_page_keywords.robot
Resource    ${CURDIR}${/}../resources/ndtv_weather_page_keywords.robot


Suite Teardown      Close All Browsers

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
    Page Should Contain Element   ${cityList_parent_element}
    [Teardown]   Close Browser

TC04 Search by a Valid Pin City Name
    [Tags]      TC04
    Perform Search By City Action    ${non_default_city_name}       ${IS_DEFAULT_CITY_VALUE}
    Verify City Elements Visibility upon Search Action    ${non_default_city_name}       ${IS_DEFAULT_CITY_VALUE}
    [Teardown]   Close Browser

TC05 Search by an InValid Pin City Name
    [Tags]      TC05
    Perform Search By City Action    ${invalid_city_name}       ${IS_DEFAULT_CITY_VALUE}
    Verify City Elements Visibility upon Search Action    ${invalid_city_name}       ${IS_DEFAULT_CITY_VALUE}
    [Teardown]   Close Browser

TC06 Search by a default Pin City Name
    [Tags]      TC06
    Perform Search By City Action    ${default_city_name}       Y
    Verify City Elements Visibility upon Search Action    ${default_city_name}       ${IS_DEFAULT_CITY_VALUE}
    [Teardown]   Close Browser

TC07 Temperature Values are available in map for a default city name
    [Tags]      TC07
    Perform Search By City Action    ${default_city_name}       Y
    Verify Temperature Values are Visible or not for the Pin City       ${default_city_name}       Y        Y
    [Teardown]   Close Browser

TC08 Temperature Values are not available in map for a non-default unsearched city name
    [Tags]      TC08
    Perform Search By City Action    ${non_default_city_name}    N
    Navigate to Weather Report Page
    Verify Temperature Values are Visible or not for the Pin City       ${non_default_city_name}       N       N
    [Teardown]   Perform Reset Button Click Action

TC09 Temperature Values are available in map for a non-default searched city name
    [Tags]      TC09
    Perform Search By City Action    ${non_default_city_name}    N
    Navigate to Weather Report Page
    Verify Temperature Values are Visible or not for the Pin City       ${non_default_city_name}       N       Y
    [Teardown]   Perform Reset Button Click Action

TC10 Validate weather details upon selecting any default cities in the map
    [Tags]      TC10
    Navigate to Weather Report Page
    Wait Until Element is Visible		${full_map_page}   ${TIMEOUT}
    Click Element       ${map_city_selector}
    Verify Temperature Values are Visible or not for the Pin City       ${default_city_name}       Y       Y
    [Teardown]   Perform Reset Button Click Action
