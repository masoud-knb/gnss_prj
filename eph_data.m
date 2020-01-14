%% preParing Of Ephemerids Data============================================
function eph=eph_data(input)
    gpspi  =3.14159265359;
    count = str2double(input.boostu_serialization{1,2}. ...
                           GNSSu_dashu_SDRu_ephemerisu_map.count.Text);
    temp = input.boostu_serialization{1,2}. ...
                           GNSSu_dashu_SDRu_ephemerisu_map.item;  
                       
    for i=1:count
        eph.count(1,i)  =count;
        eph.prn(1,i)    =str2double(temp{1,i}.second.iu_satelliteu_PRN.Text); 
        eph.c_rs(1,i)   =str2double(temp{1,i}.second.du_Crs.Text);
        eph.delta_n(1,i)=str2double(temp{1,i}.second.du_Deltau_n.Text)*gpspi/180;
        eph.M_0(1,i)    =str2double(temp{1,i}.second.du_Mu_0.Text)*gpspi/180;
        eph.c_us(1,i)   =str2double(temp{1,i}.second.du_Cus.Text);
        eph.c_uc(1,i)   =str2double(temp{1,i}.second.du_Cuc.Text);
        eph.eps(1,i)    =str2double(temp{1,i}.second.du_eu_eccentricity.Text);
        eph.A_sqrt(1,i) =str2double(temp{1,i}.second.du_sqrtu_A.Text);
        eph.t_oe(1,i)   =str2double(temp{1,i}.second.du_Toe.Text);
        eph.c_ic(1,i)   =str2double(temp{1,i}.second.du_Cic.Text);
        eph.w_0(1,i)    =str2double(temp{1,i}.second.du_OMEGA0.Text)*gpspi/180;
        eph.c_is(1,i)   =str2double(temp{1,i}.second.du_Cis.Text);
        eph.i_0(1,i)    =str2double(temp{1,i}.second.du_iu_0.Text)*gpspi/180;
        eph.c_rc(1,i)   =str2double(temp{1,i}.second.du_Crc.Text);
        eph.w(1,i)      =str2double(temp{1,i}.second.du_OMEGA.Text)*gpspi/180;
        eph.w_dot(1,i)  =str2double(temp{1,i}.second.du_OMEGAu_DOT.Text)*gpspi/180;
        eph.IDOT(1,i)   =str2double(temp{1,i}.second.du_IDOT.Text)*gpspi/180;
        eph.TOW(1,i)    =str2double(temp{1,i}.second.du_TOW.Text);
        eph.t_oc(1,i)   =str2double(temp{1,i}.second.du_Toc.Text);
        eph.a_f2(1,i)   =str2double(temp{1,i}.second.du_Au_f2.Text);
        eph.a_f1(1,i)   =str2double(temp{1,i}.second.du_Au_f1.Text);
        eph.a_f0(1,i)   =str2double(temp{1,i}.second.du_Au_f0.Text);
        eph.TGD(1,i)    =str2double(temp{1,i}.second.du_TGD.Text);
        eph.e(1,i)      =str2double(temp{1,i}.second.du_eu_eccentricity.Text);
    end
end



