clear all
close all
clc

pathstr = fileparts(mfilename('fullpath'));
addpath(sprintf('%s/PART_1',pathstr));
addpath(sprintf('%s/PART_2',pathstr));
addpath(sprintf('%s/PART_1/Scripts',pathstr));
addpath(sprintf('%s/PART_1/Functions',pathstr));
addpath(sprintf('%s/PART_2/SRCP',pathstr));
addpath(sprintf('%s/PART_2/SCRIPTS',pathstr));
addpath(sprintf('%s/PART_2/SCRIPTS/FF_P_6L_5R_RA',pathstr));
addpath(sprintf('%s/PART_2/SRCP_OROLAB_RECURSIVE',pathstr));
addpath(sprintf('%s/PART_2/USER_FUN',pathstr));
addpath(sprintf('%s/GUI_functions',pathstr));
savepath;
cd(pathstr);

runCodeGUI;
% %% MAIN CODE
% 
% disp('Choose one between these three options: ')
% disp('[1] Run the code HCW_IC_MakeFigs.m which shows how HCW equations propagates with different ICs')
% disp('[2] Find the optimal time given a set of ICs')
% disp('[3] Start the game simulator')
% disp('[4] Run the simulation regarding the evolution in time of the robotic manipulator')
% disp('[5] Run the animation of the evolution in time of the robotic manipulator')
% disp('[6] Close the simulation')
% disp('')
% flag = input('Enter the number: ');
% 
% while((flag~=1)&&(flag~=2)&&(flag~=3)&&(flag~=4)&&(flag~=5)&&(flag~=6))
%     disp('')
%     flag = input('Number not valid. Enter a new one: ');
% end
%     
% switch flag
%     case 1
%         HCW_IC_MakeFigs
%         clc
%     case 2
%         Optimal_t
%     case 3
%         game_simulation()
%         clc
%     case 4
%         SCRIPT2_FFP6L5R_PlotFigures
%     case 5
%         SCRIPT3_FFP6L5R_Animation
%     case 6
%         close()
% end
% 
%         
%         