% Creazione della finestra principale della GUI
fig = figure('Name', 'Menu', 'Position', [0 40 300 200]);

% Calcolo delle dimensioni dei pulsanti
buttonWidth = 120;
buttonHeight = 40;
buttonSpacing = 20;

% Calcolo delle coordinate del primo pulsante
button1X = (fig.Position(3) - buttonWidth) / 2;
button1Y = (fig.Position(4) - buttonHeight) / 2 + buttonSpacing;

% Creazione del pulsante "Back to Menu"
button1 = uicontrol('Parent', fig, 'Style', 'pushbutton', 'String', 'Back to Menu', 'Position', [button1X button1Y buttonWidth buttonHeight], 'FontSize', 12, 'FontWeight', 'bold', 'Callback', @(src,event) backToMenu());

% Calcolo delle coordinate del secondo pulsante
button2X = (fig.Position(3) - buttonWidth) / 2;
button2Y = (fig.Position(4) - buttonHeight) / 2 - buttonHeight - buttonSpacing;

% Creazione del pulsante "Exit Menu"
button2 = uicontrol('Parent', fig, 'Style', 'pushbutton', 'String', 'Exit Menu', 'Position', [button2X button2Y buttonWidth buttonHeight], 'FontSize', 12, 'FontWeight', 'bold', 'Callback', @(src,event) exitMenu());

% Funzione per tornare al menu
function backToMenu()
    runCodeGUI;
    
end

% Funzione per uscire dal menu
function exitMenu()
    
    close all;
    close
end
