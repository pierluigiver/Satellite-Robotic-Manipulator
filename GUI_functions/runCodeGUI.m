% Creazione della finestra principale della GUI
clear all 
close all 
clc

% Creazione della finestra principale della GUI
fig = figure('Name', 'Dr. Marcello Romano, Orbital Robotics and Distributed Space Systems 2023. Final project');
% Dimensioni desiderate
width = 800;
height = 600;

% Ottenere le dimensioni dello schermo
screenSize = get(0, 'ScreenSize');
screenWidth = screenSize(3);
screenHeight = screenSize(4);

% Calcolo delle coordinate per centrare la figura
left = (screenWidth - width) / 2;
bottom = (screenHeight - height) / 2;

% Impostazione delle dimensioni e posizione della figura
fig.Position = [left bottom width height];

% Creazione di un pannello per le opzioni
panel = uipanel('Parent', fig, 'Position', [0.1 0.05 0.8 0.8]);

% Creazione del titolo
titleText = uicontrol('Parent', fig, 'Style', 'text', 'String', 'Welcome to the project developed by A. Scazzi, P. Vergari, F. Vetrugno and A. Villa', 'Position', [20 550 750 30], 'FontSize', 13, 'FontWeight', 'bold');
subtitleText = uicontrol('Parent', fig, 'Style', 'text', 'String', 'Please select one of the options below', 'Position', [20 530 750 20], 'FontSize', 10, 'FontWeight', 'bold');


% Creazione dei pulsanti per le opzioni
l = 0;   % left
b = 400; % bottom
w = 638; % width
h = 40;  % height

button1 = uicontrol('Parent', panel, 'Style', 'pushbutton', 'String', 'Computation of HCW equations with different initial conditions', 'Position', [l b w h], 'FontSize', 14, 'FontWeight', 'bold', 'Callback', @(src,event) runCode(1));
button2 = uicontrol('Parent', panel, 'Style', 'pushbutton', 'String', 'Start the optimization problem', 'Position', [l b-60 w h], 'FontSize', 14, 'FontWeight', 'bold', 'Callback', @(src,event) runCode(2));
button3 = uicontrol('Parent', panel, 'Style', 'pushbutton', 'String', 'Start Game Simulator', 'Position', [l b-120 w h], 'FontSize', 14, 'FontWeight', 'bold', 'Callback', @(src,event) runCode(3));
button4 = uicontrol('Parent', panel, 'Style', 'pushbutton', 'String', 'Run Robotic Manipulator Simulation', 'Position', [l b-180 w h], 'FontSize', 14, 'FontWeight', 'bold', 'Callback', @(src,event) runCode(4));
button5 = uicontrol('Parent', panel, 'Style', 'pushbutton', 'String', 'Run Robotic Manipulator Animation', 'Position', [l b-240 w h], 'FontSize', 14, 'FontWeight', 'bold', 'Callback', @(src,event) runCode(5));
button6 = uicontrol('Parent', panel, 'Style', 'pushbutton', 'String', 'Close Menu', 'Position', [l b-300 w h], 'FontSize', 14, 'FontWeight', 'bold', 'Callback', @(src,event) runCode(6));

% Funzione per eseguire il codice corrispondente all'opzione selezionata
function runCode(option)
    switch option
        case 1
            clc;
            inputnum;
            intermediateGUI
        case 2
            ICs_opt;
            intermediateGUI;
        case 3
            yesnogame;
            close('Dr. Marcello Romano, Orbital Robotics and Distributed Space Systems 2023. Final project')
            clc;
            intermediateGUI;
        case 4
            SCRIPT2_FFP6L5R_PlotFigures;
            intermediateGUI;
        case 5
            SCRIPT3_FFP6L5R_Animation;
            intermediateGUI;
        case 6
            close;
    end
end
