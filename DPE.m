 function   [ta_1,cost_func] = DPE(sat_pv,eph,settings)
    
    OBS = observables();
    PVT = user_pvt();
    
    %Make C/A Code Table
    prn=eph.prn;
    Ca_table = makeCaTable(settings);
    Ca_code_Acq=zeros(length(prn),length(Ca_table));
    for i=1:length(prn)
        Ca_code_Acq(i,:)  = Ca_table(prn(i),:);
    end
    
    sample_cnt=ceil(settings.samplingFreq ...
                      /settings.codeFreqBasis*settings.codeLength);
                  
    %Reading RAW DATA - Skip Number should multiply to 2.
    v = read_raw_binary(settings.filename, sample_cnt,settings.skipsample);

   
    n=0:3999;
    
    doppler = OBS.carrier_doppler(:,2753);
 
    X_Cnt=1;
    
    
    POSChange=-1000:50:1000;
    cost_func=zeros(length(POSChange));
    while X_Cnt < length(POSChange)
        x_change   = PVT.usr_pos(1,142)+POSChange(X_Cnt);
        Y_Cnt = 1;
        while Y_Cnt < length(POSChange)
            
            y_change = PVT.usr_pos(2,142)+POSChange(Y_Cnt); 
            usr_pos  =[x_change,y_change,PVT.usr_pos(3,142)];
            Ga       = zeros(PVT.sat_count,sample_cnt);

            ta_1=zeros(1,length(PVT.sat_count));
                        
            for SatCount=1:PVT.sat_count 
                norm_1           = norm(sat_pv(2:4,SatCount)'-usr_pos);
                ta_1(SatCount)   = (1/settings.c)*(norm_1)+PVT.usr_clk_off(1);
                ta_1(SatCount)   = floor((ta_1(SatCount)*1000 ...
                                        -floor(ta_1(SatCount)*1000))*4000);
                       
                expo(SatCount,:) = exp(1i*2*pi*doppler(SatCount) ...
                                      .*n*(1/settings.samplingFreq)+OBS.carrier_phase(SatCount));
                temp_a           = circshift(Ca_code_Acq(SatCount,:)...
                                        ,ta_1(SatCount)).*expo(SatCount,:);
                Ga(SatCount,:)   = temp_a;
            end
            
            Ga = Ga';
            cost_func(X_Cnt,Y_Cnt) = abs((conj(v)')*Ga*...
                                    ((conj(Ga)'*Ga)^-1)*(conj(Ga)')*v);
                                
            if isnan(cost_func(X_Cnt,Y_Cnt))
                break
            end
            
            Y_Cnt=Y_Cnt+1;
        end
        
        X_Cnt=X_Cnt+1;
    end
%     plot(cost_func(:,1))
    surf(POSChange,POSChange,cost_func),xlabel('X-vector Position Change'),
                 ylabel('y-vector Position Change'),zlabel('Cost Function')
    shading interp
 end