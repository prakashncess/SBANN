%************************************************%
% ### Matlab code to carry out inversion of single prism
% ### single prism Inversion PrismD,sigmoid, test_single_prism need to complete the process
% ### Code is written only for research purpose.The codes are having 
% ### copyrights and required proper citation.
% ### Codes are witten by:
% ###         Dr. Chandra Prakash Dubey(email: p.dubey482gmail.com)
% ###         Madhusree Majhi (majhi.madhusree@gmail.com)
% ###         National Centre for Earth Science Studies,Thiruvanantapuram,Kerala.       
% ###         Indian Institute of Technology(Indian School of Mines),Dhanbad
%************************************************%

clc;  %clear the command window
clear all  %clear the workspace


% Network specification
% 121 input nodes, 30 hidden nodes, 4 output nodes, 2 layer of weights
N=2;
N1=121;
N2=30;
N3=5;

w=rand(N2,N1);  %Input to hid layer weight
v=rand(N3,N2);  %output to hid layer weight


%Prism properties for initial forward model
w1=750;  %width of the prism
x0=-50;  %position of the prism
rho=150; %density of the prism
x=[-3000:50:3000]; %x profile 
z1=850;   %depth of the top the prism
z2=2050;  %depth of the bottom of the prism

%loop for calculate the test data
for j=1:6  %6 set of training data
B=PrismD(x0,rho,w1,x,z1,z2);  %Calculation of the gravity anomaly by calling the function PrismD
        for i=1:length(B)
           B1(i)=(B(i)-min(B))/(max(B)-min(B)); % Transformed the gravity values between 0-1
        end
        
cor_out=[200;0;800;900;2100];  %correct output to the network for supervised learning, model parameters
                           %density=200
                           %position=0
                           %depth of the top of the prism=900
                           %width=800
                           %depth of the bottom of the prism
alph=0.001;   %learning rate
  
for i=1:100  %train 1 dataset for 100 time (iteration)
    tran_in=B1';  %Input to the 1st layer
    sum1=w*tran_in;  % weighted sum of 1st layer
    act_fun=sigmoid(sum1); %output of 1st layer with sigmoid activation & input to 2nd layer
    out=v*act_fun;   %output of network 
    
    d=cor_out; %correct output
    err=d-out; %error at output node
    err2=err.^2; % square of the error
    m1=alph.*err*act_fun';
    v=v+m1; %weight adjustment of 2nd layer
    p1=v'*(alph.*err);
    w=w+p1'*act_fun.*((1-act_fun)*tran_in');%weight adjustment of 1st layer
    e11(j,i)=sum(err2);%summed error
    

end

    x01=out(2);
    rho1=out(1);
    w11=out(3);
    z11=out(4);
    z22=out(5);
    B2=PrismD(x01,rho1,w1,x,z1,z2); %calculation of anomaly after inversion
    E=norm(B-B2)/sqrt(length(B2)); %error in the anomaly after inversion


    
 % Increment in the parameters to create more test data   
     w1=w1+25;
     x0=x0+25;
     rho=rho+25;
     z1=z1+25;
     z2=z2+25;
end
e1=((e11)./100).^0.5; %calculation the root mean square error 
ip=[1:1:600]; %600 times the weights change
ep=[e1(1,:) e1(2,:) e1(3,:) e1(4,:) e1(5,:) e1(6,:)];% sorting the error values
figure(1)
plot(ip,ep,'LineWidth',2)
xlabel('Iteration','FontSize',18,'FontWeight','bold')
ylabel('Root Mean Square Error','FontSize',18,'FontWeight','bold')
title('Root Mean Square Error vs Iteration curve','color','black','FontSize',20)


save ('invert.mat')  %save this in mat file
 %Test this test_invert