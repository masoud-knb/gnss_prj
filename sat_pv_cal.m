%% temp
% clc;clear;close all;
% load eph
% 
% eph.A_sqrt(1) =5153.79589081;
% eph.t_oe(1)   =93600.0;
% eph.M_0(1)    =1.05827953357;
% eph.e(1)      =0.00223578442819;
% eph.delta_n(1)=0.4653376527657e-8;
% eph.w(1)      =2.06374037770;
% eph.c_us(1)   =0.177137553692e-05; 
% eph.c_uc(1)   =0.457651913166e-05;
% eph.c_rs(1)   =88.6875000000;
% eph.c_rc(1)   =344.968750000;
% eph.c_is(1)   =-0.856816768646e-07;
% eph.c_ic(1)   =0.651925802231e-07;
% eph.IDOT(1)   =0.342514267094e-09;
% eph.i_0(1)    =0.961685061380;
% eph.w_0(1)    =1.64046615454; 
% eph.w_dot(1)  =-0.856928551657e-08; 
% time = 86400;

function [sat_pv]=sat_pv_cal(eph)
    % Constant Values
    meu    =3.986005e14;  %m^3/s^2 - WGS 84 value of the earth's gravitational constant for GPS user
    omega_e=7.29211551467e-5;      %rad/s
    gpspi  =3.14159265359;
    F      =-4.442807633e-10;      %sec/sqrt(m)
    
    count     =eph.count(1);
    dt        =zeros(1,count); 
    satclkcorr=zeros(1,count);
    time      =zeros(1,count);
    satpos_val=zeros(7,count);
    
    
    
    for i=1:count
        transmitTime = eph.TOW(i);
        dt(i)        = time_check(transmitTime - eph.t_oc(i));
        satclkcorr(i)=((eph.a_f2(i))*dt(i)+eph.a_f1(i))*dt(i) ...
                       +eph.a_f0(i)-eph.TGD(i);
        time      =transmitTime - satclkcorr(i);
        A            =(eph.A_sqrt(i))^2;
        n_0          =sqrt(meu/(A^3));
        t_k          =time-eph.t_oe(i);
        n            =n_0+eph.delta_n(i);
        m_k          =eph.M_0(i)+n*t_k;
        mk_dot       =n;
        e_k          =m_k;
        for iter=0:6
            e_k=m_k+eph.e(i)*sin(e_k);
        end
        ek_dot       =mk_dot/(1-eph.e(i)*cos(e_k));
        nu_k         =atan2(sqrt(1-eph.e(i)^2)*sin(e_k) ...
                      ,(cos(e_k)-eph.e(i)));
        nuk_dot      =sin(e_k)*ek_dot*(1+eph.e(i)*cos(nu_k)) ...
                      /(sin(nu_k)*(1-eph.e(i)*cos(e_k)));
        phi_k        =nu_k+eph.w(i);
        corr_u       =eph.c_us(i)*sin(2*phi_k)+eph.c_uc(i)*cos(2*phi_k);
        corr_r       =eph.c_rs(i)*sin(2*phi_k)+eph.c_rc(i)*cos(2*phi_k);
        corr_i       =eph.c_is(i)*sin(2*phi_k)+eph.c_ic(i)*cos(2*phi_k);
        u_k          =phi_k+corr_u;
        r_k          =A*(1-eph.e(i)*cos(e_k))+corr_r;
        i_k          =eph.i_0(i)+eph.IDOT(i)*t_k+corr_i;
        uk_dot       =nuk_dot+2*(eph.c_us(i)*cos(2*u_k)-eph.c_uc(i) ...
                      *sin(2*u_k))*nuk_dot;
        rk_dot       =A*eph.e(i)*sin(e_k)*n/(1-eph.e(i)*cos(e_k))+  ...
                      2*(eph.c_rs(i)*cos(2*u_k)-eph.c_rc(i)*sin(2*u_k))...
                      *nuk_dot;
        ik_dot       =eph.IDOT(i)+(eph.c_is(i)*cos(2*u_k)-eph.c_ic(i)...
                      *sin(2*u_k))*2*nuk_dot;
        xp_k         =r_k*cos(u_k);
        yp_k         =r_k*sin(u_k);
        xpk_dot      =rk_dot*cos(u_k)-yp_k*uk_dot;
        ypk_dot      =rk_dot*sin(u_k)+xp_k*uk_dot;
        w_k          =eph.w_0(i)+(eph.w_dot(i)-omega_e)*t_k-omega_e*eph.t_oe(i);
        wk_dot       =eph.w_dot(i)-omega_e;
        
        x_k          =xp_k*cos(w_k)-yp_k*sin(w_k)*cos(i_k);
        y_k          =xp_k*sin(w_k)+yp_k*cos(w_k)*cos(i_k);
        z_k          =yp_k*sin(i_k);
               
        xk_dot       =(xpk_dot-yp_k*cos(i_k)*wk_dot)*cos(w_k)...
                      -(xp_k*wk_dot+ypk_dot*cos(i_k)-yp_k*sin(i_k)*ik_dot)...
                      *sin(w_k);
        yk_dot       =(xpk_dot-yp_k*cos(i_k)*wk_dot)*sin(w_k)...
                      +(xp_k*wk_dot+ypk_dot*cos(i_k)-yp_k*sin(i_k)*ik_dot)...
                      *cos(w_k);
        zk_dot       =ypk_dot*sin(i_k)+yp_k*cos(i_k)*ik_dot;
        
        satpos_val(:,i) =[time;x_k;y_k;z_k;xk_dot;yk_dot;zk_dot];
        
        
      
        
        
                   
    end
    
    sat_pv=satpos_val;
end   















