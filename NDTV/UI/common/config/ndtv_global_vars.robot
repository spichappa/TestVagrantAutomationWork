*** Settings ***
Documentation     List of Global Page Elements of the NDTV web application

*** Variables ***

#Global Parameters

${TIMEOUT}  	1min
${RETRY}	5s
${Browser}   chrome
${OUTPUTDIR}        ${CURDIR}../testresults

${ndtv_url}     https://www.ndtv.com/
${ndtv_page_title}       xpath://a[@href='https://www.ndtv.com']
${ndtv_page_logo}       xpath:/html/body/div[2]/div/div/div/div/div[1]/a/img
${ndtv_page_submenu}       id=h_sub_menu
${weather_page_url}     https://social.ndtv.com/static/Weather/report/?pfrom=home-topsubnavigation
${weather_page_xpath}   xpath://a[contains(.,'WEATHER')]









