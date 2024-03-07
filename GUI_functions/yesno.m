% Creazione della finestra principale della GUI
fig = figure('Name', 'Second evaluation', 'Position', [0 40 300 200]);

% Creazione del titolo
titleText = uicontrol('Parent', fig, 'Style', 'text', 'String', 'Would you like to obtain other plots with different set of initial conditions?', 'Position', [50 150 200 30], 'FontSize', 8, 'FontWeight', 'bold');

% Creazione del pulsante "Yes"
yesButton = uicontrol('Parent', fig, 'Style', 'pushbutton', 'String', 'Yes', 'Position', [50 100 100 30], 'FontSize', 12, 'Callback', @(src,event) buttonCallback(src, 'Yes'));

% Creazione del pulsante "No"
noButton = uicontrol('Parent', fig, 'Style', 'pushbutton', 'String', 'No', 'Position', [150 100 100 30], 'FontSize', 12, 'Callback', @(src,event) buttonCallback(src, 'No'));

% Funzione per gestire l'evento di click sui pulsanti
function buttonCallback(src, response)
    if strcmp(response, 'Yes')
        newICs;
         
    elseif strcmp(response, 'No')
        close all;
        intermediateGUI;
    end
end