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
throttlePosition = table2array(experimentalData(:,3));       % represented as a percentage
inletT2 = table2array(experimentalData(:,4));                % absolute temperature at station T2's inlet
inletT3 = table2array(experimentalData(:,5));                % absolute temperature at compressor entry(station T3)
exitT4 = table2array(experimentalData(:,6));                 % absolute,total temperature at combustor exit(station T4)
exitT5 = table2array(experimentalData(:,7));                 % absolute, total temperature at turbine exit(station T5)
exitT6 = table2array(experimentalData(:,8));                 % absolute, total nozzle exhaust temperature(station T6)
ambPressure = table2array(experimentalData(:,9));            % ambient pressure(P_0)

inletP1 = table2array(experimentalData(:,12));               % static inlet presure(p_1) in [kPa]

exitP3 = table2array(experimentalData(:,15));                % static compressor exit pressure(p_3) at station P3 in [kPa]

inletP3 = table2array(experimentalData(:,18));               % total combustor inlet pressure(P_3) at station P3 in [kPa]

inletP4 = table2array(experimentalData(:,21));               % absolute turbine inlet static pressure(P_4) at station P4 in [kPa]

entryP6 = table2array(experimentalData(:,24));               % absolute nozzle entry pressure(P_6) at station P6 in [kPa]

thrust = table2array(experimentalData(:,27));                % thrust in [N]
spoolSpeed = table2array(experimentalData(:,28));            % spool speed in [rpm]
fuelFlow = table2array(experimentalData(:,29));              % fuel flow in [l/min]
density = table2array(experimentalData(:,30));               % upstream density in [kg/m^3]
massFlow = table2array(experimentalData(:,31));              % mass flow rate in [kg/s]
specHeat1 = table2array(experimentalData(:,32));             % specific heat(C_p_1) in [kJ/kg.K]
specHeat2 = table2array(experimentalData(:,33));             % specific heat(C_p_2) in [kJ/kg.K]
specHeat3 = table2array(experimentalData(:,34));             % specific heat(C_p_3) in [kJ/kg.K]
specHeat4 = table2array(experimentalData(:,35));             % specific heat(C_p_4) in [kJ/kg.K]
specHeat5 = table2array(experimentalData(:,36));             % specific heat(C_p_5) in [kJ/kg.K]

% Reference values
tempRef = 288.15;                               % reference temperature at sea level on a standard day in [K]
pressRef = 101.325;                             % reference pressure at sea level on a standard day in [kPa]
spoolRef = 108000;                              % reference spool speed in [rpm]

%% Plotting the data

% Plot 4: Compressor corrected mass flow rate vs. spool relative corrected speed
massFlowCorrected = massFlow.*(sqrt(inletT3./tempRef)./(exitP3./pressRef));                  % corrected mass flow rate in [kg/s]
correctedSpool = (spoolSpeed./spoolRef)./sqrt(inletT3./tempRef);                             % corrected spool speed in [rpm]

plot(massFlowCorrected,correctedSpool)
xlabel('Corrected Mass Flow Rate')
ylabel('Corrected Spool Speed')
ylim([0.3 0.76])

% Plot 5: Compressor isentropic efficiency vs. compressor corrected mass flow rate
isenT3 = ;                                                                                  % calculating T3_is

