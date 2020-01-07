clc; clear ;close all;


t=datestr(now);
disp(['>>========================================<<'])
disp(['>>==========',t,'==========<<'])
disp(['>>========================================<<'])
tic

xml_eph= xml2struct('gps_ephemeris.xml');
% eph    = eph_data(xml_eph);
% sat_pv = sat_pv_cal(---)





toc