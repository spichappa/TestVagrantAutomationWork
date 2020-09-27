*** Settings ***
Documentation   This is the keyword file for ndtv weather report api

Library   Collections
Library   RequestsLibrary
Library   HttpLibrary.HTTP
Library   ${CURDIR}${/}..${/}..${/}common${/}lib${/}JsonpathLibrary.py
Library    BuiltIn
Library    String

Resource   ${CURDIR}${/}ndtv_weather_api_objects.robot

Suite Teardown  Default Suite Teardown

*** Variables ***
${TEST_CITY_VALUE}      BENGALURU


*** Keywords ***
Default Suite Teardown
   Close ALL Connections


