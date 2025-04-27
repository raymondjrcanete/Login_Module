*** Settings ***
Documentation     Keywords for the Login Module
Library           OperatingSystem
Library           SeleniumLibrary
Library           RPA.FileSystem 
Library           Collections
Resource          SD_Inventory_Variables.resource

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

The User Already Logged In To Saucedemo
    [Documentation]  precondtions already logged in users
    The User Logs In Using "${VALID_USERNAME}" And "${VALID_PASSWORD}" Credentials

The User Clicks The Burger Menu
    [Documentation]  to verify burgermenu and its options 
    Element Should Be Visible    ${BMENU_INVENTORYPAGE}
    Click Element    ${BMENU_INVENTORYPAGE}


The User Select Sort Options Alphabetically "${sort_option}"
    [Documentation]    Verify that the discussions/products are sorted alphabetically
# Select the sorting option
    Set Suite Variable    ${SORT_OPTION}    ${sort_option}
    Run Keyword If    "${sort_option}" == "A to Z"    Click Element    ${DD_A_TO_Z}
    Run Keyword If    "${sort_option}" == "Z to A"    Click Element    ${DD_Z_TO_A}

Verify Items Are Sorted Based On The Sort Option
    [Documentation]    Verify that the product titles are sorted alphabetically based on sort_option
    # Get all the item titles
    @{items_titles}=    Get WebElements    ${LIST_PRODUCT_NAME} 
    @{titles}=    Create List
    FOR    ${element}    IN    @{items_titles}
        ${title}=    Get Text    ${element}
        Append To List    ${titles}    ${title}
    END
    ${sorted_titles}=    Copy List    ${titles}
    Sort List    ${sorted_titles}
    # Reverse the sorted list only if sort_option is Z to A
    Run Keyword If    "${SORT_OPTION}" == "Z to A"    Reverse List    ${sorted_titles}
    # Validate
    Lists Should Be Equal    ${titles}    ${sorted_titles}


The User Select Sort Options By Price "${sort_option2}"
    [Documentation]    Verify that the products are sorted by price
    Set Selenium Speed    1s
    Set Suite Variable    ${SORT_OPTION2}    ${sort_option2}
    
    # Make sure the dropdown is clicked properly
    Wait Until Element Is Visible    ${BTN_SORT} 
    Click Element    ${BTN_SORT} 

    Run Keyword If    "${sort_option2}" == "LOW to HIGH"    
    ...    Select From List By Value    ${BTN_SORT}     lohi
    
    Run Keyword If    "${sort_option2}" == "HIGH to LOW"    
    ...    Select From List By Value    ${BTN_SORT}     hilo

Verify Product Prices Are Sorted By Selected Price Option
    [Documentation]    Verify that the product prices are sorted based on sort option
    # Get all the item prices
    @{items_price}=    Get WebElements    ${LIST_PRODUCT_PRICE}
    @{prices}=    Create List
    FOR    ${element}    IN    @{items_price}
        ${price_text}=    Get Text    ${element}
        ${price}=    Evaluate    ${price_text}[1:]    # Manually remove the first character ($)
        ${price}=    Convert To Number    ${price}
        Append To List    ${prices}    ${price}
    END

    ${sorted_prices}=    Copy List    ${prices}
    Sort List    ${sorted_prices}
    # Reverse the sorted list only if sort option is HIGH to LOW
    Run Keyword If    "${SORT_OPTION2}" == "HIGH to LOW"    Reverse List    ${sorted_prices}
    # Validate
    Lists Should Be Equal    ${prices}    ${sorted_prices}

The User Clicks The Logout Button
    [Documentation]    CLicking of Logout button
    Set Selenium Speed    2s
    The User Clicks The Burger Menu
    Click Element    ${BTN_LOGOUT}
