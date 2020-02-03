clc; clear ;close all;

disp(['>>========================================<<'])
disp(['>>==========',datestr(now),'==========<<'])
disp(['>>========================================<<'])
tic



settings            = initset();
xml_eph             = xml2struct('gps_ephemeris.xml');
eph                 = eph_data(xml_eph);
[sat_pv,satclkcorr] = sat_pv_cal(eph);
[ta_1,cost_func]    = DPE(sat_pv,eph,settings);


toc