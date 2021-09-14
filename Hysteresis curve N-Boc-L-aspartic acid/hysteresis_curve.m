clf; clear; clc;  min = 60;               %clear figure, workspace and command window

%Experimental conditions
s = 0.4/60;                 % variable to set the space velocity in sec-1. standard is 0.4
v = 1500;                   % variable that defines reactor volume in uL
Temperature = 24;           % variable that set the temperature
fluxEDC = 0;                % EDC added in mM/minute
fluxAcid2 = 30;             % Acid added in mM every minute

delta_fluxEDC = .0005;      % variable to set the increase or decrease in the fuelflux in mM/min/sec

t = 4000 * min;             % variable to set the total time of the experiment in min and transfer to sec

Fuel = 0;                   % variable to set the concentration of fuel at beginning (mM)
Acid = 0;                   % variable to set the concentration of precursor (mM)


%Calculates some parameters of the experiments based on what were the
%conditions
flowrate = s*v;             % calculates the flowrate in ul/sec
flux_out = 1-s;             % calculates the percentage of compound left in reactor after 1 s of flow out 

stockEDC = (v*1e-6*fluxEDC*1e-3)/(flowrate*60/1e6); %calculates the stock solution concentration

fluxEDC(1) = fluxEDC;       

timer = 0;                  %set counting to zero
Crystals = 0;               %variable to set whether crystals are present or not

%these are some calculations to help program the pump. They are not used in
%the further code
flowrate_out = flowrate;             %define flowrate out of reaction vessel in µL/s
flowrate_EDC = flowrate/2;           %define flowrate in EDC in µL/s
flowrate_Acid = flowrate/2;          %define flowrate in Precursor in µL/s
%netto rate must be zero.

[TurbidityTime, Turbidity, HPLCtime, HPLCedc, HPLCanhydride, HPLCprecursor, Sout, Ssat, k0, k1, k2, k3, k4] = data_loader_hys(Temperature);

Ssat = Ssat/1000;
Sout = Sout/1000;

%starting concentrations  //  Cyclic anhydrides contain two COOH functions ->
%multiplied by factor two to get COOH concentration
EDC(1)      = Fuel/1000;         %initial fuel concentration in M
COOH(1)     = Acid*2/1000;       %initial concentration of COOH groups of precursor
COOOC(1)    = 0;                 %initial anhydride concentration
COOEDC(1)   = 0;                 %initial active ester concentration
EDU(1)      = 0;                 %initial waste concentration

Assemblies = cell(1,t);     %store variable in cell array for plotting

for i=1:t
    
    timer = timer + 1;
    
   if timer >= (t)/2
       fluxEDC(i+1) = fluxEDC(i)-delta_fluxEDC; 
   else
       fluxEDC(i+1) = fluxEDC(i)+delta_fluxEDC;
 end
        fluxAcid = fluxAcid2;

    %output in graph whether there is turbidity or not
    if COOOC(i) > Ssat
        Crystals = 1;
    end
    if COOOC(i) < Sout
        Crystals = 0;
    end   
    
    %calculation reaction rates
    r0(i) = k0*EDC(i);                                  %EDC + H20 -> EDU
    r1(i) = k1*EDC(i)*COOH(i);                          %acid precursor + EDC -> O-acylurea
    r2(i) = k2*COOEDC(i);                               %O-acylurea + second carboxylic acid -> anhydride
    r3(i) = k3*COOEDC(i);                               %O-acylurea + H2O -> acid precursor + EDU
  
    %adding negative feedback on hydrolysis reaction
  if Crystals == 1
    r4(i) = k4*Sout;                                     %zero order hydrolysis of anhydride
    else
    r4(i) = k4*COOOC(i);                                %first order hydrolysis of anhydride
  end
    
    %calculation of resulting concentrations in rection mixture
    EDC(i+1)        = flux_out*EDC(i) - r1(i) - r0(i) + fluxEDC(i)/(1000*60);                        %proportion of initial concentration lost via pump out; transfer fluxEDC into M/s
    COOH(i+1)       = flux_out*COOH(i) - r1(i) - r2(i) + 2*r4(i) + r3(i) + (fluxAcid/(1000*60))*2;   %one acid molecule introduces two COOH
    COOEDC(i+1)     = flux_out*COOEDC(i) + r1(i) - r2(i) - r3(i);
    COOOC(i+1)      = flux_out*COOOC(i) + r2(i) - r4(i);
    EDU(i+1)        = flux_out*EDU(i) + r0(i) + r2(i) + r3(i);
    
    %plot CAC and Sol in graph
    CACplot(i) = Ssat;
    Solplot(i) = Sout;
    
    
    
    %create cell array
    Assemblies{i} = Crystals;                                               
    
end


figure(1);
subplot(2,2,1)
plot((1:t)/60,COOH(1:t)*1000/2, '-b');  %diveded by 2 to transfer concentration of catboxyl groups into precursor concentration
xlabel('Time [min]')
ylabel('c_{acid} [mM]')
xlim([0 t/min])
ylim([0 max(COOH)*1000*1.2])
set(gca,'FontSize', 8);

subplot(2,2,2)
hold on
plot ((1:t)/60,COOOC(1:t)*1000, '-r');
hold on
plot ((1:t)/60,CACplot*1000, '--k');
hold on
plot ((1:t)/60,Solplot*1000, '--b');
xlabel('Time [min]')
ylabel('c_{anhydride} [mM]')
xlim([0 t/min])
ylim([0 80])                       
set(gca,'FontSize', 8);

subplot(2,2,3)
plot ((1:t)/60,EDC(1:t)*1000, '-k');
hold on
xlabel('Time [min]')
ylabel('c_{EDC} [mM]')
set(gca,'FontSize', 8);

%transfer cell array into vector
Assemblies = cell2mat(Assemblies);                  

subplot(2,2,4)
plot (fluxEDC(1:t),COOOC(1:t)*1000, '-r');
hold on
xlabel('Flux of EDC (mM/min)')
ylabel('c_{anhydride} [mM]')
ylim([0 80])
xlim([0 60])
set(gca,'FontSize', 8);

%transpose data points for plotting
n = 500;                                                       %take every nth point
timeplot = transpose(1 : n : (t+1))/60;                        %time in min for plotting time of model data in excel
EDC = round(transpose(1000*EDC(1 : n : end)),2);             
COOOC = round(transpose(1000*COOOC(1 : n : end)),2);
COOH = round(transpose(500*COOH(1 : n : end)),2);              %convert carboxyl group concentration into acid precursor concentration
EDU = round(transpose(1000*EDU(1 : n : end)),2);
Assemblies = transpose(Assemblies);
HPLCtime = transpose(HPLCtime);                              
HPLCanhydride = transpose(HPLCanhydride);
HPLCprecursor = transpose(HPLCprecursor);
fluxEDC = transpose(fluxEDC(1:n:end));
