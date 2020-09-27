*** Settings ***
Documentation   *This is the common keywords file of NDTV main page
...      It contains all the required UI keywords of NDTV main page*

Library     SeleniumLibrary
Resource          ${CURDIR}${/}../config/ndtv_global_vars.robot
Resource          ${CURDIR}${/}ndtv_main_page_objects.robot

*** Keywords ***
Open Browser to NDTV Page
    [Documentation]     Opens a new browser instance to the given NDTV url.
	Open Browser     ${NDTV_URL}     ${BROWSER}
	Maximize Browser Window
	Location Should Contain     ${NDTV_URL}

Assert This Page Is NDTV Main Page
    [Documentation]    Checks whether the current page is the NDTV Main Page
    ...                and verifies the expected main page elements such as title and logo image to asser this as ndtv main page
    Wait Until Page Contains Element    ${ndtv_page_title}     timeout=${TIMEOUT}
    Page Should Contain Image   ${ndtv_page_logo}

Open NDTV Main Page
    [Documentation]     Keyword used to open NDTV URL and validate the essential page elements
    Open Browser to NDTV Page
    Assert This Page Is NDTV Main Page

Click SubMenu Icon
    [Documentation]     Navigates to the Weather Report Page by clicking the submenu ... icon
    Page Should Contain Element    ${ndtv_page_submenu}
    Click Element    ${ndtv_page_submenu}
#    Page Should Contain Element   ${weather_page_xpath}

Set Screenshots in specific output folder
    Set Screenshot Directory        ${OUTDIR}
#    File Should Exist	${CURDIR}/selenium-screenshot-1.png
#    File Should Exist	${CURDIR}/../testdata/bengaluru_search_result.JPG
#    Should Be Equal     ${CURDIR}/selenium-screenshot-1.png     ${CURDIR}/../testdata/bengaluru_search_result.JPG
#    [Teardown]      Remove File     ${OUTPUTDIR}/selenium-screenshot-1.png



