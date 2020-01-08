%% preParing Of Ephemerids Data============================================
function eph=eph_data(input)
    count = str2double(input.boostu_serialization{1,2}.GNSSu_dashu_SDRu_ephemerisu_map.count.Text);
%     temp = input.boostu_serialization{1,2}.GNSSu_dashu_SDRu_ephemerisu_map.item;  
%     for i=1:count
%         eph.prn(i,1)    =str2double(); 
%         eph.c_rs(i,1)   =str2double();
%         eph.delta_n(i,1)=str2double();
%         eph.M_0(i,1)    =str2double();
%         eph.c_us(i,1)   =str2double();
%         eph.c_uc(i,1)   =str2double();
%         eph.eps(i,1)    =str2double();
%         eph.A_sqrt(i,1) =str2double();
%         eph.t_oe(i,1)   =str2double();
%         eph.c_ic(i,1)   =str2double();
%         eph.w_0(i,1)    =str2double();
%         eph.c_is(i,1)   =str2double();
%         eph.i_0(i,1)    =str2double();
%         eph.c_rc(i,1)   =str2double();
%         eph.w(i,1)      =str2double();
%         eph.w_dot(i,1)  =str2double();
%         eph.IDOT(i,1)   =str2double();       
%     end
end



