function v = read_raw_binary (filename, count,start_sample)

m = nargchk (1,3,nargin);
if (m)
    usage (m);
end

if (nargin < 2)
    count = Inf;
    start_sample=0;
end

if (nargin < 3)
    start_sample=0;
end

f = fopen (filename, 'rb');
if (f < 0)
    v = 0;
else
    if (start_sample>0)
        bytes_per_sample=2;
        fseek(f,start_sample*bytes_per_sample,'bof');
    end
    t = fread (f, [2, count], 'short');
    fclose (f);
%    % Normaization
%     t_r_max = max(t(1,:));
%     t_r_min = min(t(1,:));
%     t_i_max = max(t(2,:));
%     t_i_min = min(t(2,:));
%     
%     a = -1; %Lower bound
%     b =  1; %Upper bound 
%     
%     t_r_n = a+(t(1,:)-t_r_min)*(b-a)/(t_r_max-t_r_min);
%     t_i_n = a+(t(2,:)-t_i_min)*(b-a)/(t_i_max-t_r_min);
    
    v = t(1,:) + t(2,:)*1i;
%     v = t_r_n + t_i_n*1i;
    [r, c] = size (v);
    v = reshape (v, c, r);
    
end
