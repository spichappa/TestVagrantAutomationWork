*** Settings ***
Documentation     List of Weather Report Page Elements of the NDTV web application

*** Variables ***

${weather_page_title_img}   xpath://img[@src='./images/ndtv_logo.png']
${map_img}      id=map_canvas
${pin_city_logo}    xpath://img[@src='./images/ndtv_logo.png']
${pin_your_city_msg}     xpath://span[@class='message_holder_header'][contains(.,'Pin your City')]
${reset_icon_id}       id=icon_holder
${search_box_id}     id=searchBox
${cityList_parent_element}      css=#messages
${cityList_dropdown_element}    css=#messages>.message
${default_city_name}        Bengaluru


