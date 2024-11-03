clc;%to clear the command window
load Data2.txt  %load the data file given containg gravity anomaly values and corresponding x(position) value
load Depth.txt %load the depth we have taken for calculation
load depth_Real.txt % load the real depth

G=6.67*10^(-11); %gravitational constant

z2t=Depth(:,1); %depth taken
xt=Data2(:,1); %Distance x profile(real data)
Bt=Data2(:,2); %gravity real data
d11=depth_Real(:,1);%real depth value
for i=1:length(Bt)
      B1t(i)=(Bt(i)-min(Bt))/(max(Bt)-min(Bt));
end
                                                                  
alph=0.001;%learning rate
tran_int=B1t';%Input to the 1st layer
sum1t=w*tran_int;% weighted sum of 1st layer
act_funt=sigmoid(sum1t);%output of 1st layer with sigmoid activation & input to 2nd layer
outt=v*act_funt; %output of the network

B2t=Layer_R(xt,outt,rho); %inverted gravity value
E=norm(Bt-B2t)/sqrt(length(B2t)) %Error in the anomaly

 % Plotting of the observed Anomaly vs Inverted anomaly
figure(1)
subplot(2,1,1)
plot(xt,Bt,'-o','LineWidth',1.8)
hold on
scatter(xt,B2t,'o','LineWidth',1.8)
legend('Real Anomaly','Inverted anomaly','FontSize',18)
xlabel('Distance [m]','FontSize',18,'FontWeight','bold')
ylabel('Gravity Anomaly [mGal]','FontSize',18,'FontWeight','bold')
title('Anomaly Curve of the Basin','FontSize',20)



%  plot of layer
subplot(2,1,2)
x0=[10:20:14990];
wl=20;
z1=0.01;
z2=outt;
for j=1:length(x0) %plotting the prisms in loop
 cod_x=[(x0(j)-wl/2),(x0(j)+wl/2),(x0(j)+wl/2),(x0(j)-wl/2)];
cod_y=[z1,z1,z2(j),z2(j)];
plot([min(x) max(x)],[0 0],'k','LineWidth',2)
xlabel('Distance [m]','FontSize',18,'FontWeight','bold')
ylabel('Depth [m]','FontSize',18,'FontWeight','bold')
hold on
L2 = fill(cod_x,cod_y,[.8 .8 .8]);
end
set(gca,'YDir','reverse')
b=plot(x0,outt,'r','LineWidth',2)
b_1=plot(xt,d11,'b','LineWidth',2)
legend([b,b_1],{'Calculated depth','Real depth'},'FontSize',18,'FontWeight','bold')
title('Depth Profile of the Basin','color','black','FontSize',18)
axis tight










