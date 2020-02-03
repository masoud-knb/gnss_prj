function PVT=user_pvt()
    load pvt.mat
    
    PVT.cov.cov_xx = cov_xx;
    PVT.cov.cov_xy = cov_xy;
    PVT.cov.cov_yy = cov_yy;
    PVT.cov.cov_yz = cov_yz;
    PVT.cov.cov_zx = cov_zx;
    PVT.cov.cov_zz = cov_zz;
    
    PVT.dop.gdop   = gdop;
    PVT.dop.hdop   = hdop;
    PVT.dop.pdop   = pdop;
    PVT.dop.vdop   = vdop;
    
    PVT.gcs.height    = height;
    PVT.gcs.longitude = longitude;
    PVT.gcs.latitude  = latitude;
     
    PVT.RX_time     = RX_time;
    PVT.TOW         = TOW_at_current_symbol_ms;
    PVT.usr_clk_off = user_clk_offset;
    PVT.sat_count   = valid_sats(1);
    
    PVT.usr_pos(1,:)  = pos_x; 
    PVT.usr_pos(2,:)  = pos_y;
    PVT.usr_pos(3,:)  = pos_z;
    
    PVT.usr_vel(1,:)  = vel_x;
    PVT.usr_vel(2,:)  = vel_y;
    PVT.usr_vel(3,:)  = vel_z;
    
    
end