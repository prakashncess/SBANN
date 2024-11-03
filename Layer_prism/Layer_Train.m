%************************************************%
% ### Matlab code to carry out inversion of layer made of stacked prism
% ### Inversion of a layer PrismDM,sigmoid, Layer_test need to complete the process
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
%20 small prism is taken to create a layer

% Network specification
w=rand(30,121);  %Input to hid layer weight
v=rand(40,30);  %output to hid layer weight
 %121 input nodes, 30 hidden nodes, 40 output nodes, 2 layer of weights for
 %both depth and density array otherwise 20 output node for 20 prism's
 %depth and 1 for density (constant for all prism)

%Layer properties for initial forward model 
x=[-3000:50:3000]; %distance
%For constant density comment out the density array
 b1=[200 350 150 300 269 100 358 176 193 256 322 168 253 100 200 350 282 321 300 394]';  %density of the prisms(model2)
%b1=200;(model 1)
b2=[900 850 950 700 869 400 658 976 793 856 722 968 953 1000 800 750 782 821 700 894]'; %depth of the prisms(both model 1&2)

 b11=b1-50; %trainig limit of density (model 2)
% b11=200-50; % for constant Density(model 1)
b22=b2-50; %training limit of depth(both model 1&2)

 b=[b1;b2]; %output of the network
% b=[b2;b1];%output of the network

for j=1:6  % 6 set of training data
B=Layer(x,b22,b11); %%Calculation of the gravity anomaly by calling the function Layer
        for i=1:length(B)
           B1(i)=(B(i)-min(B))/(max(B)-min(B)); % Transformed the gravity values between 0-1
        end
      
cor_out=b; %correct output to the network for supervised learning, model parameters

alph=0.001;%learning rate
for i=1:100  %train 1 dataset for 100 time (iteration)
    tran_in=B1'; %Input to the 1st layer
    sum1=w*tran_in;  % weighted sum of 1st layer
    act_fun=sigmoid(sum1); %output of 1st layer with sigmoid activation & input to 2nd layer
    out=v*act_fun; %output of network 
    
    d=cor_out;  %correct output
    err=d-out;  %error at output node
    err2=err.^2; % square of the error
    v=v+alph.*err*act_fun'; %weight adjustment of 2nd layer
    p1=v'*(alph.*err);
    w=w+p1'*act_fun.*((1-act_fun)*tran_in');%weight adjustment of 1st layer
    e11(j,i)=sum(err2);%summed error
   
end
    den=out(1:20,1); %calling density values
    z2=out(21:40,1); %calling depth values
    B2=Layer(x,z2,den);%calculation of anomaly after inversion
    
    
    % Increment in the parameters to create more test data
    b11=b11+25;
    b22=b22+25;

end
e1=((e11)./100).^0.5; %calculation the root mean square error 
ip=[1:1:600]; %600 times the weights change
ep=[e1(1,:) e1(2,:) e1(3,:) e1(4,:) e1(5,:) e1(6,:)];% sorting the error values
figure(1)
plot(ip,ep,'LineWidth',2)
xlabel('Iteration','FontSize',18,'FontWeight','bold')
ylabel('Root Mean Square Error','FontSize',18,'FontWeight','bold')
title('Root Mean Square Error vs Iteration curve','color','black','FontSize',20)

 save ('invert_den.mat')  