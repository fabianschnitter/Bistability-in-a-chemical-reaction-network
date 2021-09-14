function [TurbidityTime, Turbidity, HPLCtime, HPLCedc, HPLCanhydride, HPLCprecursor, Sol, CAC, k0, k1, k2, k3, k4, k5] = data_loader_Asp(Fuel,Acid,Temperature,fluxEDC2)
   
    HPLCtime = 0;
    HPLCedc = 0;
    HPLCanhydride = 0;
    HPLCprecursor = 0;
    TurbidityTime = 0;
    Turbidity = 0;
    
    k0 = 0.0000135;
    k1 = 0.5;
    k2 = 0.6*k1;
    k3 = 0.05*k1;
    k4 = (0.0013*Temperature) - 0.0113;
    
    k5 = 0.28;

%data loading solubility, crystallization point and rate constants
if Temperature <= 22
    Sol = 6.5;    
    CAC = 14;     
    
    k1 = k1*1;                 
    k2 = k2*1;
    k3 = k3*1;
    
elseif Temperature > 22 && Temperature <= 26
    Sol = 7;
    CAC = 16;
    
    k1 = k1*1.14;
    k2 = k2*1.14;
    k3 = k3*1.14;
    
elseif Temperature > 26 && Temperature <= 29
    Sol = 8.9;
    CAC = 17.4;
    
    k1 = k1*1.2;
    k2 = k2*1.2;
    k3 = k3*1.2;
    
elseif Temperature > 29 && Temperature <= 32
    Sol = 11.2;    
    CAC = 20;      
    
    k1 = k1*1.4;
    k2 = k2*1.4;
    k3 = k3*1.4;
    
elseif Temperature > 32
    Sol = 11.2;
    CAC = 20;
    
    k1 = k1*1.6;
    k2 = k2*1.6;
    k3 = k3*1.6;    
    
end

%data loading experimental anhydride concentration and turbidity 
if Fuel == 0 && Acid == 100 && fluxEDC2 == 5 && Temperature == 24
    TurbidityTime = csvread('Data/turbidity_time.dat');
    Turbidity = csvread('Data/24_flux5_turb.dat');
    HPLCtime = csvread('Data/anhy_time.dat');
    HPLCanhydride = csvread('Data/anhy_24_flux5.dat');

elseif Fuel == 0 && Acid == 100 && fluxEDC2 == 10 && Temperature == 24
    TurbidityTime = csvread('Data/turbidity_time.dat');
    Turbidity = csvread('Data/24_flux10_turb.dat');
    HPLCtime = csvread('Data/anhy_time.dat');
    HPLCanhydride = csvread('Data/anhy_24_flux10.dat');
    
elseif Fuel == 0 && Acid == 100 && fluxEDC2 == 15 && Temperature == 24
    TurbidityTime = csvread('Data/turbidity_time.dat');
    Turbidity = csvread('Data/24_flux15_turb.dat');
    HPLCtime = csvread('Data/anhy_time.dat');
    HPLCanhydride = csvread('Data/anhy_24_flux15.dat');    
    
elseif Fuel == 0 && Acid == 100 && fluxEDC2 == 20 && Temperature == 24
    TurbidityTime = csvread('Data/turbidity_time.dat');
    Turbidity = csvread('Data/24_flux20_turb.dat');
    HPLCtime = csvread('Data/anhy_time.dat');
    HPLCanhydride = csvread('Data/anhy_24_flux20.dat');

elseif Fuel == 0 && Acid == 100 && fluxEDC2 == 25 && Temperature == 24
    TurbidityTime = csvread('Data/turbidity_time.dat');
    Turbidity = csvread('Data/24_flux25_turb.dat');
    HPLCtime = csvread('Data/anhy_time.dat');
    HPLCanhydride = csvread('Data/anhy_24_flux25.dat');
    
elseif Fuel == 0 && Acid == 100 && fluxEDC2 == 30 && Temperature == 24
    TurbidityTime = csvread('Data/turbidity_time.dat');
    Turbidity = csvread('Data/24_flux30_turb.dat');
    HPLCtime = csvread('Data/anhy_time.dat');
    HPLCanhydride = csvread('Data/anhy_24_flux30.dat');
    
elseif Fuel == 0 && Acid == 100 && fluxEDC2 == 35 && Temperature == 24
    TurbidityTime = csvread('Data/turbidity_time.dat');
    Turbidity = csvread('Data/24_flux35_turb.dat');
    HPLCtime = csvread('Data/anhy_time.dat');
    HPLCanhydride = csvread('Data/anhy_24_flux35.dat');
    
elseif Fuel == 0 && Acid == 100 && fluxEDC2 == 40 && Temperature == 24
    TurbidityTime = csvread('Data/turbidity_time.dat');
    Turbidity = csvread('Data/24_flux40_turb.dat');
    HPLCtime = csvread('Data/anhy_time.dat');
    HPLCanhydride = csvread('Data/anhy_24_flux40.dat');
    
elseif Fuel == 80 && Acid == 100 && fluxEDC2 == 5 && Temperature == 24
    TurbidityTime = csvread('Data/turbidity_time.dat');
    Turbidity = csvread('Data/spike_24_flux5_turb.dat');
    HPLCtime = csvread('Data/anhy_time.dat');
    HPLCanhydride = csvread('Data/spike_anhy_24_flux5.dat');

elseif Fuel == 80 && Acid == 100 && fluxEDC2 == 10 && Temperature == 24
    TurbidityTime = csvread('Data/turbidity_time.dat');
    Turbidity = csvread('Data/spike_24_flux10_turb.dat');
    HPLCtime = csvread('Data/anhy_time.dat');
    HPLCanhydride = csvread('Data/spike_anhy_24_flux10.dat');
    
elseif Fuel == 80 && Acid == 100 && fluxEDC2 == 15 && Temperature == 24
    TurbidityTime = csvread('Data/turbidity_time.dat');
    Turbidity = csvread('Data/spike_24_flux15_turb.dat');
    HPLCtime = csvread('Data/anhy_time.dat');
    HPLCanhydride = csvread('Data/spike_anhy_24_flux15.dat');    
    
elseif Fuel == 80 && Acid == 100 && fluxEDC2 == 20 && Temperature == 24
    TurbidityTime = csvread('Data/turbidity_time.dat');
    Turbidity = csvread('Data/spike_24_flux20_turb.dat');
    HPLCtime = csvread('Data/anhy_time.dat');
    HPLCanhydride = csvread('Data/spike_anhy_24_flux20.dat');
    
elseif Fuel == 80 && Acid == 100 && fluxEDC2 == 25 && Temperature == 24
    TurbidityTime = csvread('Data/turbidity_time.dat');
    Turbidity = csvread('Data/spike_24_flux25_turb.dat');
    HPLCtime = csvread('Data/anhy_time.dat');
    HPLCanhydride = csvread('Data/spike_anhy_24_flux25.dat');
    
elseif Fuel == 80 && Acid == 100 && fluxEDC2 == 30 && Temperature == 24
    TurbidityTime = csvread('Data/turbidity_time.dat');
    Turbidity = csvread('Data/spike_24_flux30_turb.dat');
    HPLCtime = csvread('Data/anhy_time.dat');
    HPLCanhydride = csvread('Data/spike_anhy_24_flux30.dat');
    
elseif Fuel == 80 && Acid == 100 && fluxEDC2 == 35 && Temperature == 24
    TurbidityTime = csvread('Data/turbidity_time.dat');
    Turbidity = csvread('Data/spike_24_flux35_turb.dat');
    HPLCtime = csvread('Data/anhy_time.dat');
    HPLCanhydride = csvread('Data/spike_anhy_24_flux35.dat');
    
elseif Fuel == 80 && Acid == 100 && fluxEDC2 == 40 && Temperature == 24
    TurbidityTime = csvread('Data/turbidity_time.dat');
    Turbidity = csvread('Data/spike_24_flux40_turb.dat');
    HPLCtime = csvread('Data/anhy_time.dat');
    HPLCanhydride = csvread('Data/spike_anhy_24_flux40.dat');
    
elseif Fuel == 0 && Acid == 100 && fluxEDC2 == 15 && Temperature == 21
    TurbidityTime = csvread('Data/turbidity_time.dat');
    Turbidity = csvread('Data/21_flux15_turb.dat');

elseif Fuel == 0 && Acid == 100 && fluxEDC2 == 10 && Temperature == 21
    TurbidityTime = csvread('Data/turbidity_time.dat');
    Turbidity = csvread('Data/21_flux10_turb.dat');
    
elseif Fuel == 0 && Acid == 100 && fluxEDC2 == 20 && Temperature == 21
    TurbidityTime = csvread('Data/turbidity_time.dat');
    Turbidity = csvread('Data/21_flux20_turb.dat');
       
elseif Fuel == 0 && Acid == 100 && fluxEDC2 == 25 && Temperature == 21
    TurbidityTime = csvread('Data/turbidity_time.dat');
    Turbidity = csvread('Data/21_flux25_turb.dat');
    
elseif Fuel == 0 && Acid == 100 && fluxEDC2 == 30 && Temperature == 21
    TurbidityTime = csvread('Data/turbidity_time.dat');
    Turbidity = csvread('Data/21_flux30_turb.dat');
    
elseif Fuel == 80 && Acid == 100 && fluxEDC2 == 10 && Temperature == 21
    TurbidityTime = csvread('Data/turbidity_time.dat');
    Turbidity = csvread('Data/spike_21_flux10_turb.dat');
    
elseif Fuel == 80 && Acid == 100 && fluxEDC2 == 15 && Temperature == 21
    TurbidityTime = csvread('Data/turbidity_time.dat');
    Turbidity = csvread('Data/spike_21_flux15_turb.dat');    
    
elseif Fuel == 80 && Acid == 100 && fluxEDC2 == 20 && Temperature == 21
    TurbidityTime = csvread('Data/turbidity_time.dat');
    Turbidity = csvread('Data/spike_21_flux20_turb.dat');
        
elseif Fuel == 80 && Acid == 100 && fluxEDC2 == 25 && Temperature == 21
    TurbidityTime = csvread('Data/turbidity_time.dat');
    Turbidity = csvread('Data/spike_21_flux25_turb.dat');
        
elseif Fuel == 80 && Acid == 100 && fluxEDC2 == 30 && Temperature == 21
    TurbidityTime = csvread('Data/turbidity_time.dat');
    Turbidity = csvread('Data/spike_21_flux30_turb.dat');
    
elseif Fuel == 0 && Acid == 100 && fluxEDC2 == 30 && Temperature == 28
    TurbidityTime = csvread('Data/turbidity_time.dat');
    Turbidity = csvread('Data/28_flux30_turb.dat');
    
elseif Fuel == 0 && Acid == 100 && fluxEDC2 == 35 && Temperature == 28
    TurbidityTime = csvread('Data/turbidity_time.dat');
    Turbidity = csvread('Data/28_flux35_turb.dat');
    
elseif Fuel == 0 && Acid == 100 && fluxEDC2 == 40 && Temperature == 28
    TurbidityTime = csvread('Data/turbidity_time.dat');
    Turbidity = csvread('Data/28_flux40_turb.dat');
    
elseif Fuel == 0 && Acid == 100 && fluxEDC2 == 45 && Temperature == 28
    TurbidityTime = csvread('Data/turbidity_time.dat');
    Turbidity = csvread('Data/28_flux45_turb.dat');
    
elseif Fuel == 80 && Acid == 100 && fluxEDC2 == 10 && Temperature == 28
    TurbidityTime = csvread('Data/turbidity_time.dat');
    Turbidity = csvread('Data/spike_28_flux10_turb.dat');
    
elseif Fuel == 80 && Acid == 100 && fluxEDC2 == 20 && Temperature == 28
    TurbidityTime = csvread('Data/turbidity_time.dat');
    Turbidity = csvread('Data/spike_28_flux20_turb.dat');
    
elseif Fuel == 80 && Acid == 100 && fluxEDC2 == 25 && Temperature == 28
    TurbidityTime = csvread('Data/turbidity_time.dat');
    Turbidity = csvread('Data/spike_28_flux25_turb.dat');
    
elseif Fuel == 80 && Acid == 100 && fluxEDC2 == 35 && Temperature == 28
    TurbidityTime = csvread('Data/turbidity_time.dat');
    Turbidity = csvread('Data/spike_28_flux35_turb.dat');
    
elseif Fuel == 0 && Acid == 100 && fluxEDC2 == 50 && Temperature == 33
    TurbidityTime = csvread('Data/turbidity_time.dat');
    Turbidity = csvread('Data/33_flux50_turb.dat');
    
elseif Fuel == 0 && Acid == 100 && fluxEDC2 == 55 && Temperature == 33
    TurbidityTime = csvread('Data/turbidity_time.dat');
    Turbidity = csvread('Data/33_flux55_turb.dat');

elseif Fuel == 80 && Acid == 100 && fluxEDC2 == 10 && Temperature == 33
    TurbidityTime = csvread('Data/turbidity_time.dat');
    Turbidity = csvread('Data/spike_33_flux10_turb.dat');
    
elseif Fuel == 80 && Acid == 100 && fluxEDC2 == 30 && Temperature == 33
    TurbidityTime = csvread('Data/turbidity_time.dat');
    Turbidity = csvread('Data/spike_33_flux30_turb.dat');
        
end
   
end



