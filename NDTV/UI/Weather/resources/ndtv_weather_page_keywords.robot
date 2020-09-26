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

Assert Click City Action renders the corresponding Weather Details on map
    Set Screenshot Directory        ${CURDIR}
    Capture Page Screenshot     ${CURDIR}
    File Should Exist	${CURDIR}/selenium-screenshot-1.png
    File Should Exist	${CURDIR}/../testdata/bengaluru_search_result.JPG
    Should Be Equal     ${CURDIR}/selenium-screenshot-1.png     ${CURDIR}/../testdata/bengaluru_search_result.JPG
    [Teardown]      Remove File     ${OUTPUTDIR}/selenium-screenshot-1.png

Navigate to Weather Report Page
    [Documentation]     Keyword used to navigate to Weather Report Page of NDTV site
    Open NDTV Main Page
    Click SubMenu Icon
    Go To Weather Menu
    Assert Weather Page Has Rendered Fully

Check Input City Type and Return isDefault Value
    [Arguments]    ${CityName}
    [Documentation]    This will verify whether the input city name is a default value type
    ...    Given input param: City Name in String
    ...    Return output param:  Y or N

    ${default_cityList_length}=     Get List Size   @{default_city_lists}

    :FOR   ${row}  IN RANGE  1  ${default_cityList_length}
	 \    ${get_default_city_item}=   Get Text      ${default_cityList_length}[${row}]
	 \    ${status}=   Run Keyword and return status   Should Contain  ${get_default_city_item}   ${CityName}
     \    Exit For Loop If  "${status}" == "True"

     ${city_type}=    Set Variable If     "${status}" == "True"   Y
                            ...     "${status}" == "False"   N
     [return]       ${city_type}

Perform Search By City Action
    [Arguments]    ${CityName}      ${isDefaultValue}=${IS_DEFAULT_CITY_VALUE}
    [Documentation]    This will perform search action by city name
    ...    Given input param: City Name in String

    Navigate to Weather Report Page
    Page Should Contain Element    ${cityList_parent_element}
    ${listCount}=    Get Element Count    ${cityList_dropdown_element}
    Should Be Equal As Integers     ${listCount}        ${cityCountValue}

    Wait Until Element is Visible		${map_img}   ${TIMEOUT}
    Wait Until Element is Visible		${full_map_page}   ${TIMEOUT}

    #Before Search, City Name Label should not be displayed for a non-default city pin and vice-versa for a default city pin

    Run Keyword If      '${isDefaultValue}' == 'N'      Element Should Not Be Visible       xpath=//div[@class='outerContainer'][contains(@title,'${CityName}')]
    ...     ELSE IF     '${isDefaultValue}' == 'Y'      Element Should Be Visible       xpath=//div[@class='outerContainer'][contains(@title,'${CityName}')]

    Input Text      ${search_box_id}       ${CityName}
    Press Keys      ${search_box_id}      ENTER

Perform Reset Button Click Action
    [Documentation]    This will reset the selection of city name from the list to default values
    ...    input param: City Name in String
    Click Element       ${reset_icon_id}

Verify City Elements Visibility upon Search Action
    [Arguments]    ${CityName}      ${isDefaultCity}=N
    [Documentation]    This will find city name is available in the web page/map
    ...    Given input param: City Name in String

    Run Keyword If      '${isDefaultCity}' == 'Y'       Element Should Be Visible       xpath=//div[@class='outerContainer'][contains(@title,'${CityName}')]
    ...		ELSE If     '${isDefaultCity}' == 'N'    Element Should Not Be Visible       xpath=//div[@class='outerContainer'][contains(@title,'${CityName}')]

    Run Keyword If      '${isDefaultCity}' == 'Y'       Page Should Contain Element     xpath=//label[@for='${CityName}'][contains(.,'${CityName}')]
    ...		ELSE If     '${isDefaultCity}' == 'N'      Validate Pin City data upon Selection       ${CityName}

    #After Search, City Name Label should not be displayed
    [Teardown]      Perform Reset Button Click Action

Validate Pin City data upon Selection
    [Arguments]    ${CityName}
    [Documentation]    This Keyword is to validate Pin City date upon Search Operation/Selection
    ...    Given input param: City Name in String

    Page Should Contain Element     xpath=//label[@for='${CityName}'][contains(.,'${CityName}')]
    Click Element       xpath=//label[@for='${CityName}'][contains(.,'${CityName}')]
    Element Should Be Visible       xpath=//div[@class='outerContainer'][contains(@title,'${CityName}')]

Verify Temperature Values are Visible or not for the Pin City
    [Arguments]    ${CityName}      ${isDefaultCity}=N      ${isSearched}=N
    [Documentation]    This will find both degree and farenheit celsious values of the city name are displayed already in the map
    ...    Given input param 01: CityName,   input type: String
    ...    Given input param 02: isDefaultCity,   input type: Single Char Values either 'Y' or 'N'
    ...    Given input param 03: isSelected,   input type: Single Char Values either 'Y' or 'N'

    ####Selected or Default City Name Labels and temperature values should be displayed on the map
    #Page Should Contain Element     xpath=//label[@for='${CityName}'][contains(.,'${CityName}')]

    Run Keyword If      '${isDefaultCity}' == 'Y'       Run Keyword If      '${isSearched}' == 'Y'      Element Should Be Visible       xpath=//div[@class='outerContainer'][contains(@title,'${CityName}')]
    ...     ELSE IF     '${isDefaultCity}' == 'N'       Element Should Not Be Visible       xpath=//div[@class='outerContainer'][contains(@title,'${CityName}')]

    Run Keyword If      '${isDefaultCity}' == 'Y'       Element Should Be Visible       xpath=//div[@class='outerContainer'][contains(@title,'${CityName}')]
    ...     ELSE IF     '${isDefaultCity}' == 'N'       Element Should Not Be Visible       xpath=//div[@class='outerContainer'][contains(@title,'${CityName}')]

    Run Keyword If  '${isDefaultCity}' == 'Y'      Element Should Be Visible       xpath=//div[@class='outerContainer'][contains(@title,'${CityName}')]
    ...     ELSE IF     '${isDefaultCity}' == 'N'       Run Keyword If      '${isSearched}' == 'Y'      Element Should Not Be Visible       xpath=//div[@class='outerContainer'][contains(@title,'${CityName}')]
