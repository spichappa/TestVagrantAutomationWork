*** Settings ***
Documentation     List of Weather Report Page Elements of the NDTV web application

*** Variables ***

${weather_page_title_img}   xpath://img[@src='./images/ndtv_logo.png']
${info_heder}       xpath://div[@class='infoHolder'][contains(.,'Current weather conditions in your city.')]
${full_map_page}    xpath://div[contains(@class,'leaflet-container leaflet-touch leaflet-retina leaflet-fade-anim leaflet-grab leaflet-touch-drag leaflet-touch-zoom')]
${map_img}      id=map_canvas
${pin_city_logo}    xpath://img[@src='./images/ndtv_logo.png']
${pin_your_city_msg}     xpath://span[@class='message_holder_header'][contains(.,'Pin your City')]
${reset_icon_id}       id=icon_holder
${search_box_id}     id=searchBox
${cityList_parent_element}      css=#messages
${cityList_dropdown_element}    css=#messages>.message
${map_city_selector}    xpath://div[contains(@title,'${default_city_name}')]

#Scalar Values

${default_city_name}        Bengaluru
${non_default_city_name}        Amritsar
${invalid_city_name}        Tokyo
@{default_city_lists}    Bengaluru  Bhopal  Chennai  Hyderabad  Kolkata  Lucknow  Mumbai  New Delhi  Patna  Srinagar  Visakhapatnam
${IS_DEFAULT_CITY_VALUE}     N








