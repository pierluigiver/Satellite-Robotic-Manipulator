% Creazione della finestra principale della GUI
close all
% Creazione della finestra principale della GUI
fig = figure('Name', 'Index choice');
% Dimensioni desiderate
width = 450;
height = 200;

% Ottenere le dimensioni dello schermo
screenSize = get(0, 'ScreenSize');
screenWidth = screenSize(3);
screenHeight = screenSize(4);

% Calcolo delle coordinate per centrare la figura
left = (screenWidth - width) / 2;
bottom = (screenHeight - height) / 2;

% Impostazione delle dimensioni e posizione della figura
fig.Position = [left bottom width height];
% Testo in cima alla finestra
uicontrol('Parent', fig, 'Style', 'text', 'String', 'Which parameter do you want to vary?', 'Position', [130 140 200 50], 'FontSize', 14, 'HorizontalAlignment', 'center');

% Creazione dei bottoni
buttons = cell(1, 6);
global buttonNames;
buttonNames = {'x0', 'y0', 'z0', 'x0_dot', 'y0_dot', 'z0_dot'};
buttonWidth = 60;
buttonHeight = 40;
buttonSpacing = 10;
startX = (fig.Position(3) - (buttonWidth + buttonSpacing) * 6) / 2;
for i = 1:6
    buttonPosition = [startX + (buttonWidth + buttonSpacing) * (i-1), 80, buttonWidth, buttonHeight];
    buttons{i} = uicontrol('Parent', fig, 'Style', 'pushbutton', 'String', buttonNames{i}, 'Position', buttonPosition, 'FontSize', 12, 'Callback', @(src,event) saveValue(src, i));
end

% Funzione per salvare il valore selezionato
function saveValue(src, index)
    n = index;
    assignin('base', 'n', n); % Assegna il valore di n alla workspace principale
    close('Index choice');
    vectorvariablegui;
end