*** Settings ***
Library     SeleniumLibrary

Resource    ${CURDIR}${/}../../common/keywords/ndtv_main_page_keywords.robot
Resource    ${CURDIR}${/}../resources/ndtv_weather_report_page_keywords.robot

Suite Setup     Launch NDTV Weather Report Page
Suite Teardown      Close All Browsers

Documentation   This is the ndtv weather report page UI automation suite

*** Keywords ***

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
    ${city_temp}=    Fetch Weather Details for a city        ${NON_DEFAULT_CITY_NAME}
    Hide Weather Pane upon clicking the close button

Overall TestCase
    [Tags]      e2e
    ${city_temp}=   Fetch Weather Details for a city       ${DEFAULT_CITY_NAME}
    log to console      ${city_temp}