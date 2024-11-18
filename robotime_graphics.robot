*** Settings ***
# Libraries used in the script
Library           SeleniumLibrary        # Provides Selenium-based browser automation
Library           Collections            # Allows dictionary manipulation
Library           OperatingSystem        # Handles file system operations
Library           String                 # Provides string manipulation capabilities

*** Variables ***
# Configurable variables for the script
${URL}            https://time.graphics/pt/editor/  # URL of the Time Graphics editor
${CSV_FILE}       my_data.csv                       # Path to the CSV file containing event data
${BROWSER}        Chrome                            # Browser type for automation
&{EVENT_COLORS}   SYMPTOM=#FF6347   MEAL=#FFA500   SLEEP=#4682B4   DRINK=#6A5ACD   MEDICATION=#32CD32   EXERCISE=#FF69B4   OTHER=#808080   ILLNESS=#DC143C
# Mapping of event types to their respective colors
${EMAIL}          email@email.com                   # Login email for Time Graphics
${PASSWORD}       password                          # Login password

*** Keywords ***
# Opens the Time Graphics website in the specified browser
Open Time Graphics Website
    Open Browser    ${URL}    ${BROWSER}           # Opens the browser at the specified URL
    Maximize Browser Window                         # Maximizes the browser window for better visibility
    Wait Until Element Is Visible    xpath=/html/body/div[10]/div/div[1]    timeout=10s
    Click Element    xpath=/html/body/div[10]/div/div[1]  # Clicks the initial popup, if visible
    Sleep    1s

# Logs into the Time Graphics account using the provided credentials
Login
    Click Button    xpath=//*[@id="userPanel"]/div/button  # Opens the login form
    Wait Until Element Is Visible    xpath=//*[@placeholder="E-mail"]
    Input Text    xpath=//*[@placeholder="E-mail"]    ${EMAIL}
    Input Password    xpath=//div[@class="content"]/descendant::input[5]  ${PASSWORD}
    Click Element    xpath=//button[@class="buttons orangeGradient"]  # Submits the login form
    Sleep    5s

# Activates the mode for adding a new event to the timeline
Activate Event Addition Mode
    Wait Until Element Is Visible    xpath=//*[@id="addNewEventButtonId"]    timeout=10s
    Click Element    xpath=//*[@id="addNewEventButtonId"]
    Wait Until Element Is Visible    xpath=//div[@tiptext="Evento"]    timeout=5s
    Click Element    xpath=//div[@tiptext="Evento"]

# Fills in the event's title
Fill Event Title
    [Arguments]    ${title}  # Accepts a title as an argument
    Input Text    xpath=//textarea[contains(@class, "TextArea name") and @placeholder="Nome.."]    ${title}

# Fills in the event's description
Fill Event Description
    [Arguments]    ${description}  # Accepts a description as an argument
    Input Text    xpath=//textarea[contains(@class, "TextArea description") and @placeholder="Descrição.."]    ${description}

# Fills in the event's date and time
Fill Event Date
    [Arguments]    ${year}    ${month}    ${day}    ${hour}    ${minute}
    Click Element    xpath=//div[contains(@class, "TextBoxWrapper start")]/input[@placeholder="Data (a partir)"]
    Wait Until Element Is Visible    xpath=//input[contains(@class, "TextBox yearBox") and @placeholder="Ano"]    timeout=5s
    Input Text    xpath=//input[contains(@class, "TextBox yearBox") and @placeholder="Ano"]    ${year}
    Click Element    xpath=//div[@class="centering flex row ac gap5"][div[@class="label"][contains(., "Month:")]]//input[contains(@class, "TextBox box")]
    Wait Until Element Is Visible    xpath=//div[contains(@class, "CommonListBox-Popup")]    timeout=5s
    Click Element    xpath=(//div[contains(@class, "CommonListBox-Popup")]//div[@class="label" or @class="label label-selected"])[${month}]
    Input Text    xpath=//div[@class="centering flex row ac gap5"][div[@class="label"][contains(., "Dia:")]]//input[contains(@class, "TextBox dayBox")]    ${day}
    Input Text    xpath=//div[@class="centering flex row ac gap5"][div[@class="label"][contains(., "Hours:")]]//input[contains(@class, "TextBox hourTextBox")]    ${hour}
    Input Text    xpath=//div[@class="centering flex row ac gap5"][div[@class="label"][contains(., "Minutes:")]]//input[contains(@class, "TextBox minuteTextBox")]    ${minute}

# Sets the event's color based on its type
Fill Event Color
    [Arguments]    ${event_type}
    Click Element    xpath=//*[@id="timelineContainer"]/div[1]/div[7]/div[1]/div[6]/div[1]
    ${color} =    Get From Dictionary    ${EVENT_COLORS}    ${event_type}
    Wait Until Element Is Visible    xpath=//div[@class="color-picker-control"]//input    timeout=5s
    Input Text    xpath=//div[@class="color-picker-control"]//input    ${color}

# Adds a new event to the timeline
Add Event To Timeline
    [Arguments]    ${title}    ${description}    ${year}    ${month}    ${day}    ${hour}    ${minute}    ${event_type}
    Activate Event Addition Mode
    Fill Event Title    ${title}
    Fill Event Description    ${description}
    Fill Event Color    ${event_type}
    Fill Event Date    ${year}    ${month}    ${day}    ${hour}    ${minute}

# Parses a timestamp into separate date and time components
Parse Date
    [Arguments]    ${timestamp}
    ${date}    ${time} =    Split String    ${timestamp}    separator=    # Splits into date and time
    ${year}    ${month}    ${day} =    Split String    ${date}    separator=-
    ${hour}    ${minute}    ${second} =    Split String    ${time}    separator=:
    RETURN    ${year}    ${month}    ${day}    ${hour}    ${minute}

# Saves the timeline after all events are added
Save
    Click Element    xpath=//*[@id="SaveButtonDivId"]

*** Test Cases ***
# Main test case to add events from a CSV file
Add Events From CSV File
    Open Time Graphics Website
    Login
    ${content} =    Get File    ${CSV_FILE}  # Reads the CSV file
    ${lines} =    Split String    ${content}    \n
    FOR    ${line}    IN    @{lines[1:]}  # Skips the header row
        ${title}    ${summary}    ${event_type}    ${timestamp} =    Split String    ${line}    separator=,
        ${year}    ${month}    ${day}    ${hour}    ${minute} =    Parse Date    ${timestamp}
        ${title} =    Catenate    ${event_type}: ${title}  # Formats the title
        Add Event To Timeline    ${title}    ${summary}    ${year}    ${month}    ${day}    ${hour}    ${minute}    ${event_type}
    END
    Sleep    2s
    Save
    Sleep    120s  # Allows time for manual inspection of the results
