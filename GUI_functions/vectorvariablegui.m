% Creazione della finestra principale della GUI
close all

% Creazione della finestra principale della GUI
fig = figure('Name', 'Number Input', 'Units', 'normalized', 'Position', [0.3 0.4 0.4 0.3]);

% Testo in cima alla finestra
uicontrol('Parent', fig, 'Style', 'text', 'String', 'Please enter the value of different initial conditions you want to plot, just separate by spacebar (e.g. 1 2 3)', 'Position', [30 160 550 50], 'FontSize', 11, 'HorizontalAlignment', 'center');

% Creazione dell'area di input
inputField = uicontrol('Parent', fig, 'Style', 'edit', 'String', '', 'Units', 'normalized', 'Position', [0.1 0.4 0.8 0.2], 'FontSize', 12);

% Creazione del bottone di submit
submitButton = uicontrol('Parent', fig, 'Style', 'pushbutton', 'String', 'Submit', 'Units', 'normalized', 'Position', [0.4 0.2 0.2 0.1], 'FontSize', 12, 'Callback', {@submitValues, inputField});

% Funzione per salvare la sequenza di numeri
function submitValues(~, ~, inputField)
    inputStr = get(inputField, 'String');
    v0 = str2num(inputStr);  % Converti la stringa di input in un vettore di numeri
    assignin('base', 'v0', v0); % Assegna il valore di v0 alla workspace principale
    inputnum2;
end
