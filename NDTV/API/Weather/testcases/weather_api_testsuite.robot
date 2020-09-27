*** Settings ***
Library   Collections
Library   RequestsLibrary
Library   HttpLibrary.HTTP
Library   ${CURDIR}${/}..${/}..${/}common${/}resources${/}JsonpathLibrary.py
Library    BuiltIn
Library    String

Resource    ${CURDIR}${/}../resources/ndtv_weather_report_api_keywords.robot

Suite Teardown  Default Suite Teardown

*** Variables ***
#${TEST_DOMAIN}   ngq-func-d01.test

*** Keywords ***
Create Session of Base Endpoint
    [Documentation]    This keyword Creates session with the base api endpoint or url.
    ${status}=  Run Keyword And Return Status  Create Session  ndtv_weather_api_session     ${ndtv_weather_api_url}  auth=${API_KEY}   debug=3
    Should Be True      ${status}

Fetch All Emails API Query
    [Documentation]    This keyword is to query api call to fetch all emails for the given user
    # ${resp}=    Get Request  dlp_session   ${get_allmails}
    Connect to UI Server    ${NGQ_UI_CLUSTER[0]}
    ${resp}    ${stderr}=  Execute Command  curl --user '${ADMIN_USERNAME}:${ADMIN_PASSWORD}' -XGET '${base_query}'   return_stderr=True
    Should Contain   ${resp}    SUCCESS
    [return]    ${resp}

Create And Execute API Queries For Admin Users
    [Arguments]     ${query_string}
    [Documentation]    This keyword is to query api call to fetch all emails for the given user
    # ${resp}=    Get Request  dlp_session   ${admin_base_query}${query_string}
    Connect to UI Server    ${NGQ_UI_CLUSTER[0]}
    ${resp}    ${stderr}=  Execute Command  curl --user '${ADMIN_USERNAME}:${ADMIN_PASSWORD}' -XGET '${admin_base_query}${query_string}'   return_stderr=True
    Should Contain   ${resp}    SUCCESS
    [return]    ${resp}

Get Mail ID From response
    [Documentation]    This keyword is to get the mail id from the list of mails got as response through api call.
    [Arguments]    ${response}
    ${json}=    To Json   ${response}   pretty_print=False
    ${id_field_json_path}=   Set Variable   $.mail_list[?(@.id)].id
    ${id_list}=     Get Items By Path    ${json}    ${id_field_json_path}
    [return]    ${id_list}

Delete Email By ID
    [Arguments]    ${mail_id}
    Log    ${mail_id}    console=yes
    Connect to UI Server    ${NGQ_UI_CLUSTER[0]}
    ${delete_mail_by_ID}=     Set Variable    /v1/mails/delete
    # ${resp}=    Post Request  dlp_session   ${delete_mail}
    ${output}    ${stderr}=  Execute Command  curl -sk --user '${ADMIN_USERNAME}:${ADMIN_PASSWORD}' -H 'Content-Type: application/json' -XPOST '${ngq_api_url}${delete_mail_by_ID}' --data-binary '${mail_id}'   return_stderr=True
    Should Contain   ${output}    SUCCESS   msg=Delete Mail By ID is Successful

Delete Email By User
    [Arguments]    ${user_id}
    Log    ${user_id}    console=yes
    Connect to UI Server    ${NGQ_UI_CLUSTER[0]}
    ${delete_mail_by_User}=     Set Variable    /v1/users/delete
    # ${resp}=    Post Request  dlp_session   ${delete_mail}
    ${delete_mail_query}=   Set Variable   ${admin_base_query}${delete_mail_by_User}
    ${output}    ${stderr}=  Execute Command  curl -sk --user '${ADMIN_USERNAME}:${ADMIN_PASSWORD}' -H 'Content-Type: application/json' -XPOST '${delete_mail_query}' --data-binary '[${user_id}]'   return_stderr=True
    Should Contain   ${output}    SUCCESS   msg=Delete Mail By User is Successful

Preview Email By ID
    [Arguments]     ${mail_id}
    Log    ${mail_id}    console=yes
    Connect to UI Server    ${NGQ_UI_CLUSTER[0]}
    ${output}    ${stderr}=  Execute Command  curl -sk --user '${ADMIN_USERNAME}:${ADMIN_PASSWORD}' -XGET '${ngq_api_url}${preview_mail}?q=${mail_id}'   return_stderr=True
    Should Contain   ${output}    SUCCESS   msg=Preview Mail By ID query executed...
    [Return]    ${output}

Release Email By ID
    [Arguments]     ${mail_id}
    Connect to UI Server    ${NGQ_UI_CLUSTER[0]}
    ${release_mail_by_ID}=     Set Variable    /v1/mails/release
    ${output}    ${stderr}=  Execute Command  curl -sk --user '${ADMIN_USERNAME}:${ADMIN_PASSWORD}' -H 'Content-Type: application/json' -XPOST '${ngq_api_url}${release_mail_by_ID}' --data-binary '${mail_id}'   return_stderr=True
    Should Contain   ${output}    SUCCESS   msg=Release Mail By ID is Successful


*** Testcases ***

Verify Admin Domain API Call with q param of email subject
    [Tags]  DLPTC11
    [Documentation]  Verify Admin Domain API Call with q parameter of eemail subject

    ${localsubject}=    Get Unique Subject   DLPTC11-SubjectSearch
    ${email_sender}=   Generate Unique Local Sender     ${sender_name}
    Spew Mail     ${email_sender}    ${ADMIN_USERNAME}   ${localsubject}   ${SPAM_TYPE}

    ${response}=  Create And Execute API Queries For Admin Users    &q=(email_subject.raw:"${localsubject}")
    ${json}=    To Json   ${response}   pretty_print=False
    ${id_field_json_path}=   Set Variable   $.mail_list[?(@.metadata.email_subject=="${localsubject}")].id
    ${id_values}=     Get Items By Path    ${json}    ${id_field_json_path}
    Should Not Be Empty    ${id_values}
