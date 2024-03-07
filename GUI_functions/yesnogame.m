% Creazione della finestra principale della GUI
fig = figure('Name', 'Game mode');

% Impostazione delle dimensioni desiderate
width = 300;
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

% Creazione del titolo
titleText = uicontrol('Parent', fig, 'Style', 'text', 'String', 'Would you like to play with default settings?', 'Position', [50 150 200 30], 'FontSize', 8, 'FontWeight', 'bold');

% Creazione del pulsante "Yes"
yesButton = uicontrol('Parent', fig, 'Style', 'pushbutton', 'String', 'Yes', 'Position', [50 100 100 30], 'FontSize', 12, 'Callback', @(src,event) buttonCallback(src, 'Yes'));

% Creazione del pulsante "No"
noButton = uicontrol('Parent', fig, 'Style', 'pushbutton', 'String', 'No', 'Position', [150 100 100 30], 'FontSize', 12, 'Callback', @(src,event) buttonCallback(src, 'No'));

% Inizializzazione variabili
X0_deputy = zeros(6, 1);
dt = [];
thr = [];

% Funzione per gestire l'evento di click sui pulsanti
function buttonCallback(src, response)
    if strcmp(response, 'Yes')
        dt = 5;                         % speed of the simulation (lower, slower)
        X0_deputy = [50; 30; 0; 0; 0; 0];    % State vector (HILL RF)
        thr = 0.005;                    % [m/s]
        assignin('base', 'X0_deputy', X0_deputy);
        assignin('base', 'thr', thr);
        assignin('base', 'dt', dt);
        close('Game mode');
game_simulation;
    elseif strcmp(response, 'No')
        close('Game mode');
gameICs;
    end
end

