%this function takes the depth distance and density value and gives the
%anomaly
function[B1]=Layer(x,z2,rho)
x0=[-2850:300:2850];%position of those small prism
w=300; %width of those prism (constant)
B1=0;
for i=1:length(x0)
 %  B=PrismDM(x0(i),rho,w,x,z2(i)); %depth(only when variable depth model 1)
   B=PrismDM(x0(i),rho(i),w,x,z2(i)); %depth+density variable model 2 
    B1=B1+B;
end
end