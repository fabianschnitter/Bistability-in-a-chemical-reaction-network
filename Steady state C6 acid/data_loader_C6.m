function [TurbidityTime, Turbidity, HPLCtime, HPLCedc, HPLCanhydride, HPLCprecursor, Sol, CAC, k0, k1, k2, k3, k4] = data_loader_C6(Fuel,Acid,Temperature,fluxEDC2)
   
    HPLCtime = 0;
    HPLCedc = 0;
    HPLCanhydride = 0;
    HPLCprecursor = 0;
    TurbidityTime = 0;
    Turbidity = 0;
    
    k0 = 0.0000135;
    k1 = 0.2;
    k2 = 1*k1;
    k3 = 0.25*k1;
    k4 = 0.0035;
    
%data loading solubility, crystallization point and rate constants
if Temperature == 25
    Sol = 3.5;
    CAC = 3.5;
    
    k1 = k1*1;                 
    k2 = k2*1;
    k3 = k3*1;
   
end

%data loading experimental anhydride concentration and turbidity 
if Fuel == 0 && Acid == 10 && fluxEDC2 == 1 && Temperature == 25
    HPLCtime = csvread('Data/anhy_time.dat');
    HPLCanhydride = csvread('Data/anhy_24_flux1.dat');

elseif Fuel == 0 && Acid == 10 && fluxEDC2 == 3 && Temperature == 25
    HPLCtime = csvread('Data/anhy_time.dat');
    HPLCanhydride = csvread('Data/anhy_24_flux3.dat');
    
elseif Fuel == 0 && Acid == 10 && fluxEDC2 == 6 && Temperature == 25
    HPLCtime = csvread('Data/anhy_time_2.dat');
    HPLCanhydride = csvread('Data/anhy_24_flux6.dat');    
    
elseif Fuel == 0 && Acid == 10 && fluxEDC2 == 9 && Temperature == 25
    HPLCtime = csvread('Data/anhy_time_2.dat');
    HPLCanhydride = csvread('Data/anhy_24_flux9.dat');
    
elseif Fuel == 50 && Acid == 10 && fluxEDC2 == 1 && Temperature == 25
    HPLCtime = csvread('Data/anhy_time.dat');
    HPLCanhydride = csvread('Data/spike_anhy_24_flux1.dat');
    
elseif Fuel == 50 && Acid == 10 && fluxEDC2 == 3 && Temperature == 25
    HPLCtime = csvread('Data/anhy_time.dat');
    HPLCanhydride = csvread('Data/spike_anhy_24_flux3.dat');
    
elseif Fuel == 50 && Acid == 10 && fluxEDC2 == 6 && Temperature == 25
    HPLCtime = csvread('Data/anhy_time_2.dat');
    HPLCanhydride = csvread('Data/spike_anhy_24_flux6.dat');
    
elseif Fuel == 50 && Acid == 10 && fluxEDC2 == 9 && Temperature == 25
    HPLCtime = csvread('Data/anhy_time_2.dat');
    HPLCanhydride = csvread('Data/spike_anhy_24_flux9.dat');
    
end
   
end



