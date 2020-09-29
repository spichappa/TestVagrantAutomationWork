*** Settings ***
Documentation   *This is the common keywords file of NDTV Weather Report page
...      All required keywords of NDTV Weather Report page*

Library     SeleniumLibrary
Resource          ${CURDIR}${/}../../common/config/ndtv_global_vars.robot
Resource          ${CURDIR}${/}../../common/keywords/ndtv_main_page_keywords.robot
Resource          ${CURDIR}${/}ndtv_weather_report_page_objects.robot

*** Variables ***
${cityCountValue}       86

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

Go To Weather Menu
    [Documentation]    Keyword used to Click on the Weather Menu present in the NDTV main page

    Wait Until Element Is Visible    ${weather_page_xpath}     timeout=${TIMEOUT}
    Click Element    ${weather_page_xpath}
    Location Should Contain     ${WEATHER_PAGE_URL}

Assert Weather Page Has Rendered Fully
    [Documentation]     It verifies all the major page elements of Weather Report Page have rendered properly

    Wait Until Element Is Visible    ${weather_page_title_img}     timeout=${TIMEOUT}
    Wait Until Page Contains Element    ${map_img}     timeout=${TIMEOUT}
    Wait Until Page Contains Element    ${full_map_page}     timeout=${TIMEOUT}
    Page Should Contain Element   ${map_img}
    Page Should Contain Element   ${full_map_page}

Navigate to Weather Report Page
    [Documentation]     Keyword is used to navigate to Weather Report Page of NDTV site

    Click SubMenu Icon
    Go To Weather Menu
    Assert Weather Page Has Rendered Fully

Perform Search By City Name Action      [Arguments]    ${CityName}      ${isDefaultValue}=${IS_DEFAULT_CITY_VALUE}
    [Documentation]    It is used to search by city names with different types such default, non-default, invalid values
    ...                input params 1: City Name, type: String
    ...                             2: City Type, type: Boolean i.e. Y or N
    ...                output value : returns true or false
    ...                Test Steps:  1. Verifies the visibility of the given City Name's checkbox based on the input param ${isDefaultValue} value
    ...                             2. Enter the input city name and press enter key for search action to perform
    ...                             3. Return 'true' if the city name is present in the dropdown else return false

    Run Keyword If      '${isDefaultValue}' == 'N'      Element Should Not Be Visible       xpath=//div[@class='outerContainer'][contains(@title,'${CityName}')]
    ...     ELSE IF     '${isDefaultValue}' == 'Y'      Element Should Be Visible       xpath=//div[@class='outerContainer'][contains(@title,'${CityName}')]
    Input Text      ${search_box_id}       ${CityName}
    Press Keys      ${search_box_id}      ENTER

    ${search_result} =   Run Keyword and Return Status       Page Should Contain Element     ${cityList_dropdown_element}

	[return]   ${search_result}

Check Input City Type and Return isDefault Value      [Arguments]    ${CityName}
    [Documentation]    This will verify whether the input city name falls under default value type and return the isDefault(Y/N) value respectively
    ...    Given input param: City Name in String
    ...    Return output param:  Y or N

    ${get_list_length}=     Get Length     ${DEFAULT_CITY_LISTS}
    should be equal as integers     ${get_list_length}      ${TOTAL_DEFAULT_CITIES_COUNT}

    FOR   ${get_ListItems}  IN  ${DEFAULT_CITY_LISTS}
	${status}=   Run Keyword and return status   Should Contain     ${get_ListItems}   ${CityName}
    Exit For Loop If  "${status}" == "True"
    END

    ${city_IsDefault}=    Set Variable If     "${status}" == "True"   Y
                            ...     "${status}" == "False"   N
     [return]       ${city_IsDefault}

Validate City is available on the map with temperature information
    [Arguments]    ${CityName}
    [Documentation]    This Keyword is to validate Pin City date in the map upon Search Operation/Selection
    ...                input param: City Name in String

    #Fetch the isDefault value for the input city name by cross checking in the default city name lists.
    ${city_IsDefault_value}=     Check Input City Type and Return isDefault Value    ${CityName}
    log to console      ${city_IsDefault_value}

    #Before Selection, check the presence of city data available on the map for default city
    Run Keyword If    '${city_IsDefault_value}'=='N'          Page Should Not Contain Element     ${map_city_name}\[contains(.,'${CityName}')]
#    ...     Else IF      '${city_IsDefault_value}'=='Y'          Page Should Contain Element     ${map_city_name}\[contains(.,'${CityName}')]

    #Do select the checkbox of the non-default cityname to verify its specific value
    Run Keyword If      '${city_IsDefault_value}'=='N'          Click Element       xpath=//label[@for='${CityName}'][contains(.,'${CityName}')]

    Page Should Contain Element     ${map_city_name}\[contains(.,'${CityName}')]
    Page Should Contain Element     ${map_city_tempC}
    Page Should Contain Element     ${map_city_tempF}

    ${get_city_value}=      Get Text        ${map_city_name}\[contains(.,'${CityName}')]
    ${get_temp_celsius}=      Get Text        ${map_city_tempC}
    ${get_temp_fahrenheit}=      Get Text        ${map_city_tempF}
    should be equal     ${get_city_value}       ${cityName}
    should not be empty     ${get_temp_celsius}
    ${status}=      Run Keyword and Return Status   should not be empty     ${get_temp_fahrenheit}
    [return]    ${status}

Verify Temperature Values are Visible or not for the Pin City
    [Arguments]    ${CityName}      ${isDefaultCity}=N
    [Documentation]    This will find both degree and farenheit celsious values of the city name are displayed already in the map
    ...    Given input param 01: CityName,   input type: String
    ...    Given input param 02: isDefaultCity,   input type: Single Char Values either 'Y' or 'N'

    Run Keyword If      '${isDefaultCity}' == 'Y'       Element Should Be Visible       xpath=//div[@class='outerContainer'][contains(@title,'${CityName}')]
    ...     ELSE IF     '${isDefaultCity}' == 'N'       Element Should Not Be Visible       xpath=//div[@class='outerContainer'][contains(@title,'${CityName}')]

Fetch Weather Details for a city       [Arguments]    ${CityName}
    [Documentation]    This will fetch all weather details of the city name are displayed already in the map for default Element

    Element Should Be Visible       xpath=//div[@class='outerContainer'][contains(@title,'${CityName}')]
    Element Should Be Visible       xpath=//div[@class='outerContainer'][contains(.,'${CityName}')]

    #Before Test Action #1: The Main Pane Element Should not be present in the page
    Page Should Not Contain Element     ${city_map_weather_panel}\[contains(.,'${CityName}')]

    #Before Test Action #2: When the City is not Selected, the pane count will be 0
    ${pane_count}=  Get Element Count       ${city_map_weather_panel}
    should be equal as integers     ${pane_count}      0

    Wait Until Keyword Succeeds		${TIMEOUT}	${RETRY}	Click Element       xpath=//div[@class='outerContainer'][contains(@title,'${CityName}')]

    #Test Verification Step #1: If a city is selected, then the count of the pane gets incremented as 1
    ${pane_count}=  Get Element Count       ${city_map_weather_panel}
    should be equal as integers     ${pane_count}      1

    ${weather_details_rendered}=    Run Keyword and Return Status       Element Should Be Visible     ${city_map_weather_panel}\[contains(.,'${CityName}')]
    Should Be True    ${weather_details_rendered}
    Wait Until Keyword Succeeds		${TIMEOUT}	${RETRY}	    Element Should Be Visible     ${city_map_weather_panel}\[contains(.,'Condition :')]
    Wait Until Keyword Succeeds		${TIMEOUT}	${RETRY}	    Element Should Be Visible     ${city_map_weather_panel}\[contains(.,'Wind:')]
    Wait Until Keyword Succeeds		${TIMEOUT}	${RETRY}	    Element Should Be Visible     ${city_map_weather_panel}\[contains(.,'Humidity:')]
    Wait Until Keyword Succeeds		${TIMEOUT}	${RETRY}	    Element Should Be Visible     ${city_map_weather_panel}\[contains(.,'Temp in Degrees:')]
    Wait Until Keyword Succeeds		${TIMEOUT}	${RETRY}	    Element Should Be Visible     ${city_map_weather_panel}\[contains(.,'Temp in Fahrenheit:')]

    ${get_resultData}=     Get Text       ${city_map_weather_panel}\[contains(.,'Temp in Degrees:')]

    ${get_celsius_text}=        Get Text    ${temp_celsius_path}
    ${get_fahrenheit_text}=        Get Text    ${temp_fahrenheit_path}

    Hide Weather Pane upon clicking the close button

    ${get_temperature_celsius}=    Find Temperature Value from the output       ${get_celsius_text}
    ${get_temperature_fahrenheit}=    Find Temperature Value from the output       ${get_fahrenheit_text}

#    &{city_weather_details} =	    Create Dictionary	key=${TEST_CITY_NAME}	cityName=${TEST_CITY_NAME}      cityID=${TEST_CITY_ID}      tempFahrenheit=${get_temperature_fahrenheit}      tempCelsius=${get_temperature_celsius}
    [Return]        ${get_temperature_celsius}

Find Temperature Value from the output      [Arguments]         ${inputData}
    [Documentation]     To fetch the temperature degree value from the inputResult and return the temperature value

    @{words} =	Split String	${inputData}	:
    ${temp_val}=     Strip String        ${words[1]}
    log to console      ${temp_val}
    [Return]        ${temp_val}

Hide Weather Pane upon clicking the close button
    [Documentation]     It is used to hide the rendered weather details of a city when clicked again

#    Wait Until Keyword Succeeds		${TIMEOUT}	${RETRY}	Click Element       xpath=//div[@class='outerContainer'][contains(@title,'${CityName}')]
    Wait Until Keyword Succeeds		${TIMEOUT}	${RETRY}	Click Element       ${weather_panel_close_button}

Perform Reset Button Click Action
    [Documentation]    It resets the selection of city name from the list to default values
    Click Element       ${reset_icon_id}

