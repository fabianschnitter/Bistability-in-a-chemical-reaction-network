clf
clear; min = 60; t = 10 * min;   %set time in minutes and transfer into seconds

Temperature = 33;                %21, 25, 28, 31, 33                             

Acid = 100;                      
Fuel = 20;                       %20 mM for kinetics                    
                                 
EDC(1)      = Fuel/1000;         %initial fuel concentration in M
COOH(1)     = Acid*2/1000;       %initial concentration of COOH groups of precursor
COOOC(1)    = 0;                 %initial anhydride concentration
COOEDC(1)   = 0;                 %initial active ester concentration
EDU(1)      = 0;                 %initial waste concentration
Assembly    = 0;
Assemblies = cell(1,t);          %store variable in cell array for plotting

[TurbidityTime, Turbidity, HPLCtime, HPLCedc, HPLCanhydride, HPLCprecursor, Sol, CAC, k0, k1, k2, k3, k4] = data_loader_asp_batch(Fuel,Acid,Temperature); %this will load all the data.

CAC = CAC/1000;
Sol = Sol/1000;

for i=1:t
   
    if COOOC(i) > CAC
        Assembly = 1;
    end
    if COOOC(i) < Sol
        Assembly = 0;
    end   
       
    %calculation reaction rates
    r0(i) = k0*EDC(i);                                  %EDC + H20 -> EDU
    r1(i) = k1*EDC(i)*COOH(i);                          %acid precursor + EDC -> O-acylurea
    r2(i) = k2*COOEDC(i);                               %O-acylurea + second carboxylic acid -> anhydride
    r3(i) = k3*COOEDC(i);                               %O-acylurea + H2O -> acid precursor + EDU
                                                        
    if Assembly == 1
        r4(i) = k4*Sol;                                 %zero order hydrolysis of anhydride
    else
        r4(i) = k4*COOOC(i);                            %first order hydrolysis of anhydride
    end
    
    EDC(i+1)        = EDC(i) - r1(i) - r0(i);
    COOH(i+1)       = COOH(i) - r1(i) - r2(i) + 2*r4(i) + r3(i);
    COOEDC(i+1)     = COOEDC(i) + r1(i) - r2(i) - r3(i);
    COOOC(i+1)      = COOOC(i) + r2(i) - r4(i);
    EDU(i+1)        = EDU(i) + r0(i) + r2(i) + r3(i);
    
    CACplot(i) = CAC*1000;
    Solplot(i) = Sol*1000;
    
    Assemblies{i} = Assembly;                                               %create cell array
    
end

m=max(COOOC(:))*1000;
solcal=COOOC(130)*1000;

figure(1);
subplot(2,2,1)
plot((1:t)/60,COOH(1:t)*1000/2, '-b');  %diveded by 2 to transfer concentration of catboxyl groups into precursor concentration
xlabel('Time [min]')
ylabel('c_{acid} [mM]')
xlim([0 t/min])
ylim([0 100])
set(gca,'FontSize', 8);

subplot(2,2,2)
plot (HPLCtime,HPLCanhydride, 'xr');
hold on
plot ((1:t)/60,COOOC(1:t)*1000, '-r');
hold on
plot ((1:t)/60,CACplot, '--k');
hold on
plot ((1:t)/60,Solplot, '--b');
xlabel('Time [min]')
ylabel('c_{anhydride} [mM]')
title(['Acid ' num2str(Acid) ' mM' '   ' 'EDC ' num2str(Fuel) ' mM' '   ' 'Temperature ' num2str(Temperature) '°C'])
xlim([0 t/min])
ylim([0 max(COOOC)*1000*1.2])
set(gca,'FontSize', 8);

subplot(2,2,3)
plot ((1:t)/60,EDC(1:t)*1000, '-k');
xlabel('Time [min]')
ylabel('c_{EDC} [mM]')
xlim([0 t/min])
ylim([0 100])
set(gca,'FontSize', 8);

Assemblies = cell2mat(Assemblies);                  %transfer cell array into vector

subplot(2,2,4)
plot (TurbidityTime,Turbidity, '.k');
hold on
plot ((1:t)/60,Assemblies, '-r');
hold on
xlabel('Time [min]')
ylabel('Turbidity')
ylim([0 1.1])
xlim([0 t/min])
set(gca,'FontSize', 8);

%transpose data points for plotting
n = 1;                                                      %take every 10th point
timeplot = transpose(1 : n : (t+1))/60;                     %time in min for plotting time of model data in excel
EDC = round(transpose(1000*EDC(1 : n : end)),2);             
COOOC = round(transpose(1000*COOOC(1 : n : end)),2);
COOH = round(transpose(500*COOH(1 : n : end)),2);           %convert carboxyl group concentration into acid precursor concentration
EDU = round(transpose(1000*EDU(1 : n : end)),2);
HPLCtime = transpose(HPLCtime);                              
HPLCanhydride = transpose(HPLCanhydride);
HPLCprecursor = transpose(HPLCprecursor);