function settings = initset()
   addpath MAT
   
   settings.samplingFreq  =4e+6;      
   settings.codeFreqBasis =1.023e6;   %C/A Code Freq
   settings.codeLength    =1023;      %C/A Code Length
   settings.rf            =1575.42e6;
   settings.filename      = ...
   "/home/masoud/Apps/gnss-sdr/work/data/2013_04_04_GNSS_SIGNAL_at_CTTC_SPAIN.dat";
   settings.c             =299792458; %m / s 
   settings.skipsample     =input("enter"); 
   
end