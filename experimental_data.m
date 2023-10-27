% Preparing the data 
experimentalData = readtable("Test Data B1.xlsx");

% Separating the columns
throttlePosition = experimentalData(:,3);       % represented as a percentage
inletT2 = experimentalData(:,4);                % absolute temperature at station T2's inlet
inletT3 = experimentalData(:,5);                % absolute temperature at compressor entry(station T3)
exitT4 = experimentalData(:,6);                 % absolute,total temperature at combustor exit(station T4)
exitT5 = experimentalData(:,7);                 % absolute, total temperature at turbine exit(station T5)
exitT6 = experimentalData(:,8);                 % absolute, total nozzle exhaust temperature(station T6)
ambPressure = experimentalData(:,9);            % ambient pressure(P_0)
inletRaw = experimentalData(:,10);
inletOffset = experimentalData(:,11);
inletP1 = experimentalData(:,12);               % static inlet presure(p_1)
compRaw = experimentalData(:,13);
compOffset = experimentalData(:,14);
exitP3 = experimentalData(:,15);                % static compressor exit pressure(p_3) at station P3
combRaw = experimentalData(:,16);
combOffset = experimentalData(:,17);
inletP3 = experimentalData(:,18);               % total combustor inlet pressure(P_3) at station P3
turbRaw = experimentalData(:,19);
turbOffest = experimentalData(:,20);
inletP4 = experimentalData(:,21);               % absolute turbine inlet static pressure(P_4) at station P4
exhaustRaw = experimentalData(:,22);
exhaustOffset = experimentalData(:,23);
entryP6 = experimentalData(:,24);               % absolute nozzle entry pressure(P_6) at station P6
thrustRaw = experimentalData(:,25);
thrustOffset = experimentalData(:,26);
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
