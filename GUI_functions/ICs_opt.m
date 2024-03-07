% Creazione della finestra principale della GUI
close all
fig = figure('Name', 'Initial conditions', 'Position', [100 100 400 400]);

% Dimensioni desiderate
width = 400;
height = 400;

% Ottenere le dimensioni dello schermo
screenSize = get(0, 'ScreenSize');
screenWidth = screenSize(3);
screenHeight = screenSize(4);

% Calcolo delle coordinate per centrare la figura
left = (screenWidth - width) / 2;
bottom = (screenHeight - height) / 2;

% Impostazione delle dimensioni e posizione della figura
fig.Position = [left bottom width height];

annotation('textbox', [0.1 0.8 0.8 0.1], 'String', 'Enter the initial conditions', 'FontSize', 14, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'LineStyle', 'none');

% Posizione e dimensione dei campi di input
inputSize = 80;
offset = 30;
inputPositions = [100-offset 250-inputSize/2 inputSize inputSize;
                  200-offset 250-inputSize/2 inputSize inputSize;
                  300-offset 250-inputSize/2 inputSize inputSize;
                  100-offset 150-inputSize/2 inputSize inputSize;
                  200-offset 150-inputSize/2 inputSize inputSize;
                  300-offset 150-inputSize/2 inputSize inputSize];

% Nomi dei campi di input
inputNames = {'x_0 [m]', 'y_0 [m]', 'z_0 [m]', 'x0_dot [m/s]', 'y0_dot [m/s]', 'z0_dot [m/s]'};

% Creazione dei campi di input
editFields = cell(1, 6);
for i = 1:6
    % Creazione del titolo
    uicontrol('Parent', fig, 'Style', 'text', 'String', inputNames{i}, 'HorizontalAlignment', 'center', 'Position', [inputPositions(i, 1) inputPositions(i, 2)+inputPositions(i, 4) inputPositions(i, 3) 20], 'FontSize', 10, 'FontWeight', 'bold');
    
    % Creazione del campo di input
    editFields{i} = uicontrol('Parent', fig, 'Style', 'edit', 'Position', inputPositions(i, :), 'FontSize', 12);
end

% Creazione del pulsante "Submit"
submitButton = uicontrol('Parent', fig, 'Style', 'pushbutton', 'String', 'Submit', 'Position', [150 50 100 30], 'FontSize', 12, 'Callback', @(src,event) submitValues(src, editFields));

% Inizializzazione 
X0 = zeros(1, 6)';

% Funzione per gestire l'evento di submit dei valori
function submitValues(src, editFields)
    values = zeros(1, 6)';
    for i = 1:6
        valueStr = get(editFields{i}, 'String');
        value = str2double(valueStr);
        if isnan(value)
            errordlg('Invalid input. Please enter valid numbers.', 'Error');
            return;
        end
        values(i) = value;
    end
    
    % Salva i valori inseriti 
    assignin('base', 'X0', values);
    close;
    intermediateGUI;
    Optimal_t;    
 end
