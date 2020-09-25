*** Settings ***
Library     SeleniumLibrary


Suite Setup     Open Browser To NDTV Page
Suite Teardown      Close All Browsers
Test Setup        Go To Weather Page by URL

*** Variables ***


*** Keywords ***

*** Test Cases ***

LoginPage Test

    Login 

