*** Settings ***
Documentation     Test Suite for the Login Module
...               The purpose of this test is to verify the Login Page.
...               Validate the Invalid Credentials, and Error messages
Resource          Resources/Login_Keywords.resource
Test Setup        Navigate To Site   ${LINK_SAUCEDEMO}      ${BROWSER}
Test Teardown     Quit Browser


*** Test Cases ***
login Test001: User should not be able to login if an invalid credentials are entered
    Given The User Navigates To Signin Page Of Saucedemo
    When The User Logs In Using "${INVALID_USERNAME}" And "${INVALID_PASSWORD}" Credentials
    Then An Error Message "Username and password do not match" Should Be Displayed
    And The User Should Not Be Able To Login

login Test002: User should not be able to login if an invalid password is entered
    Given The User Navigates To Signin Page Of Saucedemo
    When The User Logs In Using "${VALID_USERNAME}" And "${INVALID_PASSWORD}" Credentials
    Then An Error Message "Username and password do not match" Should Be Displayed
    And The User Should Not Be Able To Login

login Test003: User should not be able to login using a null username    
    Given The User Navigates To Signin Page Of Saucedemo
    When The User Logs In Using "${NULL_USERNAME}" And "${VALID_PASSWORD}" Credentials
    Then An Error Message "Username is required" Should Be Displayed
    And The User Should Not Be Able To Login

login Test004: User should not be able to login using a null Password
    Given The User Navigates To Signin Page Of Saucedemo
    When The User Logs In Using "${VALID_USERNAME}" And "${NULL_PASSWORD}" Credentials
    Then An Error Message "Password is required" Should Be Displayed
    And The User Should Not Be Able To Login

login Test005: User should not be able to login using null username and password
    #For Clarification if the current error message is the expected result
    Given The User Navigates To Signin Page Of Saucedemo
    When The User Logs In Using "${NULL_USERNAME}" And "${NULL_PASSWORD}" Credentials
    Then An Error Message "username and Password are required" Should Be Displayed
    And The User Should Not Be Able To Login

login Test006: User logs in successfully with valid username and password
    Given The User Navigates To Signin Page Of Saucedemo
    When The User Logs In Using "${VALID_USERNAME}" And "${VALID_PASSWORD}" Credentials
    Then The User Should Be Able To Login Successfully And Redirect To Inventory Page
    And Inventory Page Should Be Displayed Correctly
