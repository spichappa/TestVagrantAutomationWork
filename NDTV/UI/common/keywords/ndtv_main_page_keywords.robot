*** Settings ***
Documentation   *This is the common keywords file of NDTV main page
...      All required keywords of NDTV main page*

Library     SeleniumLibrary
Resource          ${CURDIR}${/}../config/ndtv_global_vars.robot

*** Keywords ***

Open Browser to NDTV Page
	Open Browser     ${ndtv_url}     ${Browser}

Assert This Page Is NDTV Main Page
    [Documentation]    Check whether the current page is the NDTV Main Page with its title
    Wait Until Page Contains Element    ${ndtv_page_title}     timeout=${TIMEOUT}
    Page Should Contain Image    ${ndtv_page_logo}

Open NDTV Main Page
    [Documentation]     Keyword used to open NDTV URL and validate the page element
    Open Browser to NDTV Page
    Assert This Page Is NDTV Main Page

Click SubMenu Icon
    Page Should Contain Element    ${ndtv_page_submenu}
    Click Element    ${ndtv_page_submenu}
    Page Should Contain Element   ${weather_page_xpath}





