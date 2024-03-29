% Creazione della finestra principale della GUI

close all 
clc

% Creazione della finestra principale della GUI
fig = figure('Name', 'Input Number');

% Dimensioni desiderate
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

annotation('textbox', [0.1 0.8 0.8 0.1], 'String', 'Enter the simulation time [s]', 'FontSize', 14, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'LineStyle', 'none');
% Creazione del campo di testo per l'inserimento del numero
editField = uicontrol('Parent', fig, 'Style', 'edit', 'Position', [50 100 200 30], 'FontSize', 12);

% Creazione del pulsante "Submit"
submitButton = uicontrol('Parent', fig, 'Style', 'pushbutton', 'String', 'Submit', 'Position', [100 50 100 30], 'FontSize', 12, 'Callback', @(src,event) submitNumber(src, editField));

% Inizializzazione della variabile numerica T
T = [];

% Funzione per gestire l'evento di submit del numero
function submitNumber(src, editField,fig)
    % Ottieni il valore inserito nel campo di testo
    inputNumber = str2double(get(editField, 'String'));
    
    % Controlla se l'input è un numero valido
    if isnan(inputNumber) 
        % Visualizza un messaggio di errore se l'input non è un numero
        errordlg('Invalid input. Please enter a valid number.', 'Error');
    else
        % Assegna il valore alla variabile numerica T
        assignin('base', 'T', inputNumber);
        disp(['You chose this simulation time: ', num2str(inputNumber) '[s]']);
        close('Menu');
        HCW_IC_MakeFigs;
        close ('Input Number');
    end
end

