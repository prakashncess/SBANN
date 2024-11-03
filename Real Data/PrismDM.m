function [g]=PrismDM(x0,w,x,z2,rho)
G=6.67*10^(-11); %Gravitational constant
 
 z1=0.01; %initial top depth for calculation purpose


    t1=z1.^2+(((x-x0)+(w/2)).^2);
    t2=z2.^2+(((x-x0)+(w/2)).^2);
    t3=z1.^2+(((x-x0)-(w/2)).^2);
    t4=z2.^2+(((x-x0)-(w/2)).^2);

    f1=acot(z2./((x-x0)+w/2))-acot(z2./((x-x0)-w/2));
    f2=acot(z1./((x-x0)+w/2))-acot(z1./((x-x0)-w/2));
    f3=((x-x0)./2).*log((t3.*t2)./(t1.*t4));
    f4=(w/4).*log((t4.*t2)./(t3.*t1));

    f=(z2.*f1)-(z1.*f2)+f3+f4;
    g=f.*2.*G.*rho.*100000;
end