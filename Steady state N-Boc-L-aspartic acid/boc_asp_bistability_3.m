%experimental data implemented un/spiked at fluxEDC2
%concentrations only for 24 캜
%21 캜: see paper
%24 캜: 5, 10, 15, 20, 25, 30, 35, 40
%28 캜: see paper
%33 캜: see paper

clf; clear; clc;            %clear figure, workspace and command window

min = 60;                   %variable to transfer minutes into seconds
z = 0;                      %set counting to zero
Assembly = 0;               %starting value for variable
s = 1;                      %define space velocity
timeSSconc = 15*min;

Temperature = 24;
Fuel = 80;                   %amount EDC added in mM at the beginning before the pumps are started (0/80)
Acid = 100;                 %amount precursor added in mM at the beginning

%%timepoint for additional spikes
x1 = 10*60;

fluxEDC2 = 40;              %EDC added in mM every minute; change for different experimental conditions
fluxAcid2 = 30;             %Acid added in mM every minute; not changed in experiments

t = 30 * min;               %set time of experiment in minutes and transfer into seconds

v = 1.5;                    %define reaction volume in mL

startpulse = 1*60;          %start fluxes/pumps after x minute of initual EDC addition
timeup = 30*min;            %turn off pumps after x minutes

%%%%set these conditions in the experimental setup
flowrate_out = 0.6*1000/60;          %define flowrate out of reaction vessel in 킠/s 
flowrate_EDC = 0.3*1000/60;          %define flowrate in EDC in 킠/s         
flowrate_Acid = 0.3*1000/60;         %define flowrate in Precursor in 킠/s           
%netto rate must be zero.

volumeEDC = ((timeup-startpulse)*flowrate_EDC)/1000;       %in mL
volumeAcid = ((timeup-startpulse)*flowrate_Acid)/1000;     %in mL
volumeout = ((timeup-startpulse)*flowrate_out)/1000;       %in mL

EDCstock = ((fluxEDC2/60)*(v*1000))/flowrate_EDC;       %in mM
Acidstock = ((fluxAcid2/60)*(v*1000))/flowrate_Acid;     %in mM

massEDC = EDCstock*(volumeEDC/1000)*191.70;          %in mg
massAcid = Acidstock*(volumeAcid/1000)*233.23;       %in mg
%%%%set these conditions in the experimental setup

%calculate the amount of compounds left in reaction vessel after 1 s of flow out
%e.g. 10 킠 flow out per sec. of a total 1.5 mL -> 10 킠 / 1500 킠
flux_out = 1-(flowrate_out/(v*1000));       % unit is %/100  // for first flux
flux_out2 = 1-(flowrate_out/(v*1000));      % unit is %/100  // for second flux

[TurbidityTime, Turbidity, HPLCtime, HPLCedc, HPLCanhydride, HPLCprecursor, Sol, CAC, k0, k1, k2, k3, k4, k5] = data_loader_Asp(Fuel,Acid,Temperature,fluxEDC2);

CAC = CAC/1000;
Sol = Sol/1000;

%starting concentrations  //  Cyclic anhydrides contain two COOH functions ->
%multiplied by factor two to get COOH concentration
EDC(1)      = Fuel/1000;         %initial fuel concentration in M
COOH(1)     = Acid*2/1000;       %initial concentration of COOH groups of precursor
COOOC(1)    = 0;                 %initial anhydride concentration
COOEDC(1)   = 0;                 %initial active ester concentration
EDU(1)      = 0;                 %initial waste concentration

Assemblies = cell(1,t);     %store variable in cell array for plotting

for i=1:t
    
    z = z + 1;
    
    if z < startpulse
      fluxEDC = 0;
      fluxAcid = 0; 
      flux_out = 1;
    end
    
    if z >= startpulse
        fluxEDC = fluxEDC2;
        fluxAcid = fluxAcid2;
        flux_out = flux_out2;
    end
    
    if z >= timeup
        fluxEDC = 0;
        fluxAcid = 0;
        flux_out = 1;
    end
    
    if z == x1          %add || to add further times
        addFlux = 0;    %set to zero when no flux should be added
    else
        addFlux = 0;
    end
    
    %output in graph whether there is turbidity or not
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
    
    %adding negative feedback on hydrolysis reaction
  if Assembly == 1
    r4(i) = k4*Sol;                                     %zero order hydrolysis of anhydride
    else
    r4(i) = k4*COOOC(i);                                %first order hydrolysis of anhydride
  end
    
    %calculation of resulting concentrations in rection mixture
    EDC(i+1)        = flux_out*EDC(i) - r1(i) - r0(i) + fluxEDC/(1000*60) + addFlux/1000;            %proportion of initial concentration lost via pump out; transfer fluxEDC into M/s
    COOH(i+1)       = flux_out*COOH(i) - r1(i) - r2(i) + 2*r4(i) + r3(i) + (fluxAcid/(1000*60))*2;   %one acid molecule introduces two COOH
    COOEDC(i+1)     = flux_out*COOEDC(i) + r1(i) - r2(i) - r3(i);
    COOOC(i+1)      = flux_out*COOOC(i) + r2(i) - r4(i);
    EDU(i+1)        = flux_out*EDU(i) + r0(i) + r2(i) + r3(i);
    
    %plot CAC and Sol in graph
    CACplot(i) = CAC;
    Solplot(i) = Sol;
    
    %create cell array
    Assemblies{i} = Assembly;                                               
    
end

SSconc = COOOC(1,timeSSconc)*1000;          %calculates steady state concentration in mM

figure(1);
subplot(2,2,1)
plot((1:t)/60,COOH(1:t)*1000/2, '-b');      %diveded by 2 to transfer concentration of catboxyl groups into precursor concentration
xlabel('Time [min]')
ylabel('c_{acid} [mM]')
xlim([0 t/min])
ylim([0 max(COOH)*1000*1.2])
set(gca,'FontSize', 8);

subplot(2,2,2)
plot (HPLCtime,HPLCanhydride, 'xr');
hold on
plot ((1:t)/60,COOOC(1:t)*1000, '-r');
hold on
plot ((1:t)/60,CACplot*1000, '--k');
hold on
plot ((1:t)/60,Solplot*1000, '--b');
xlabel('Time [min]')
ylabel('c_{anhydride} [mM]')
xlim([0 t/min])
ylim([0 80])                       %max(COOOC)*1000*1.2
set(gca,'FontSize', 8);

subplot(2,2,3)
plot ((1:t)/60,EDC(1:t)*1000, '-k');
xlabel('Time [min]')
ylabel('c_{EDC} [mM]')
xlim([0 t/min])
ylim([0 100])
set(gca,'FontSize', 8);

%transfer cell array into vector
Assemblies = cell2mat(Assemblies);                  

subplot(2,2,4)
plot (TurbidityTime,Turbidity, '.k');
hold on
plot ((1:t)/60,Assemblies, '-r');
hold on
xlabel('Time [min]')
ylabel('Turbidity')
ylim([0 1.2])
xlim([0 t/min])
set(gca,'FontSize', 8);

%transpose data points for plotting
n = 10;                                                        %take every 10th point
timeplot = transpose(1 : n : (t+1))/60;                        %time in min for plotting time of model data in excel
EDC = round(transpose(1000*EDC(1 : n : end)),2);             
COOOC = round(transpose(1000*COOOC(1 : n : end)),2);
COOH = round(transpose(500*COOH(1 : n : end)),2);              %convert carboxyl group concentration into acid precursor concentration
EDU = round(transpose(1000*EDU(1 : n : end)),2);
Assemblies = transpose(Assemblies);
HPLCtime = transpose(HPLCtime);                              
HPLCanhydride = transpose(HPLCanhydride);
HPLCprecursor = transpose(HPLCprecursor);