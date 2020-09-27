*** Settings ***
Documentation     List of Weather Report Page Elements of the NDTV website

*** Variables ***

${WEATHER_PAGE_URL}     https://social.ndtv.com/static/Weather/report/?pfrom=home-topsubnavigation

${info_heder}       xpath://div[@class='infoHolder'][contains(.,'Current weather conditions in your city.')]
${full_map_page}    xpath://div[contains(@class,'leaflet-container leaflet-touch leaflet-retina leaflet-fade-anim leaflet-grab leaflet-touch-drag leaflet-touch-zoom')]
${map_img}      xpath://div[contains(@id,'map_canvas')]
${pin_city_logo}    xpath://img[@src='./images/ndtv_logo.png']
${pin_your_city_msg}     xpath://span[@class='message_holder_header'][contains(.,'Pin your City')]
${reset_icon_id}       id=icon_holder
${search_box_id}     id=searchBox
${cityList_parent_element}      css=#messages
${cityList_dropdown_element}    css=#messages>.message
${dropdown_message_panel}       //div[@class='message']

${map_city_selector}    xpath://div[contains(@title,'${DEFAULT_CITY_NAME}')]
${map_city_name}        xpath://div[@class='cityText']
${map_city_tempC}       xpath://span[@class='tempRedText']
${map_city_tempF}       xpath://span[@class='tempWhiteText']
${city_map_weather_panel}   xpath://div[@class='leaflet-popup-content-wrapper']
${weather_panel_close_button}   xpath://a[@class='leaflet-popup-close-button']

###########################################Scalar Values##########################################
${DEFAULT_CITY_NAME}        Bengaluru
${NON_DEFAULT_CITY_NAME}        Amritsar
${INVALID_CITY_NAME}        Tokyo
@{DEFAULT_CITY_LISTS}    Bengaluru  Bhopal  Chennai  Hyderabad  Kolkata  Lucknow  Mumbai  New Delhi  Patna  Srinagar  Visakhapatnam
${TOTAL_DEFAULT_CITIES_COUNT}     11
${IS_DEFAULT_CITY_VALUE}     N
${VALIDSEARCH}      ValidSearch
${IN_VALIDSEARCH}   InValidSearch



