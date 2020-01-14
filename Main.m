clc; clear ;close all;

disp(['>>========================================<<'])
disp(['>>==========',datestr(now),'==========<<'])
disp(['>>========================================<<'])
tic

xml_eph= xml2struct('gps_ephemeris.xml');
eph    = eph_data(xml_eph);
sat_pv = sat_pv_cal(eph);






toc