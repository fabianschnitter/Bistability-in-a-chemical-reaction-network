clf
clear; min = 60; t = 25 * min;   %set time in minutes and transfer into seconds

Temperature = 24;                %24                             
Acid = 100;                      
Fuel = 20;                                          
                                 
EDC(1)      = Fuel/1000;         %initial fuel concentration in M
COOH(1)     = Acid*2/1000;       %initial concentration of COOH groups of precursor
COOOC(1)    = 0;                 %initial anhydride concentration
COOEDC(1)   = 0;                 %initial active ester concentration
EDU(1)      = 0;                 %initial waste concentration

[TurbidityTime, Turbidity, HPLCtime, HPLCedc, HPLCanhydride, HPLCprecursor, k0, k1, k2, k3, k4] = data_loader_batch_glu(Fuel,Acid); %this will load all the data.


for i=1:t
           
    %calculation reaction rates
    r0(i) = k0*EDC(i);                                  %EDC + H20 -> EDU
    r1(i) = k1*EDC(i)*COOH(i);                          %acid precursor + EDC -> O-acylurea
    r2(i) = k2*COOEDC(i);
    r3(i) = k3*COOEDC(i);  
    r4(i) = k4*COOOC(i); 
        
    EDC(i+1)        = EDC(i) - r1(i) - r0(i);
    COOH(i+1)       = COOH(i) - r1(i) - r2(i) + 2*r4(i) + r3(i);
    COOEDC(i+1)     = COOEDC(i) + r1(i) - r2(i) - r3(i);
    COOOC(i+1)      = COOOC(i) + r2(i) - r4(i);
    EDU(i+1)        = EDU(i) + r0(i) + r2(i) + r3(i);
         
end

figure(1);
subplot(2,2,1)
plot((1:t)/60,COOH(1:t)*1000/2, '-b');  %diveded by 2 to transfer concentration of catboxyl groups into precursor concentration
xlabel('Time [min]')
ylabel('c_{acid} [mM]')
xlim([0 t/min])
ylim([0 Acid])
set(gca,'FontSize', 8);

subplot(2,2,2)
plot (HPLCtime,HPLCanhydride, 'xr');
hold on
plot ((1:t)/60,COOOC(1:t)*1000, '-r');
xlabel('Time [min]')
ylabel('c_{anhydride} [mM]')
title(['Acid ' num2str(Acid) ' mM' '   ' 'EDC ' num2str(Fuel) ' mM' '   ' 'Temperature ' num2str(Temperature) '°C'])
xlim([0 t/min])
ylim([0 max(COOOC)*1000*1.2])
set(gca,'FontSize', 8);

subplot(2,2,3)
plot ((1:t)/60,EDC(1:t)*1000, '-k');
xlabel('Time [min]')
ylabel('c_{COOEDC} [mM]')
xlim([0 t/min])
ylim([0 max(EDC)*1000*2])
set(gca,'FontSize', 8);

subplot(2,2,4)
plot (TurbidityTime,Turbidity, '.k');
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
HPLCanhydride = round(HPLCanhydride, 2);
HPLCprecursor = transpose(HPLCprecursor);
