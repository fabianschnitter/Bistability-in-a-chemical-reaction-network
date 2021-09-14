function [TurbidityTime, Turbidity, HPLCtime, HPLCedc, HPLCanhydride, HPLCprecursor, Sol, CAC, k0, k1, k2, k3, k4] = data_loader_glu(Fuel,Acid,fluxEDC2)
   
    HPLCtime = 0;
    HPLCedc = 0;
    HPLCanhydride = 0;
    HPLCprecursor = 0;
    TurbidityTime = 0;
    Turbidity = 0;
    
    Sol = 10;
    CAC = 25;
    
    k0 = 0.0000135;
    k1 = 0.45;               
    k2 = 0.15*k1;            
    k3 = 0.01*k1;          
    k4 = 0.0074;
    
%data loading solubility, crystallization point and rate constants
if Acid == 150 && Fuel == 0 && fluxEDC2 == 10
    HPLCtime = csvread('Data/time.dat');
    HPLCanhydride = csvread('Data/flux10.dat');
    
elseif Acid == 150 && Fuel == 0 && fluxEDC2 == 25
    HPLCtime = csvread('Data/time.dat');
    HPLCanhydride = csvread('Data/flux25.dat');
    
elseif Acid == 150 && Fuel == 0 && fluxEDC2 == 40
    HPLCtime = csvread('Data/time.dat');
    HPLCanhydride = csvread('Data/flux40.dat');
    
elseif Acid == 150 && Fuel == 80 && fluxEDC2 == 10
    HPLCtime = csvread('Data/time.dat');
    HPLCanhydride = csvread('Data/spikeflux10.dat');
    
elseif Acid == 150 && Fuel == 80 && fluxEDC2 == 25
    HPLCtime = csvread('Data/time.dat');
    HPLCanhydride = csvread('Data/spikeflux25.dat');
            
elseif Acid == 150 && Fuel == 80 && fluxEDC2 == 40
    HPLCtime = csvread('Data/time.dat');
    HPLCanhydride = csvread('Data/spikeflux40.dat');
    
elseif Acid == 150 && Fuel == 0 && fluxEDC2 == 5
    HPLCtime = csvread('Data/time.dat');
    HPLCanhydride = csvread('Data/flux5.dat');
    
elseif Acid == 150 && Fuel == 0 && fluxEDC2 == 20
    HPLCtime = csvread('Data/time.dat');
    HPLCanhydride = csvread('Data/flux20.dat');
    
elseif Acid == 150 && Fuel == 0 && fluxEDC2 == 35
    HPLCtime = csvread('Data/time.dat');
    HPLCanhydride = csvread('Data/flux35.dat');
    
elseif Acid == 150 && Fuel == 80 && fluxEDC2 == 5
    HPLCtime = csvread('Data/time.dat');
    HPLCanhydride = csvread('Data/spikeflux5.dat');
    
elseif Acid == 150 && Fuel == 80 && fluxEDC2 == 20
    HPLCtime = csvread('Data/time.dat');
    HPLCanhydride = csvread('Data/spikeflux20.dat');
    
elseif Acid == 150 && Fuel == 80 && fluxEDC2 == 35
    HPLCtime = csvread('Data/time.dat');
    HPLCanhydride = csvread('Data/spikeflux35.dat');     
    
end   

end



