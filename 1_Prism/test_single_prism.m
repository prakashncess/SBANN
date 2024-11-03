clc;

%parameters
w1t=800; %width of the prism
x0t=0;   %position of the prism
rhot=200; %density of the prism
z1t=900;  %depth of the top of the prism
z2t=2100; % depth of the bottom of the prism 
xt=[-3000:50:3000]; % distance or profile direction
Bt=PrismD(x0t,rhot,w1t,xt,z1t,z2t); %creating the test data (gravity anomaly)

% % without Noise
% 
for i=1:length(Bt)
      B1t(i)=(Bt(i)-min(Bt))/(max(Bt)-min(Bt)); % transferring the data between 0 -1
end
                                                                 
alph=0.001; %learning rate
tran_int=B1t';  %Input to the 1st layer
sum1t=w*tran_int; % weighted sum of 1st layer
act_funt=sigmoid(sum1t);%output of 1st layer with sigmoid activation & input to 2nd layer
outt=v*act_funt;  %output of network

%parameters after inversion
x0_t=outt(2);  %position
rho_t=outt(1); %density
w_t=outt(3);   %width
z1_t=outt(4);  %depth of the top of the prism
z2_t=outt(5);  %depth of the bottom of the prism
fprintf('The position of the prism is %d\n',x0_t)
fprintf('The density of the prism is %d\n',rho_t)
fprintf('The width of the prism is %d\n',w_t)
fprintf('The depth of the top of the prism is %d\n',z1_t)
fprintf('The depth of the bottom of the prism is %d\n',z2_t)
B2t=PrismD(x0_t,rho_t,w_t,xt,z1_t,z2_t); %calculation of inverted anomaly
Err=norm(Bt-B2t)/sqrt(length(B2t)); %error in the anomaly after inversion
fprintf('Error in the anomaly is %d\n',Err)

%plot the anomaly with the prism
figure(1)
subplot(2,1,1)
plot(xt,Bt,'LineWidth',2)
grid on
grid minor
xlabel('Distance[m]','FontSize',18,'FontWeight','bold')
ylabel('Gravity Anomaly [mGal]','FontSize',18,'FontWeight','bold')
title('Gravity Anomaly due to single rectangular prism','[Without Noise]','color','black','FontSize',20)

%plot of the prism
subplot(2,1,2)
cod_x=[(x0t-w1t/2),(x0t+w1t/2),(x0t+w1t/2),(x0t-w1t/2)];
cod_y=[z1t,z1t,z2,z2];
 plot([min(xt) max(xt)],[0 0],'k','LineWidth',2)
 set(gca,'YDir','reverse')
grid on
grid minor
xlabel('Distrance [m]','FontSize',18,'FontWeight','bold')
ylabel('Depth [m]','FontSize',18,'FontWeight','bold')
hold on
L2 = fill(cod_x,cod_y,[.5 .5 .5]);


% Plotting of the observed Anomaly vs Inverted anomaly
figure(2)
scatter(xt,Bt,'*','LineWidth',0.75)
grid on
grid minor
hold on
scatter(xt,B2t,'o','LineWidth',0.95)
legend('Actual anomaly','Inverted anomaly','FontSize',14)
xlabel('Distance [m]','FontSize',18,'FontWeight','bold')
ylabel('Gravity Anomaly [mGal]','FontSize',18,'FontWeight','bold')
title('Anomaly Curve','[Without Noise]','FontSize',20)

 %%
 %%Adding 5% Gaussian Noise
%   r=.05;
%   amp=Bt.*r;
%   noise=amp.*randn(1,length(Bt)); %Calculation of noise
%   Bt=Bt+noise; %Adding the noise with signal
%   for i=1:length(Bt)
%       B1t(i)=(Bt(i)-min(Bt))/(max(Bt)-min(Bt)); % transferring the data between 0 -1
%   end
%  
%   alph=0.001; %learning rate
%  
%   tran_int=B1t';%Input to the 1st layer
%   sum1t=w*tran_int; %Input to the 1st layer
%   act_funt=sigmoid(sum1t); % weighted sum of 1st layer
%   outt=v*act_funt;  %output of network
%  
%   %parameters after inversion
%   x0_t=outt(2)  %position
%   rho_t=outt(1) %density
%   w_t=outt(3)   %width
%   z1_t=outt(4)  %DFepth of the top of the prism
%   z2_t=outt(5);  %depth of the bottom of the prism
%   fprintf('The position of the prism is %d\n',x0_t)
%   fprintf('The density of the prism is %d\n',rho_t)
%   fprintf('The width of the prism is %d\n',w_t)
%   fprintf('The depth of the top of the prism is %d\n',z1_t)
%   fprintf('The depth of the bottom of the prism is %d\n',z2_t)
%   
%   B2t=PrismD(x0_t,rho_t,w_t,xt,z1_t,z2_t); % %calculation of inverted anomaly
%    Err=norm(Bt-B2t)/sqrt(length(B2t)); %error in the anomaly after inversion
% fprintf('Error in the anomaly is %d\n',Err)
%  
% %plot the anomaly with the prism
% figure(1)
% subplot(2,1,1)
% plot(xt,Bt,'LineWidth',2)
% grid on
% grid minor
% xlabel('Profile direction[x] in m','FontSize',16,'FontWeight','bold')
% ylabel('Gravity Anomaly in mGal','FontSize',16,'FontWeight','bold')
% title('Gravity Anomaly due to single rectangular prism','[With 5% Gaussian Noise]','color','black','FontSize',18)
% 
% %plot of the prism
% subplot(2,1,2)
% cod_x=[(x0t-w1t/2),(x0t+w1t/2),(x0t+w1t/2),(x0t-w1t/2)];
% cod_y=[z1t,z1t,z2,z2];
%  plot([min(xt) max(xt)],[0 0],'k','LineWidth',2)
%  set(gca,'YDir','reverse')
% grid on
% grid minor
% xlabel('Profile Direction','FontSize',18,'FontWeight','bold')
% ylabel('Depth [m]','FontSize',18,'FontWeight','bold')
% hold on
% L2 = fill(cod_x,cod_y,[.5 .5 .5]);
% title('Plot of the Prism','color','black','FontSize',20)
% 
% % Plotting of the observed Anomaly vs Inverted anomaly
% figure(2)
% scatter(xt,Bt,'*','LineWidth',0.75)
% grid on
% grid minor
% hold on
% plot(xt,Bt)
% scatter(xt,B2t,'o','LineWidth',0.75)
% legend('Real anomaly(point)','Real anomaly plot','Inverted anomaly','FontSize',12)
% xlabel('Profile direction[x] in m','FontSize',18,'FontWeight','bold')
% ylabel('Gravity Anomaly in mGal','FontSize',18,'FontWeight','bold')
% title('Anomaly Curve','[With 5% Gaussian Noise]','FontSize',20)
