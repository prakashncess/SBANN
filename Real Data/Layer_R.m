function[B1]=Layer_R(x,z2,rho)

x0=[10:20:14990];%Position of the prism
w=20; %width of the prism
B1=0;

for i=1:length(x0)
  B=PrismDM(x0(i),w,x,z2(i),rho(i)); %depth Varies
% B=PrismDM(x0(i),rho(i),w,x,z2); %density
% B=PrismDM(x0(i),rho(i),w,x,z2(i)); %depth+density  
  B1=B1+B;
end
end