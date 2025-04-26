*** Settings ***
Documentation     Keywords for the Login Module
Library           OperatingSystem
Library           SeleniumLibrary
Resource          Login_Variables.resource

*** Keywords ***
Navigate To Site
    [Documentation]    The user opens a browser and navigates to the site.
    [Arguments]    ${url}    ${browser}
    Open Browser    ${url}    ${browser}
    Maximize Browser Window

Quit Browser
    [Documentation]    Closes browser after delay
    Sleep    0.5s
    Close All Browsers

The User Navigates To Signin Page Of Saucedemo
    [Documentation]    Test if the user was able to view login modal and check if login modal and MT logo is displayed
    Title Should Be    ${TITLE_INVENTORY}
    Wait Until Element Is Visible   ${MODAL_LOGIN}    30s

The User Logs In Using "${username}" And "${password}" Credentials
    [Documentation]    Input Credentials
    Wait Until Element Is Visible   ${TB_USERNAME}    30s
    Input Text    ${TB_USERNAME}    ${username}
    Input Password    ${TB_PASSWORD}    ${password}
    Click Button    ${BTN_LOGIN}

An Error Message "${error_msg}" Should Be Displayed
    [Documentation]    Check if the error message will appear
    ...    COM-2 & COM-3: Username and password fields only accepts valid credentials
    Set Test Variable    ${VALIDATION_ERROR_MESSAGE}    //*[contains(text(),'${error_msg}')]
    Wait Until Element Is Visible    ${VALIDATION_ERROR_MESSAGE}    30s
    Element Should Be Visible    ${VALIDATION_ERROR_MESSAGE}
    ${count_error_msg}    SeleniumLibrary.Get Element Count    ${VALIDATION_ERROR_MESSAGE}
    Should Be Equal As Integers    ${count_error_msg}    1

The User Should Be Able To Login Successfully And Redirect To Inventory Page
    [Documentation]    Test if the user is successful in logging in
    Title Should Be    ${TITLE_INVENTORY}
    Location Should Be    ${LINK_INVENTORY}

The User Should Not Be Able To Login
    [Documentation]    Test if the user is unsuccessful in logging in
    Location Should Contain   ${LINK_SAUCEDEMO} 
    Element Should Be Visible    ${MODAL_LOGIN}

The User Inspects The "${field}" Field And Placeholder Should Be Displayed
    [Documentation]    Test if the user was able to see Txt Field with correct Placeholder
    Wait Until Element Is Visible    ${TXT_${field}}   30s
    ${field_placeholder}    SeleniumLibrary.Get Element Attribute    ${TXT_${field}}    placeholder
    Should Be Equal As Strings    ${field}    ${field_placeholder}

Inventory Page Should Be Displayed Correctly
    [Documentation]    Vefiry the unique objects on Inventory page 
    Wait Until Element Is Visible    ${MODAL_PRODUCT}
    Element Should Be Visible    ${HEADER_INVENTORYPAGE}
    Element Should Be Visible    ${SUBHEADER_INVENTORYPAGE}
    Element Should Be Visible    ${FOTTER_INVENTORYPAGE} 