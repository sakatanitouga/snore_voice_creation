%sin波の生成
%音声が終わる時間
End_Ts = 10;

%いびきの基本周波数
basic_frequency = 100;

%いびきの最大周波数
max_frequency = 200;

Ts = 1/44100;
t = 0:Ts:End_Ts-Ts; 
%基本周波数の波形
x1 = sin(2*pi*basic_frequency*t);

%ピーク時の周波数の波形
x2 = sin(2*pi*200*t);

fs = 1/Ts;
x = zeros(1,fs*End_Ts);
%振幅の調整
r = 0.4;
sin_amp = 0.4;
for i = 1:44100*End_Ts
      if r==0.4
          if rem(i,441*1)==0
            r=0.2;
            sin_amp = 0.4;
          end  
      else if r==0.2
          if rem(i,441*1)==0
            r=0.4;
            sin_amp = 0.2;
          end      
        end
      end  
    x(i) = sin_amp * (x1(i)+x2(i));
end   


x_result =abs(x);

%LPF

plot(t,x,'Color',[0 0 1]);
xlim([0 0.05])

hold on
plot(t,x_result,'Color',[1 0 0]);
xlim([0 0.05])
hold off
%　フーリエ変換

m = length(x); 
n = pow2(nextpow2(m));
y = fft(x,n);
f = (0:n-1)*(fs/n); % frequency vector
amp = abs(y)/44100/5;   % power spectrum      
%plot(f(1:floor(n/10)),amp(1:floor(n/10)))
%xlabel('Frequency (Hz)')
%ylabel('amp')

%音声作成
audiowrite("f3000.wav",x,fs);