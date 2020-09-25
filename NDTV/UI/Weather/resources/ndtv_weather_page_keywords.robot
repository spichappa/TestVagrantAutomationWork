*** Settings ***
Documentation   *This is the common keywords file of NDTV Weather Report page
...      All required keywords of NDTV Weather Report page*

Library     SeleniumLibrary
Resource          ${CURDIR}${/}../../common/config/ndtv_global_vars.robot
Resource          ${CURDIR}${/}../../common/keywords/ndtv_main_page_keywords.robot
Resource          ${CURDIR}${/}../testdata/weather_page_elements.robot

*** Variables ***
${cityCountValue}       86

*** Keywords ***
Go To Weather Menu
    Page Should Contain Element    ${weather_page_xpath}
    Click Element    ${weather_page_xpath}

Assert Weather Page Has Rendered Fully
    Wait Until Element Is Visible    ${weather_page_title_img}
    Wait Until Page Contains Element    ${map_img}     timeout=${TIMEOUT}
    Page Should Contain Element   ${map_img}

Navigate to Weather Report Page
    [Documentation]     Keyword used to navigate to Weather Report Page of NDTV site
    Open NDTV Main Page
    Click SubMenu Icon
    Go To Weather Menu
    Assert Weather Page Has Rendered Fully

Perform Search By City Action
    [Arguments]    ${CityName}
    [Documentation]    This will perform search action by city name
    ...    Given input param: City Name in String

    Navigate to Weather Report Page
    Page Should Contain Element    ${cityList_parent_element}
    ${listCount}=    Get Element Count    ${cityList_dropdown_element}
    Should Be Equal As Integers     ${listCount}        ${cityCountValue}

    #Before Search, City Name Label should not be displayed
    Element Should Not Be Visible       xpath=//div[@class='outerContainer'][contains(@title,'${CityName}')]

    Input Text      ${search_box_id}       ${CityName}
    Press Keys      ${search_box_id}      ENTER

Verify Search By City Name for a Valid Input
    [Arguments]    ${CityName}
    [Documentation]    This will find city name is available in the web page/map
    ...    Given input param: City Name in String

    Page Should Contain Element     xpath=//label[@for='${CityName}'][contains(.,'${CityName}')]
    Click Element       xpath=//label[@for='${CityName}'][contains(.,'${CityName}')]

    #After Search, City Name Label should not be displayed
    Element Should Be Visible       xpath=//div[@class='outerContainer'][contains(@title,'${CityName}')]

    [Teardown]      Perform Reset Button Click Action

Verify Search By City Name for an InValid Input
    [Arguments]    ${CityName}
    [Documentation]    This will find city name is Not available in the web page/map
    ...    Given input param: City Name in String

    Page Should Not Contain Element     xpath=//label[@for='${CityName}'][contains(.,'${CityName}')]

    #The invalid entry of City Name Label should not be displayed
    Element Should Not Be Visible       xpath=//div[@class='outerContainer'][contains(@title,'${CityName}')]

    [Teardown]      Perform Reset Button Click Action

Verify Search by City Name for a default city value
    [Arguments]    ${CityName}
    [Documentation]    This will find city name is already selected and available in the web page
    ...    Given input param: City Name in String which are by default selected and displayed in the map

    Page Should Contain Element     xpath=//label[@for='${CityName}'][contains(.,'${CityName}')]

    #Default City Name Label should be displayed on the map
    Element Should Be Visible       xpath=//div[@class='outerContainer'][contains(@title,'${CityName}')]

    [Teardown]      Perform Reset Button Click Action

Perform Reset Button Click Action
    [Documentation]    This will reset the selection of city name from the list to default values
    ...    input param: City Name in String
    Click Element       ${reset_icon_id}



