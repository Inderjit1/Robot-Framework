*** Settings ***
Library  SeleniumLibrary
Documentation    Suite description
Variables  ../../CustomLibrary/properties.py


*** Keywords ***
Log On To Site
   Input Text   id=username     ${USERNAME}
   Input Text   id=password     ${PASSWORD}
   Click Button    xpath=//*[@id="loginForm"]/div[6]/div[3]/div/input

   Wait Until Page Contains Element    xpath=//*[@id="mainPanel"]/div[2]/ad-base-admin-app/div/dx-split-view/div/div[1]/div/dx-split-view-first/div/dashboard-page/dx-single-column-view/div/div[2]/div/dx-loading/div/div/ng-transclude/ng-transclude/dx-single-column-content/div[1]/counter-tiles/section/ul/div[2]/div[2]/a  120s
   Click Element    xpath=//*[@id="mainPanel"]/div[2]/ad-base-admin-app/div/dx-split-view/div/div[1]/div/dx-split-view-first/div/dashboard-page/dx-single-column-view/div/div[2]/div/dx-loading/div/div/ng-transclude/ng-transclude/dx-single-column-content/div[1]/counter-tiles/section/ul/div[2]/div[2]/a

Verify Database Instance
    Wait Until Page Contains Element    xpath=//*[@title=${TARGET_DB}]
    ${target_db_value}=     Get Value   xpath=//*[@title=${TARGET_DB}]
    Log     ${target_db_value}
    Should Be Equal As Strings    ${target_db_value}    ${TARGET_DB}
    ${result}=  Element Text Should Be       xpath=//*[@title=${TARGET_DB}]        ${TARGET_DB}
    Log     ${result}

Select Database to Clone
    # Clicks on Expand All
    Wait Until Page Contains Element    xpath=//*[@id="mainPanel"]/div[2]/ad-base-admin-app/div/dx-split-view/div/div[1]/div/dx-split-view-first/div/container-page/dx-two-column-view/div/div[1]/ng-transclude/dx-two-column-left/div/div/ng-transclude/container-nav/div/div[1]/div/a[1]
    Click Link      xpath=//*[@id="mainPanel"]/div[2]/ad-base-admin-app/div/dx-split-view/div/div[1]/div/dx-split-view-first/div/container-page/dx-two-column-view/div/div[1]/ng-transclude/dx-two-column-left/div/div/ng-transclude/container-nav/div/div[1]/div/a[1]

    # Select Correct Instance
    #Wait Until Keyword Succeeds     5   3s    Verify Database Instance
    Wait Until Page Contains Element     xpath=//*[@title="${TARGET_DB}"]   10s
    Click Element                       xpath=//*[@title="${TARGET_DB}"]

    Wait Until Page Contains Element    xpath=//*[@id="mainPanel"]/div[2]/ad-base-admin-app/div/dx-split-view/div/div[1]/div/dx-split-view-first/div/container-page/dx-two-column-view/div/div[2]/ng-transclude/dx-two-column-center/div/ng-transclude/ui-view/ds-dataset/div/div[1]/div/div/div[2]/div/dx-button/button
    Click Button    xpath=//*[@id="mainPanel"]/div[2]/ad-base-admin-app/div/dx-split-view/div/div[1]/div/dx-split-view-first/div/container-page/dx-two-column-view/div/div[2]/ng-transclude/dx-two-column-center/div/ng-transclude/ui-view/ds-dataset/div/div[1]/div/div/div[2]/div/dx-button/button

    # Select Faster Option for Snapshot
    Wait Until Page Contains Element    xpath=/html/body/div[1]/div/div/dx-dialog-connector/ds-refresh-wizard/dx-wizard/dx-dialog-layout/div[2]/ng-transclude/dx-dialog-content/div/div/div[2]/div/ng-transclude/dx-wizard-step[1]/div/ng-form/ng-transclude/ds-select-point-options-step/div/dx-loading/div/div/ng-transclude/div/div[2]/dx-option-card[1]/div
    Click Element      xpath=/html/body/div[1]/div/div/dx-dialog-connector/ds-refresh-wizard/dx-wizard/dx-dialog-layout/div[2]/ng-transclude/dx-dialog-content/div/div/div[2]/div/ng-transclude/dx-wizard-step[1]/div/ng-form/ng-transclude/ds-select-point-options-step/div/dx-loading/div/div/ng-transclude/div/div[2]/dx-option-card[1]/div
    Click Element      xpath=/html/body/div[1]/div/div/dx-dialog-connector/ds-refresh-wizard/dx-wizard/dx-dialog-layout/div[3]/ng-transclude/dx-dialog-footer/dx-form-actions/dx-button[3]/button

    # Submit Job to be cloned
    Click Element       xpath=/html/body/div[1]/div/div/dx-dialog-connector/ds-refresh-wizard/dx-wizard/dx-dialog-layout/div[3]/ng-transclude/dx-dialog-footer/dx-form-actions/dx-button[4]

Verify Clone run
#    Wait Until Page Contains Element    xpath=//*[@id="mat-tab-label-0-1"]/div/div      20s
#    Click Element    xpath=//*[@id="mat-tab-label-0-1"]/div/div
#
#    Wait Until Page Contains Element    xpath=//*[@aria-valuetext]    10s
#    ${progess_bar}=     xpath=//*[@aria-valuetext]
#    ${progess_bar_status}=    Get Element Attribute     ${progess_bar}
#    Log     ${progress_bar_status}

    Wait Until Page Contains Element    xpath=//*[@id="aria-shr-navbar"]/ul/li[3]/a
    Click Element   xpath=//*[@id="aria-shr-navbar"]/ul/li[3]/a
    Wait Until Element Is Visible   xpath=/html/body/div[2]/div[2]/ad-base-admin-app/div/shr-navbar/nav/div/ul/li[3]/ul/li[2]/a
    Click Element  xpath=/html/body/div[2]/div[2]/ad-base-admin-app/div/shr-navbar/nav/div/ul/li[3]/ul/li[2]/a

    Wait Until Page Contains       RUNNING
    Wait Until Keyword Succeeds     25min     40s     Check Database Clone Status

Check Database Clone Status
#    ${db_status}=   Get Value   xpath=/html/body/div[2]/div[2]/ad-base-admin-app/div/dx-split-view/div/div[1]/div/dx-split-view-first/div/div/alt-jobs/alt-rangebound-collection/dx-two-column-view/div/div[2]/ng-transclude/dx-two-column-center/div/ng-transclude/div[2]/dx-grid-new/ag-grid-angular/div/div[1]/div/div[3]/div[2]/div/div/div/div[6]/alt-job-job-state-renderer/span
#    Log     ${db_status}
#    Should Be Equal As Strings  ${db_status}   COMPLETED
    Wait Until Page Does Not Contain     RUNNING

