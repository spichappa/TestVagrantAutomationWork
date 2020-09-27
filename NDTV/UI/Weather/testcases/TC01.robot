*** Settings ***
Library     SeleniumLibrary

Resource    ${CURDIR}${/}../../common/keywords/ndtv_main_page_keywords.robot

*** Variables ***

*** Keywords ***


*** Test Cases ***
TC01
    [Tags]      TC01
    Open Browser to NDTV Page
    Assert This Page Is NDTV Main Page
    [Teardown]   Close Browser







