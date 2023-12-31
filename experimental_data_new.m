% Author: Linus Adzanku
% Date Created: Thursday 26th October 2023
% Contributors: Sophie Millington, Corey Pearce, Charles Choi
% Last edit: Friday 27th October 2023
% Purpose: This code file will store all the data visualisation and
% processinig work that the group carries out. It has been linked to a
% GitHub repository found in the link below, for version control.
% GitHub: https://github.com/Nusnaaa/aero-propulsion-cw

%% Sorting the raw data into variables and defining constants

% Reference values, conversion factors & consants
kPa2Pa = 1*10^3;                                            % conversion factor
tempRef = 288.15;                                           % reference temperature at sea level on a standard day in [K]
pressRef = 101.325*kPa2Pa;                                  % reference pressure at sea level on a standard day in [Pa]
spoolRef = 108000;                                          % reference spool speed in [rpm]
Cd = 0.58;                                                  % discharge coefficient
d1 = 71*10^-3;                                              % intake inlet diameter in [m]
d2= 90*10^-3;                                               % Compressor blade diameter in [m]
litresMin2litresSec = 1/60;                                 % conversion factor for litres/min to litres/sec
litre2cubMetre = 1/1000;
fuelDensity = 800;                                          % density of jet A1 in kg/m^3 @ 15 deg C
mechEfficiency = 0.99;
R = 287;                                                    % gas constant in [J/(kg.K)]
kJ2J = 1000;                                                % conversion factor for converting kJ in J


% Preparing the data 
experimentalData = readtable("Test Data B1.xlsx");

% Separating the columns
throttlePosition = table2array(experimentalData(:,3)); % represented as a percentage
inletT2 = table2array(experimentalData(:,4)); % absolute temperature at station T2's inlet
exitT3 = table2array(experimentalData(:,5)); % absolute temperature at compressor exit(station T3)
exitT4_wrong = table2array(experimentalData(:,6)); % absolute,total temperature at combustor exit(station T4) - incorrect measurement
exitT5 = table2array(experimentalData(:,7)); % absolute, total temperature at turbine exit(station T5)
exitT6 = table2array(experimentalData(:,8)); % absolute, total nozzle exhaust temperature(station T6)
ambPressure = table2array(experimentalData(:,9))*kPa2Pa; % ambient pressure(P_0)
 
inletP1 = table2array(experimentalData(:,12))*kPa2Pa; % static inlet presure(p_1) in [Pa]
 
exitP3 = table2array(experimentalData(:,15))*kPa2Pa; % static compressor exit pressure(p_3) at station P3 in [Pa]
 
inletP3 = table2array(experimentalData(:,18))*kPa2Pa; % total combustor inlet pressure(P_3) at station P3 in [Pa]
 
inletP4 = table2array(experimentalData(:,21))*kPa2Pa; % absolute turbine inlet static pressure(P_4) at station P4 in [Pa]
 
entryP6 = table2array(experimentalData(:,24))*kPa2Pa; % absolute nozzle entry pressure(P_6) at station P6 in [Pa]
 
thrust = table2array(experimentalData(:,27)); % thrust in [N]
spoolSpeed = table2array(experimentalData(:,28)); % spool speed in [rpm]
fuelFlow = table2array(experimentalData(:,29)); % fuel flow in [l/min]
density = table2array(experimentalData(:,30)); % upstream density in [kg/m^3]
airMassFlow = table2array(experimentalData(:,31)); % mass flow rate in [kg/s]
specHeat1 = table2array(experimentalData(:,32))*kJ2J; % specific heat(C_p_1) in [kJ/kg.K]
specHeat2 = table2array(experimentalData(:,33))*kJ2J; % specific heat(C_p_2) in [kJ/kg.K]
specHeat3 = table2array(experimentalData(:,34))*kJ2J; % specific heat(C_p_3) in [kJ/kg.K]
specHeat4 = table2array(experimentalData(:,35))*kJ2J; % specific heat(C_p_4) in [kJ/kg.K]
specHeat5 = table2array(experimentalData(:,36))*kJ2J; % specific heat(C_p_5) in [kJ/kg.K]
 
% Recalulated values
intakeAirDensity = findDensity(inletP1,R,inletT2);
specHeatAve_turb = (specHeat5 + specHeat4)/2;               % average Cp across turbine
specHeatAve_comp = (specHeat3 + specHeat2)/2;               % average Cp across compressor

Cv_comp = specHeatAve_comp - R;
gamma_comp = specHeatAve_comp./Cv_comp;
Cv_turb = specHeatAve_turb - R;
gamma_turb = specHeatAve_turb./Cv_turb;

% Create a vector for marker sizes
markerSizes = linspace(30,80,numel(inletP4));

%% Plotting the data

% Plot 1: Mass flow rate vs throttle percentage
intakeMassFlow = (Cd*( (pi*d1^2)/4 ) ).*sqrt( 2.*intakeAirDensity.*(ambPressure - inletP1) );                              % intake mass flow rate. Engine values are incorrect, so this needed to be calculated. Uses equation provided under section 6 of coursework brief

fuelMassFlow = (fuelFlow*litresMin2litresSec*litre2cubMetre)*fuelDensity;                                                                   % fuel mass flow rate in kg/s

massFlow = fuelMassFlow + intakeMassFlow;

figure('Name','Mass flow rate vs throttle percentage')
scatter(throttlePosition,massFlow)
title("Mass flow rate vs throttle percentage")
grid minor
ylabel('Mass Flow Rate [kg/s]')
xlabel('Throttle Percentage [%]')

set(findall(gcf,'-property','FontSize'),'FontSize',20)

%% Plot 2: Intake pressure loss vs throttle percentage
compressorEntryDensity = intakeAirDensity;                                                         % the density of air at the compressor entry. Assumed pressure is equal to inlet pressure. In [kg/m^3]
compressorArea = 0.25*pi*(d2^2);
compVolumetricFlow = intakeMassFlow./compressorEntryDensity;                                                            % volumetric flow rate at compressor entry. In [m^3/s]
compressorAirVelocity = compVolumetricFlow./compressorArea;                                                             % in [m/s]
pressureLoss = compressorEntryDensity.*( (compressorAirVelocity.^2)./2 ).*( (1 - Cd)/Cd )^2;                            % intake pressure loss.

figure('Name','Intake pressure loss vs throttle position')
scatter(throttlePosition,pressureLoss)
grid minor
title("Intake pressure loss vs throttle position")
ylabel('Intake Pressure Loss [Pa]')
xlabel('Throttle Percentage [%]')

set(findall(gcf,'-property','FontSize'),'FontSize',20)

%% Plot 3: Compressor pressure ratio vs spool relative corrected speed
relCorrectedSpool = (spoolSpeed/spoolRef)./sqrt(exitT3/tempRef);                                                        % corrected spool speed in [rpm]
% inletP2 = exitP3./(nthroot( (exitT3./inletT2), (gamma_comp - 1)./gamma_comp ) );
inletP2 = ambPressure - pressureLoss;                                                                                   % Pressure at compressor inlet
compPressureRatio = exitP3./inletP2;

figure('Name','Compressor Pressure ratio vs Spool Relative Corected Speed')
scatter(relCorrectedSpool,compPressureRatio)
grid minor
title("Compressor Pressure ratio vs Spool Relative Corected Speed")
ylabel('Compressor pressure ratio')
xlabel('Spool relative corrected speed [rpm]')

set(findall(gcf,'-property','FontSize'),'FontSize',20)

%% Plot 4: Compressor corrected mass flow rate vs. spool relative corrected speed
compMassFlowCorrected = intakeMassFlow.*(sqrt(inletT2/tempRef)./(inletP2/pressRef));                                   % compressor corrected mass flow rate in [kg/s]

figure('Name','Compressor corrected mass flow rate vs. spool relative corrected speed')
scatter(relCorrectedSpool,compMassFlowCorrected)
grid minor
title("Compressor corrected mass flow rate vs. spool relative corrected speed")
ylabel(sprintf('Compressor Corrected \nMass Flow Rate [kg/s]'))
xlabel(sprintf('Corrected Spool \nSpeed [rpm]'))
xlim([0.3 0.76])

set(findall(gcf,'-property','FontSize'),'FontSize',20)

%% Plot 5: Compressor isentropic efficiency vs. compressor corrected mass flow rate
isenT3 = inletT2.*(exitP3./inletP2).^( ( gamma_comp - 1)./gamma_comp );             % calculating T3_is
isenEfficiency = (isenT3 - inletT2)./(exitT3 - inletT2);                                                               % the isentropic efficiency

figure('Name','Compressor isentropic efficiency vs. compressor corrected mass flow rate')
scatter(compMassFlowCorrected,isenEfficiency)
grid minor
title("Compressor isentropic efficiency vs. compressor corrected mass flow rate")
ylabel('Compressor Isentropic Efficiency')
xlabel(sprintf('Compressor Corrected \nMass Flow Rate [kg/s]'))

set(findall(gcf,'-property','FontSize'),'FontSize',20)

%% Plot 6: Compressor exit Mach number vs. compressor corrected mass flow rate
tot_stat_ratio = inletP3./exitP3;
Cv3 = specHeat3 - R;
gamma3 = specHeat3./Cv3;
power_const = (gamma3-1)./(gamma3);
exitMach = sqrt( 2.*( ( tot_stat_ratio.^(power_const) ) - 1 )./(gamma3-1) );

figure('Name','Compressor exit Mach number vs. compressor corrected mass flow rate')
scatter(compMassFlowCorrected,exitMach)
grid minor
title("Compressor exit Mach number vs. compressor corrected mass flow rate")
ylabel('Compressor Exit Mach Number')
xlabel(sprintf('Compressor Corrected \nMass Flow Rate [kg/s]'))

set(findall(gcf,'-property','FontSize'),'FontSize',20)

%% Plot 7: Burner pressure ratio vs. compressor corrected mass flow rate
combustorPressureRatio = inletP4./inletP3;

figure('Name','Burner pressure ratio vs. compressor corrected mass flow rate')
scatter(compMassFlowCorrected,combustorPressureRatio)
grid minor
title("Burner pressure ratio vs. compressor corrected mass flow rate")
ylabel('Burner pressure ratio')
xlabel(sprintf('Compressor Corrected \nMass Flow Rate [kg/s]'))

set(findall(gcf,'-property','FontSize'),'FontSize',20)

%% Plot 8: FAR vs compressor corrected mass flow rate
FAR = fuelMassFlow./intakeMassFlow;

figure('Name','FAR vs. compressor corrected mass flow rate')
scatter(compMassFlowCorrected,FAR)
grid minor
title("FAR vs. compressor corrected mass flow rate")
ylabel('Fuel-Air-Ratio')
xlabel(sprintf('Compressor Corrected \nMass Flow Rate [kg/s]'))

set(findall(gcf,'-property','FontSize'),'FontSize',20)

%% Plot 9: EGT vs FAR
EGT = exitT6;                                                                                                           % exhaust gas temperature in [K]

% Create a vector of colors based on the EGT
coloursEGT = linspace(0, 1, numel(EGT));

figure('Name','EGT vs. FAR')
scatter(FAR,EGT,markerSizes,coloursEGT,"filled")
grid minor
title("EGT vs. FAR")
colormap("jet")
ylabel('Exhaust Gas Temperature [K]')
xlabel('Fuel-Air Ratio')

set(findall(gcf,'-property','FontSize'),'FontSize',20)

%% Plot 10: Compressor power vs. spool speed
compShaftPower = intakeMassFlow.*( specHeatAve_comp ).*(exitT3 - inletT2);
compShaftPowerkW = compShaftPower/1000;                                                                                 % Power in kW

turbShaftPower = compShaftPower./mechEfficiency;
turbShaftPowerkW = turbShaftPower/1000;                                                                                 % Power in kW

figure('Name','Power vs. spool speed')
title("Power vs. spool speed")
grid minor

yyaxis left
scatter(spoolSpeed,compShaftPowerkW)
xlabel(sprintf('Spool \nSpeed [rpm]'))
ylabel(sprintf('Compressor Power [kW]'))

yyaxis right
scatter(spoolSpeed,turbShaftPowerkW)
ylabel(sprintf('Turbine Power [kW]'))

set(findall(gcf,'-property','FontSize'),'FontSize',20)

%% Plot 11: Turbine isentropic efficiency vs. turbine corrected mass flow
% rate
exitT4 = turbShaftPower./(intakeMassFlow.*specHeatAve_turb) + exitT5;                                             % Formula: P_turb = m_air*Cp*(T4-T5)
isenT5 = exitT4./( (inletP4./entryP6).^( ( gamma_turb - 1)./gamma_turb ) );
turbIsen = (exitT4 - exitT5)./(exitT4 - isenT5);
turbMassFlowCorrected = massFlow.*(sqrt(exitT4/tempRef)./(inletP4/pressRef));                                   % turbine corrected mass flow rate in [kg/s]

figure('Name','Turbine isentropic efficiency vs. turbine corrected mass flow')
scatter(turbMassFlowCorrected,turbIsen)
grid minor
title("Turbine isentropic efficiency vs. turbine corrected mass flow")
ylabel('Turbine isentropic efficiency')
xlabel('Turbine corrected mass flow rate [kg/s]')

set(findall(gcf,'-property','FontSize'),'FontSize',20)

%% Plot 12: Turbine pressure ratio vs. turbine corrected mass flow rate
turbPressureRatio = entryP6./inletP4;

% Create a vector of colors based on the pressure ratio
coloursTurbPress = linspace(0, 1, numel(turbPressureRatio));

figure('Name','Turbine pressure ratio vs. turbine corrected mass flow rate')
scatter(turbMassFlowCorrected,turbPressureRatio,(flip(markerSizes)),coloursTurbPress)
grid minor
title("Turbine pressure ratio vs. turbine corrected mass flow rate")
colormap(flip(jet))
ylabel('Turbine pressure ratio')
xlabel('Turbine corrected mass flow rate [kg/s]')

set(findall(gcf,'-property','FontSize'),'FontSize',20)

%% Plot 13: Net Thrust vs compressor corrected mass flow rate
figure('Name','Net Thrust vs compressor corrected mass flow rate')
scatter(compMassFlowCorrected,thrust)
grid minor
title("Net Thrust vs compressor corrected mass flow rate")
ylabel('Net Thrust [N]')
xlabel(sprintf('Compressor Corrected \nMass Flow Rate [kg/s]'))

set(findall(gcf,'-property','FontSize'),'FontSize',20)

%% Plot 14: Net Thrust vs spool relative corrected speed
figure('Name','Net Thrust vs spool relative corrected speed')
scatter(relCorrectedSpool,thrust)
grid minor
title("Net Thrust vs spool relative corrected speed")
ylabel('Net Thrust [N]')
xlabel('Spool relative corrected speed')

set(findall(gcf,'-property','FontSize'),'FontSize',20)

% %% Plot
% figure('Name','Comparison')
% scatter(compMassFlowCorrected,exitT6)

% %% For Gasturb Model
% spoolRel = (spoolSpeed./spoolRef);
% figure('Name','Corrected Intake Mass Flow Rate vs. Spool Relative Speed')
% scatter(intakeMassFlow,spoolRel)
% xlabel('Corrected Intake Mass Flow Rate')
% ylabel('Spool Relative Speed')
% 
% % Get coefficients of a line fit through the data.
% coefficients = polyfit(intakeMassFlow, spoolRel, 1);
% 
% % Create a new x axis with exactly 1000 points
% xFit = linspace(min(intakeMassFlow), max(intakeMassFlow), 1000);
% 
% % Get the estimated yFit value for each of those 1000 new x locations.
% yFit = polyval(coefficients , xFit);
% hold on;
% plot(xFit, yFit, 'r-', 'LineWidth', 2); % Plot fitted line.
% grid on;
% 
% figure('Name','Compressor pressure ratio vs. Spool Relative Speed')
% scatter(spoolRel,compPressureRatio)
% ylabel('Compressor Pressure Ratio')
% xlabel('Spool Relative Speed')
% 
% % Get coefficients of a line fit through the data.
% coefficients1 = polyfit(spoolRel, compPressureRatio, 1);
% 
% % Create a new y axis with exactly 1000 points
% yFit1 = linspace(min(compPressureRatio), max(compPressureRatio), 1000);
% 
% % Get the estimated xFit value for each of those 1000 new x locations.
% xFit1 = polyval(coefficients1 , yFit1);
% hold on;
% plot(xFit1, yFit1, 'r-', 'LineWidth', 2); % Plot fitted line.
% grid on;

%% For CFX air intake flow
if isfile("CFX Air to Throttle.xlsx")

else 
    airIntake2throttle = table(throttlePosition,intakeMassFlow);
    writetable(airIntake2throttle,'CFX Air to Throttle.xlsx')
end

%% Useful functions
function airDensity = findDensity(pressure,gasConstant,temperature)
            % This function returns the value of the air density at a given
            % pressure within the engine. The formula used is based on the
            % ideal gas law(pV = nRT) and the following equation(p =
            % rho*RT). The density of a gas is related to the ideal gas law
            % with the following relationship: rho = n/V. 
            % Pressure values are in kPa, hence the conversion factor
            
            airDensity = (pressure)./(gasConstant.*temperature);
end
