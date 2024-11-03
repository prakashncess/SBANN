clc;%to clear the command window

%parameters
z2t=[900 850 950 700 869 400 658 976 793 856 722 968 953 1000 800 750 782 821 700 894]; % depth of the bottom of the prisms
xt=[-3000:50:3000];%Distance or Profile direction
rhot=[200 350 150 300 269 100 358 176 193 256 322 168 253 100 200 350 282 321 300 394];%density of the prisms
% rhot=200;
x0=[-2850:300:2850]; %position of the prisms
w1=300;%width of the prism
z1=0.01;
Bt=Layer(xt,z2t,rhot); %creating the test data (gravity anomaly)

% % without Noise

% for i=1:length(Bt)
%       B1t(i)=(Bt(i)-min(Bt))/(max(Bt)-min(Bt));% transferring the data between 0 -1
% end
%                                                                   
% alph=0.001; %learning rate
% tran_int=B1t'; %Input to the 1st layer
% sum1t=w*tran_int;% weighted sum of 1st layer
% act_funt=sigmoid(sum1t);%output of 1st layer with sigmoid activation & input to 2nd layer
% outt=v*act_funt;%output of network
% 
% %parameters after inversion
% rhott=outt(1:20,1); %Density
% % fprintf('Density of the layeris %d\n',rhott)
% z2tt=outt(21:40,1); %depth
% B2t=Layer(xt,z2t,rhott); %calculation of inverted anomaly
% E=norm(Bt-B2t)/sqrt(length(B2t))
% 
%  %plot the anomaly with the Layer
%  figure(1)
% subplot(2,1,1)
% 
% plot(xt,Bt,'-o','LineWidth',2)
% hold on
% scatter(xt,B2t,'+','LineWidth',2)
% legend('Actual anomaly','Inverted anomaly','FontSize',14)
% xlabel('Distance [m]','FontSize',18,'FontWeight','bold')
% ylabel('Gravity Anomaly [mGal]','FontSize',18,'FontWeight','bold')
% title('Anomaly Curve of the layer','[Without Noise]','FontSize',20)
% 
% 
% %Plot of layer
% for i=1:length(x0)
% %plot the prism
% cod_x=[(x0(i)-w1/2),(x0(i)+w1/2),(x0(i)+w1/2),(x0(i)-w1/2)];
% cod_y=[z1,z1,z2t(i),z2t(i)];
% subplot(2,1,2)
% plot([min(xt) max(xt)],[0 0],'k','LineWidth',2)
% grid on
% grid minor
%  xlabel('Distance [m]','FontSize',18,'FontWeight','bold')
% ylabel('Depth [m]','FontSize',18,'FontWeight','bold')
% hold on
% L2 = fill(cod_x,cod_y,[.8 .8 .8]);
% end
% set(gca,'YDir','reverse')

 

%  
 %%
%%Adding 5% Gaussian Noise
 r=.05;
 amp=Bt.*r;
 noise=amp.*randn(1,length(Bt)); %Calculation of noise
 Bt=Bt+noise; %Adding the noise with signal
 for i=1:length(Bt)
      B1t(i)=(Bt(i)-min(Bt))/(max(Bt)-min(Bt)); % transferring the data between 0 -1
 end
                                                          
alph=0.001; %learning rate

tran_int=B1t'; %Input to the 1st layer
sum1t=w*tran_int; %Input to the 1st layer
act_funt=sigmoid(sum1t); % weighted sum of 1st layer
outt=v*act_funt; %output of network

%parameters after inversion
rhott=outt(1:20,1);%Density
z2tt=outt(21:40,1);%Depth

 B2t=Layer(xt,z2tt,rhott); %calculation of inverted anomaly
 E=norm(Bt-B2t)/sqrt(length(B2t))

% plot the both anomaly with the Layer
figure(1)
subplot(2,1,1)

plot(xt,Bt,'-o','LineWidth',2)
hold on
scatter(xt,B2t,'+','LineWidth',2)
legend('Actual anomaly','Inverted anomaly','FontSize',14)
xlabel('Distance [m]','FontSize',18,'FontWeight','bold')
ylabel('Gravity Anomaly [mGal]','FontSize',18,'FontWeight','bold')
title('Anomaly Curve','[With 5% Gaussian Noise]','FontSize',20) 

%Plot of prism
for i=1:length(x0)
%plot the prism
cod_x=[(x0(i)-w1/2),(x0(i)+w1/2),(x0(i)+w1/2),(x0(i)-w1/2)];
cod_y=[z1,z1,z2t(i),z2t(i)];
subplot(2,1,2)
plot([min(xt) max(xt)],[0 0],'k','LineWidth',2)
grid on
grid minor
xlabel('Distance [m]','FontSize',18,'FontWeight','bold')
ylabel('Depth [m]','FontSize',18,'FontWeight','bold')
hold on
L2 = fill(cod_x,cod_y,[.8 .8 .8]);
end
set(gca,'YDir','reverse')

 

