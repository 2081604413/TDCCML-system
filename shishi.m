clc;
 clear all;
 close all;
tic;
mu1=3.99;
kmu=400;
% ke=10;
mu=linspace(1,4,kmu);
% mu=linspace(0,0.5,kmu);
% e=linspace(0.1,0.99,ke);
%  e=0.8;0.1
xn=0.1;
kx=10;
lattice=kx;
x=linspace(0.00001,0.9999,kx);
% xx=zeros(kmu,kx);
xx=meshgrid(x,mu');
y=zeros(1,kx);
yd=zeros(1,kx);
z2=zeros(kmu,1000);
z3=zeros(kmu,1000);
kp=2000;
p=10;
q=10;
la=1;
%  temp=zeros(1,lattice);
%  for i=1:lattice
%       temp(i)=i/(lattice+1);
%  end
% i=1;
% k=0;
 u1=3.89;
a=1.4;
xx2(1)=0.6;
 for i=1:kmu  
 xx2(i+1)=u1*(xx2(i))*(1-(xx2(i)));
 xx3(i+1)=mod(floor(xx2(i+1)*10^6),i);
 end
  xx3=xx3(2:kmu+1);

for n=1:kmu-1
    
    for p1=1:2000
        for mm=1:floor(kx/2)
            for m=mm*2
            j1=m+1;
            k1=m-1;
             if j1==0
                j1=kx;
            end
            if k1==0
                k1=kx;
            end
            if j1==kx+1
                j1=1;
            end
            if k1==kx+1
                k1=1;
            end
     nn=n-xx3(n); 
s=mu(n)*(xx(n,m)+a*sin(pi*xx(nn,m)))*(1-(xx(n,m)+a*sin(pi*xx(nn,m))));
s=mod(s,1); 
y(m)=1/(1+xn)*(s) +xn/(2*(1+xn))*(xx(n,j1)+xx(n,k1));
 xn=xn*mu1*(1-xn);
 end
        for m=mm*2-1
            j1=m+1;
            k1=m-1;
             if j1==0
                j1=kx;
            end
            if k1==0
                k1=kx;
            end
            if j1==kx+1
                j1=1;
            end
            if k1==kx+1
                k1=1;
            end
     nn=n-xx3(n);          
 s=mu(n)*(xx(n,m)+a*sin(pi*xx(nn,m)))*(1-(xx(n,m)+a*sin(pi*xx(nn,m))));
s=mod(s,1);  
y(m)=1/(1+xn)*(s) +xn/(2*(1+xn))*(xx(n+1,j1)+xx(n+1,k1));
     xn=xn*mu1*(1-xn);
        end
           
        end
           xx(n,:)=y(1,:);
        if p1>kp-1500
            z2(n,la)=y(1);
        end
        la=la+1;
        if la>1500
            la=1;
        end
    end
end
figure(1)
plot(mu,z2,'k.');
% axis([0 4 0 1]);
% axis([0 0.5 0 1]);
xlabel('\mu');
ylabel('\it x_i(n)');
t=toc;
disp(t);