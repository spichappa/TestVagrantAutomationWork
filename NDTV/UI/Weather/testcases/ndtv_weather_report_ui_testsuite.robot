*** Settings ***
Library     SeleniumLibrary

Resource    ${CURDIR}${/}../../common/keywords/ndtv_main_page_keywords.robot
Resource    ${CURDIR}${/}../resources/ndtv_weather_report_page_keywords.robot

Suite Setup   Launch NDTV Weather Report Page
Suite Teardown      Close All Browsers

Documentation   This is the ndtv weather report page UI automation suite

*** Keywords ***
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
Search by a Valid City Name - Default City
    [Tags]      sanity      TC01
    [Documentation]     Search By City Name - Valid Default City Name:  Eg: Bengaluru
    ...                 1. Verify if the given city name is present/filtered out in the dropdown box
    ...                 2. Then upon selection it should fetch that particular city with temperature is availab le on the map
    ${search_action_output}=         Perform Search By City Name Action       ${DEFAULT_CITY_NAME}       ${IS_DEFAULT_CITY_VALUE}=Y
    Should Be True      ${search_action_output}
    ${map_data_availablity}=    Validate City is available on the map with temperature information       ${DEFAULT_CITY_NAME}
    Should Be True      ${map_data_availablity}
    [Teardown]      Perform Reset Button Click Action

Search by a Valid City Name - Non-Default City
    [Tags]      sanity      TC02
    [Documentation]     Search By City Name - Valid Non-Default City Name: Eg: Amritsar
    ...                 1. Verify if the given city name is present/filtered out in the dropdown box
    ...                 2. Then upon selection it should fetch that particular city with temperature is availab le on the map

    ${search_action_output}=         Perform Search By City Name Action       ${NON_DEFAULT_CITY_NAME}       ${IS_DEFAULT_CITY_VALUE}=N
    Should Be True      ${search_action_output}
    ${map_data_availablity}=    Validate City is available on the map with temperature information       ${NON_DEFAULT_CITY_NAME}
    Should Be True      ${map_data_availablity}

    [Teardown]      Perform Reset Button Click Action

Search by an InValid Pin City Name - Any outside Indian city name value
    [Tags]      sanity      TC03
    [Documentation]     Search By City Name - InValid City Name(Outside India): Eg: Tokyo
    ...                 Verify if the given city name is present/filtered out in the dropdown box

    ${search_action_output}=         Perform Search By City Name Action       ${INVALID_CITY_NAME}       ${IS_DEFAULT_CITY_VALUE}
    Should Be True      ${search_action_output}
    log to console      'Search Result returns false for invalid city. Further search action for map data check cannot  be proceeded'

    [Teardown]      Perform Reset Button Click Action

Display Weather details on the map when a default city is selected
    [Tags]      sanity      TC04
    [Documentation]     It checks whether the map displays Weather details By Default on the map

    #Since the weather details are already displayed for a default city, no need to perform Search By City Actions
    Fetch Weather Details for a city        ${DEFAULT_CITY_NAME}
    Hide Weather Pane upon clicking the close button

Display Weather details on the map when a non-default city is selected
    [Tags]      sanity      TC05
    [Documentation]     It checks whether the map displays Weather details on the map when a NON DEFAULT city is selected and hides when unselected

    ${search_action_output}=         Perform Search By City Name Action       ${NON_DEFAULT_CITY_NAME}       ${IS_DEFAULT_CITY_VALUE}=N
    Should Be True      ${search_action_output}
    ${map_data_availablity}=    Validate City is available on the map with temperature information       ${NON_DEFAULT_CITY_NAME}
    Should Be True      ${map_data_availablity}
    Fetch Weather Details for a city        ${NON_DEFAULT_CITY_NAME}
    Hide Weather Pane upon clicking the close button
