function [TurbidityTime, Turbidity, HPLCtime, HPLCedc, HPLCanhydride, HPLCprecursor, Sout, Ssat, k0, k1, k2, k3, k4] = data_loader_hys(Temperature)
   
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

%data loading solubility, crystallization point and rate constants
if Temperature <= 22
    Sout = 6.5;
    Ssat = 14;
    
    k1 = k1*1;
    k2 = k2*1;
    k3 = k3*1;
    
elseif Temperature > 22 && Temperature <= 26
    Sout = 7;
    Ssat = 16;
    
    k1 = k1*1.14;
    k2 = k2*1.14;
    k3 = k3*1.14;
    
elseif Temperature > 26 && Temperature <= 29
    Sout = 8.9;
    Ssat = 17.4;
    
    k1 = k1*1.2;
    k2 = k2*1.2;
    k3 = k3*1.2;
    
elseif Temperature > 29 && Temperature <= 32
    Sout = 11.2;         
    Ssat = 20;           
    
    k1 = k1*1.4;
    k2 = k2*1.4;
    k3 = k3*1.4;
    
elseif Temperature > 32
    Sout = 11.2;
    Ssat = 20;
    
    k1 = k1*1.6;
    k2 = k2*1.6;
    k3 = k3*1.6;
    
end
   
end



