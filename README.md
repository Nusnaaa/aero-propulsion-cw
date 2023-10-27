# aero-propulsion-cw
The official repository for all MATLAB and related programming files for group 6's Aero-Propulsion coursework. The following text was lifted from the coursework brief provided to us by the university.

# Project Background
Numerical modelling of a gas turbine engine is an integral process in engine 
development and analysis, used widely in industry and research. In this coursework, 
you will use a small gas turbine engine (AMT Olympus on Armfield CM14 test rig) to 
obtain the experimental data, and GasTurb to model the engine. To simulate the 
combustion process, you will use ANSYS CFX.

# Key Aims, Requirements (Tasks) and Provided Files
Key Aims:  
    Experiment: 
    - To gain experience in conducting experimental testing of a gas turbine 
    engine, including test data collection. 
    -  organise, plot, and examine the raw experimental data. 
    - To improve the fidelity of the test data, if necessary, using literatures and 
    sound engineering judgement. 
    - To process the data and produce plots of key parameters of the engine 
    performance. 
    Modelling: 
    - To model on-design point of the engine and validate the model. 
    - To model off-design points of the engine and compare with the experimental 
    results. 
    - To provide suggestions on how to improve the model. 
    Combustion CFD: 
    - To gain experience in how combustion is modelled computationally. 
    - To simulate fuel and combustion flame fronts. 
    - To consider flow parameters that affect the efficiency of combustion. 
    - To investigate the methods which will produce the most accurate results 
    compared to the experiment and/or the model.

Requirements (Tasks): 
    
    Experiment:
        - The experimental test will be supervised by qualified technicians. You will 
        have the opportunity to learn the test rig setup, including its various controls 
        and sensors. Test data will be collected at several throttle settings.
        - Before modelling the engine, you will need to process and evaluate the raw 
        data obtained from the test. You may use Excel, Matlab, or any other 
        software that you are familiar with. First, you will need to evaluate the fidelity 
        of the raw data, identify any deficiencies or anomalies, and perform further 
        calculations to remedy the data. You may need to conduct literature 
        research to obtain any missing values.
        - Plot some key parameters based on the experimental data, analyse and 
        compare them with literatures:
            1. Mass flow rate vs. throttle percentage
            2. Intake pressure loss vs. throttle percentage
            3. Compressor pressure ratio vs. spool relative corrected speed
            4. Compressor corrected mass flow rate vs. spool relative corrected 
            speed
            5. Compressor isentropic efficiency vs. compressor corrected mass 
            flow rate
            6. Compressor exit Mach number vs. compressor corrected mass flow 
            rate
            7. Burner pressure ratio vs. compressor corrected mass flow rate
            8. FAR vs. compressor corrected mass flow rate
            9. EGT vs. FAR
            10. Compressor shaft power vs. spool speed, and compare it with the 
            turbine
            11. Turbine isentropic efficiency vs. turbine corrected mass flow rate
            12. Turbine pressure ratio vs. turbine corrected mass flow rate
            13. Net thrust vs. compressor corrected mass flow rate
            14. Net thrust vs. spool relative corrected speed
        - Summarise the findings from the experimental data and the corrective steps you have taken to improve the test data quality and accuracy. 

    GasTurb: 
        - Based on the experimental results and your analysis, model in GasTurb the 
        on-design point of the engine at 100% relative spool speed. Compare the 
        model with the experimental results, and use good engineering judgement 
        to tweak and improve the accuracy of the model. 
        - Explore the engine model in off-design mode. You can start with the 
        standard compressor map. Plot the operating lines for compressor 
        (pressure ratio vs. corrected mass flow rate) and compare them with the 
        experimental data. Also plot the net thrust vs. compressor corrected mass 
        flow rate, and EGT vs. compressor corrected mass flow rate. Compare them 
        with the experimental data. You can read in/import the experimental data. 
        Use the provided template: Sample_Test_Data.tst. 
        - Summarise your GasTurb model and suggest how to improve its accuracy. 
        Combustion CFD: 
        - You will need to simulate the combustion process in test engine’s burner 
        using ANSYS CFX. Use the provided Can Combustor mesh for the tutorial 
        examples, and take the set-up in the example as the starting point for your 
        investigation. 
        - After completing the tutorial, you need to identify key parameters and 
        numerical models which are important to model the chemical process that 
        you wish to change/alter over possible variation ranges to assess their 
        impacts in the simulation results. The input parameters, e.g. inlet 
        temperature, pressure, and mass flow rates, should be taken from the 
        experimental data and/or the results of your GasTurb model. 
        - As there are a number of parameters, you are advised to consider some of 
        these parameters and models, especially the ones (e.g. the air/fuel mass 
        flow ratio, inlet fuel temperature, turbulence and radiation models etc.) that 
        are influential to the problem. You may need to use literatures and good 
        engineering judgement in cases where experimental or model data is not 
        available. 
        - Once you have completed the simulations, you will need to record the 
        combustion exit temperature, pressure and emissions as calculated by 
        ANSYS CFX and compare the values with the experimental and/or GasTurb 
        results. 
        - Summarise the results of your CFD simulation and provide suggestions to 
        improve its accuracy. 

    Provided Files: 
        - Engine test rig (Armfield CM14) manual 
        - Engine test data (will be provided after the test) 
        - Template file for importing data into GasTurb: GasTurb_Input_Template.tst 
        - A tutorial example of ‘Can combustor’ CFD modelling, along with the CAD geometry and basic meshing files (on Blackboard: Assignments/Combustion CFD) 
