%************************************************%
% ### Matlab code to carry out inversion of sedimentary basin of real data value
% ### To complete this we need Layer_R,PrismDM,Test_Realdata,sigmoid.
% ### Code is written only for research purpose.The codes are having 
% ### copyrights and required proper citation.
% ### Codes are witten by:
% ###         Dr. Chandra Prakash Dubey(email: p.dubey482gmail.com)
% ###         Madhusree Majhi (majhi.madhusree@gmail.com)
% ###         National Centre for Earth Science Studies,Thiruvanantapuram,Kerala.       
% ###         Indian Institute of Technology(Indian School of Mines),Dhanbad
%************************************************%

clc;   % clear the command window
clear all %clear the workspace
% all the small prism has different depth and density is varying with depth
% invert the result for depth.


load Data2.txt  %load the data file given containg gravity anomaly values and corresponding x(position) value
load Depth.txt %load the depth (assumed) from the picture


% Network specification
w=rand(30,101);  %Input to hid layer weight
v=rand(750,30);  %output to hid layer weight
%output layer has 750 node because of 750 small prism whose depth of the
%bottom we are calculating


%Layer properties to create training data
x=Data2(:,1); %x distance(load from data file)
b2=Depth(:,1); %depth assumed
z=(b2/2)/1000; %depth of the midpoint of the prism
rho=(-0.8+0.7174.*z-0.229.*(z.^2)).*1000; %density varying with depth
b22=b2-50; %training limit of depth

b=b2; %output of the network for supervised learning



for j=1:8  % 8 set of training data
B=Layer_R(x,b22,rho); %synthetically data created to train the network upper layer

        for i=1:length(B)
           B1(i)=(B(i)-min(B))/(max(B)-min(B)); %Normalizing the data between 0-1
        end
      
cor_out=b; %correct depth value
alph=0.001; %learning rate

for i=1:100 %train 1 dataset for 100 time (iteration)
    tran_in=B1';%Input to the 1st layer
    sum1=w*tran_in;% weighted sum of 1st layer
    act_fun=sigmoid(sum1);%output of 1st layer with sigmoid activation & input to 2nd layer
    out=v*act_fun;%output of network 
    
    d=cor_out; %correct output
    err=d-out; %error at output node
    err2=err.^2; % square of the error
    v=v+alph.*err*act_fun';%weight adjustment of 2nd layer
    p1=v'*(alph.*err);
    w=w+p1'*act_fun.*((1-act_fun)*tran_in');%weight adjustment of 1st layer
    e11(j,i)=sum(err2);%summed error
    
end
   
    z2=out; %calling depth values
    B2=Layer_R(x,z2,rho);%calculation of anomaly after inversion
    
    % Increment in the parameters to create more test data
    b22=b22+15;
end
e1=((e11)./100).^0.5; %calculation the root mean square error 
ip=[1:1:800]; %800 times the weights change
ep=[e1(1,:) e1(2,:) e1(3,:) e1(4,:) e1(5,:) e1(6,:) e1(7,:) e1(8,:)];% sorting the error values
figure(1)
plot(ip,ep,'LineWidth',2)
xlabel('Iteration','FontSize',18,'FontWeight','bold')
ylabel('Root Mean Square Error','FontSize',18,'FontWeight','bold')
title('Root Mean Square Error vs Iteration curve','color','black','FontSize',20)
save ('invert_den.mat')  


