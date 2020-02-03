function obs = observables
    load 'MAT/observables.mat'
    
    val=sum(PRN');
    j=1;
    for i=1:length(val)
        if val(i)==0
            del(j)=i;
            j=j+1;
        end
    end

    Carrier_Doppler_hz(del,:)     =[];
    Carrier_phase_cycles(del,:)   =[];
    PRN(del,:)                    =[];
    Pseudorange_m(del,:)          =[];
    RX_time(del,:)                =[];
    TOW_at_current_symbol_s(del,:)=[];
    
    obs.carrier_doppler = Carrier_Doppler_hz;
    obs.carrier_phase   = Carrier_phase_cycles;
    obs.prn             = PRN;
    obs.pseudorange     = Pseudorange_m;
    obs.RX_time         = RX_time;
    obs.TOW_current     = TOW_at_current_symbol_s;
end
