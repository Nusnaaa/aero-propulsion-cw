% Author: Linus Adzanku
% Date Created: Thursday 26th October 2023
% Contributors: Sophie Millington, Corey Pearce, Charles Choi
% Last edit: Friday 27th October 2023
% Purpose: This code file will store all the data visualisation and
% processinig work that the group carries out. It has been linked to a
% GitHub repository found in the link below, for version control.
% GitHub: https://github.com/Nusnaaa/aero-propulsion-cw

%% Sorting the raw data into variables

% Preparing the data 
experimentalData = readtable("Test Data B1.xlsx");

% Separating the columns
throttlePosition = table2array(experimentalData(:,3)); % represented as a percentage
inletT2 = table2array(experimentalData(:,4)); % absolute temperature at station T2's inlet
inletT3 = table2array(experimentalData(:,5)); % absolute temperature at compressor entry(station T3)
exitT4 = table2array(experimentalData(:,6)); % absolute,total temperature at combustor exit(station T4)
exitT5 = table2array(experimentalData(:,7)); % absolute, total temperature at turbine exit(station T5)
exitT6 = table2array(experimentalData(:,8)); % absolute, total nozzle exhaust temperature(station T6)
ambPressure = table2array(experimentalData(:,9)); % ambient pressure(P_0)
 
inletP1 = table2array(experimentalData(:,12)); % static inlet presure(p_1) in [kPa]
 
exitP3 = table2array(experimentalData(:,15)); % static compressor exit pressure(p_3) at station P3 in [kPa]
 
inletP3 = table2array(experimentalData(:,18)); % total combustor inlet pressure(P_3) at station P3 in [kPa]
 
inletP4 = table2array(experimentalData(:,21)); % absolute turbine inlet static pressure(P_4) at station P4 in [kPa]
 
entryP6 = table2array(experimentalData(:,24)); % absolute nozzle entry pressure(P_6) at station P6 in [kPa]
 
thrust = table2array(experimentalData(:,27)); % thrust in [N]
spoolSpeed = table2array(experimentalData(:,28)); % spool speed in [rpm]
fuelFlow = table2array(experimentalData(:,29)); % fuel flow in [l/min]
density = table2array(experimentalData(:,30)); % upstream density in [kg/m^3]
massFlow = table2array(experimentalData(:,31)); % mass flow rate in [kg/s]
specHeat1 = table2array(experimentalData(:,32)); % specific heat(C_p_1) in [kJ/kg.K]
specHeat2 = table2array(experimentalData(:,33)); % specific heat(C_p_2) in [kJ/kg.K]
specHeat3 = table2array(experimentalData(:,34)); % specific heat(C_p_3) in [kJ/kg.K]
specHeat4 = table2array(experimentalData(:,35)); % specific heat(C_p_4) in [kJ/kg.K]
specHeat5 = table2array(experimentalData(:,36)); % specific heat(C_p_5) in [kJ/kg.K]
 
% Reference values
tempRef = 288.15; % reference temperature at sea level on a standard day in [K]
pressRef = 101325; % reference pressure at sea level on a standard day in [Pa]
spoolRef = 108000; % reference spool speed in [rpm]

% Plot 1
% Mass Flow Rate vs. Throttle Position plot
plot(throttlePosition,massFlow,'m')
xlabel 'Throttle Position (%)'
ylabel 'Mass Flow rate (kg/s)'
title 'Mass Flow Rate vs Throttle Position'

% Plot 2
% Intake pressure loss vs. Throttle Position (%) 
inletPLoss=(ambPressure-inletP1)        % Ambient pressure - Absolute Static Inlet Pressure P1 = Intake pressure Loss
%use first equation to the rearange it for air density

% Plot
plot(throttlePosition,inletPLoss,'g')
xlabel 'Throttle Position (%)'
ylabel 'Intake Pressure Loss (kPa)'
title 'Intake pressure loss vs Throttle Position'

<<<<<<< Updated upstream
inletP4 = experimentalData(:,21);               % absolute turbine inlet static pressure(P_4) at station P4

entryP6 = experimentalData(:,24);               % absolute nozzle entry pressure(P_6) at station P6

thrust = experimentalData(:,27);                % thrust in [N]
speed = experimentalData(:,28);                 % speed in [rpm]
fuelFlow = experimentalData(:,29);              % fuel flow in [l/min]
density = experimentalData(:,30);               % upstream density in [kg/m^3]
massFlow = experimentalData(:,31);              % mass flow rate in [kg/s]
specHeat1 = experimentalData(:,32);             % specific heat(C_p_1) in [kJ/kg.K]
specHeat2 = experimentalData(:,33);             % specific heat(C_p_2) in [kJ/kg.K]
specHeat3 = experimentalData(:,34);             % specific heat(C_p_3) in [kJ/kg.K]
specHeat4 = experimentalData(:,35);             % specific heat(C_p_4) in [kJ/kg.K]
specHeat5 = experimentalData(:,36);             % specific heat(C_p_5) in [kJ/kg.K]

%% Plotting the data
=======
% Plot 3
% Compressor pressure ratio vs. spool relative corrected speed
CompressorRatio = inletP1/inletP3                     % compressor pressure inlet / compressor pressure exit = compressor ratio 
%plot 
plot(CompressorRatio, spoolcorrectedspeedplaceholder) % please replace spoolspeed place holder to match plot 4
xlabel 'Compressor Pressure Ratio'
ylabel 'Spool Corrected Speed'
title  'Compressor pressure ratio vs. spool relative corrected speed'
>>>>>>> Stashed changes
