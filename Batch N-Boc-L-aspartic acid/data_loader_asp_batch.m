function [TurbidityTime, Turbidity, HPLCtime, HPLCedc, HPLCanhydride, HPLCprecursor, Sol, CAC, k0, k1, k2, k3, k4] = data_loader_asp_batch(Fuel,Acid,Temperature)
   
    HPLCtime = 0;
    HPLCedc = 0;
    HPLCanhydride = 0;
    HPLCprecursor = 0;
    TurbidityTime = 0;
    Turbidity = 0;
    
    %starting values at 21°C
    k0 = 0.0000135;
    k1 = 0.5;
    k2 = 0.6*k1;
    k3 = 0.05*k1;
    k4 = (0.0013*Temperature) - 0.0113;
    
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

if Acid == 100 && Fuel == 60 && Temperature == 28
    HPLCtime = csvread('Data/hplc_time_100_60.dat');
    HPLCanhydride = csvread('Data/hplc_100_60.dat');

elseif Acid == 100 && Fuel == 20 && Temperature == 21
    HPLCtime = csvread('Data/hplc_time_100_20.dat');
    HPLCanhydride = csvread('Data/hplc_100_20_21.dat');

elseif Acid == 100 && Fuel == 20 && Temperature == 25
    HPLCtime = csvread('Data/hplc_time_100_20.dat');
    HPLCanhydride = csvread('Data/hplc_100_20_25.dat');
    
elseif Acid == 100 && Fuel == 20 && Temperature == 28
    HPLCtime = csvread('Data/hplc_time_100_20.dat');
    HPLCanhydride = csvread('Data/hplc_100_20_28.dat');
    
elseif Acid == 100 && Fuel == 20 && Temperature == 31
    HPLCtime = csvread('Data/hplc_time_100_20.dat');
    HPLCanhydride = csvread('Data/hplc_100_20_31.dat');
    
elseif Acid == 100 && Fuel == 20 && Temperature == 33  
    HPLCtime = csvread('Data/hplc_time_100_20.dat');
    HPLCanhydride = csvread('Data/hplc_100_20_33.dat');
        
end
   
end



