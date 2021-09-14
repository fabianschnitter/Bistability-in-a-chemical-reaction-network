function [TurbidityTime, Turbidity, HPLCtime, HPLCedc, HPLCanhydride, HPLCprecursor, k0, k1, k2, k3, k4] = data_loader_batch_glu(Fuel,Acid)
   
    HPLCtime = 0;
    HPLCedc = 0;
    HPLCanhydride = 0;
    HPLCprecursor = 0;
    TurbidityTime = 0;
    Turbidity = 0;
   
    k0 = 0.0000135;
    k1 = 0.45;               
    k2 = 0.15*k1;            
    k3 = 0.01*k1;          
    k4 = 0.0074;
    
if Acid == 100 && Fuel == 10
    HPLCtime = csvread('Data/hplc_time_100_10.dat');
    HPLCanhydride = csvread('Data/hplc_100_10.dat');
    
elseif Acid == 100 && Fuel == 20
    HPLCtime = csvread('Data/hplc_time_100_20.dat');
    HPLCanhydride = csvread('Data/hplc_100_20.dat');
    
elseif Acid == 100 && Fuel == 40
    HPLCtime = csvread('Data/hplc_time_100_40.dat');
    HPLCanhydride = csvread('Data/hplc_100_40.dat');
    
end
   
end



