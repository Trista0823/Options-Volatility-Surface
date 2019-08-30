clear
warning off
data = csvread('50etf.csv',1,0); %date s shibor
data(:,3) = data(:,3)/100;
data_put = csvread('put.csv',1,0); 
%date strike p left (s shibor)

data_call = csvread('call.csv',1,0); 
%date strike c left (s shibor)

data_put(data_put(:,4)<=1,:) = [];         
%eliminate the effect of adjusting positions

data_call(data_call(:,4)<=1,:) = [];
data_put(:,4) = data_put(:,4)/365;
data_call(:,4) = data_call(:,4)/365;
for i = 1:length(data)
    date = data(i,1);
    s = data(i,2);
    shibor = data(i,3);
    for j = 1:length(data_call)
        if data_put(j,1) == date
            data_put(j,5) = s;
            data_put(j,6) = shibor;
        end
        if data_call(j,1) == date
            data_call(j,5) = s;
            data_call(j,6) = shibor; 
        end
    end
end

% calculate implied volatility of call options
x = zeros(length(data_call),2);
v_call = zeros(length(data_call),3);  %std maturity moneyness
ff=optimset('display','off');
for i = 1:length(data_call)
    S = data_call(i,5);
    r = data_call(i,6);
    K = data_call(i,2);
    T = data_call(i,4);
    c = data_call(i,3);
    x(i,:) = fsolve(@(x)BS_call(x,S,r,K,T,c),[0,1],ff);
    v_call(i,:) = [x(i,2),T,(S-K)/K];
end
call_y = v_call(:,2);
call_x = v_call(:,3);
call_z = v_call(:,1);

% calculate implied volatility of put options
v_put = zeros(length(data_put),3);  %std maturity moneyness
for i = 1:length(data_put)
    S = data_put(i,5);
    r = data_put(i,6);
    K = data_put(i,2);
    T = data_put(i,4);
    c = data_put(i,3);
    x(i,:) = fsolve(@(x)BS_put(x,S,r,K,T,c),[0,1],ff);
    v_put(i,:) = [x(i,2),T,(K-S)/K];
end
put_y = v_put(:,2);
put_x = v_put(:,3);
put_z = v_put(:,1);
