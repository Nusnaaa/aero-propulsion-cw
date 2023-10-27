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
pressRef = 101.325; % reference pressure at sea level on a standard day in [Pa]
spoolRef = 108000; % reference spool speed in [rpm]

%% Plotting the data

% Calculated Mass Flow Rates
Cd = 0.58; % discharge coefficient for circular orifices
d1 = 0.071; % intake inlet diameter in meters (71 mm)

% Compute intake area
A = pi * (d1/2)^2;

% Calculate velocity for each data point
v = sqrt(2 * (ambPressure - inletP1) * 1e3 ./ density); % converting pressure from kPa to Pa

% Compute volumetric flow rate
Q = Cd * A * v;

% Compute mass flow rate for each data point
calculated_m_dot = density .* Q;

% Displaying the calculated mass flow rate
fprintf('Calculated Mass Flow Rates (kg/s): \n');
disp(calculated_m_dot);


% 11.Turbine isentropic efficiency vs. turbine corrected mass flow rate


exitT4 % Turbine inlet temperature (K)
exitT5   % Turbine outlet temperature (K)
tempout_isentropic   % Isentropic turbine outlet temperature (K)
pressin % Turbine inlet pressure (Pa)
pressout   % Turbine outlet pressure (Pa)
tempRef   % Reference temperature (K)
pressRef   % Reference pressure (Pa)
mass_flow_rate_actual % Actual mass flow rate (kg/s)

% Calculate turbine isentropic efficiency
eta_t = (exitT4 - exitT5) ./ (exitT4 - tempout_isentropic);

% Calculate turbine corrected mass flow rate
mass_flow_rate_corrected = mass_flow_rate_actual .* (exitT4 ./ tempRef).^0.5 .* (inletP4 ./ pressRef);

% Plot
figure;
plot(mass_flow_rate_corrected, eta_t, '-o');
xlabel('Turbine Corrected Mass Flow Rate (kg/s)');
ylabel('Turbine Isentropic Efficiency');
title('Turbine Isentropic Efficiency vs. Corrected Mass Flow Rate');
grid on;