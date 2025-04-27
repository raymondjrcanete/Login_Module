*** Settings ***
Documentation    Variables for the Login Module


*** Variables ***

${BROWSER}                        Chrome
# Login
${LINK_SAUCEDEMO}                 https://www.saucedemo.com/
${LINK_INVENTORY}                 https://www.saucedemo.com/inventory.html
${TITLE_INVENTORY}                Swag Labs
${MODAL_LOGIN}                    //div[@class='login_wrapper-inner']
${TB_USERNAME}                    //input[@id='user-name']
${TB_PASSWORD}                    //input[@id='password']
${BTN_LOGIN}                      //input[@id='login-button']

#CREDENTIALS
${VALID_USERNAME}                 standard_user
${VALID_PASSWORD}                 secret_sauce
${INVALID_USERNAME}               invalid_user
${INVALID_PASSWORD}               invalid_password
${NULL_USERNAME}
${NULL_PASSWORD}

#ERROR_MESSAGES
${INVALID_CREDENTIAL}             //h3[contains(text(),'Epic sadface: Username and password do not match a')]
${ERR_NULL_PASSWORD}              //h3[normalize-space()='Epic sadface: Password is required']
${ERR_NULL_USERNAME}              //h3[normalize-space()='Epic sadface: Username is required']

#Inventory PAge
${MODAL_PRODUCT}                 //div[@class='inventory_list']
${HEADER_INVENTORYPAGE}          //div[@class='app_logo']
${SUBHEADER_INVENTORYPAGE}       //div[@class='header_secondary_container']
${FOTTER_INVENTORYPAGE}          //footer[@class='footer']
${BMENU_INVENTORYPAGE}           //button[@id='react-burger-menu-btn']
${BTN_LOGOUT}                    //a[@id='logout_sidebar_link']
${LIST_PRODUCT_PRICE}            //div[contains(@class, 'inventory_item_price')]
${LIST_PRODUCT_NAME}             //div[contains(@class, 'inventory_item_name')]
${DD_A_TO_Z}                     //option[@value='az']
${DD_Z_TO_A}                     //option[@value='za']
${BTN_SORT}                      //select[@class='product_sort_container']

${chrome_options}    --disable-blink-features=AutomationControlled --disable-password-manager-reauthentication