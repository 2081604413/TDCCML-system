clc;
 clear all;
 close all;
kx=100;
lattice=kx;
mu=2.79;
mu1=3.99;
x=linspace(0.01,0.999,kx);
   xt=ones(1,2000);

xc=linspace(0.1,0.99,kx);
% y=zeros(1,kx);
yc=zeros(1,kx);
pt=2000;
xx=zeros(21,kx,pt);
xxc=zeros(21,kx,500);
%e=0.38;
p=10;
q=10;
 u1=3.89;
a=1.4;
xx2(1)=0.6;
 for i=1:pt  
 xx2(i+1)=u1*(xx2(i))*(1-(xx2(i)));
 xx3(i+1)=mod(floor(xx2(i+1)*10^4),i);
 end
  xx3=xx3(2:pt+1);
 i=0;
%   k=0;
for e=0:0.05:1
    i=i+1;
     x2=meshgrid(x,xt');
    for n=1:pt-1
        for mm=1:floor(kx/2)
             for m=mm*2
            j1=m-1;
            k1=m+1;
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
s=mu*(x2(n,m)+a*sin(pi*x2(nn,m)))*(1-(x2(n,m)+a*sin(pi*x2(nn,m))));
s=mod(s,1); 
y(m)=1/(1+e)*(s) +e/(2*(1+e))*(x2(n,j1)+x2(n,k1));
          e=e*mu1*(1-e);
             end
              for m1=mm*2-1
            j1=m1+1;
            k1=m1-1;
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
  s=mu*(x2(n,m1)+a*sin(pi*x2(nn,m1)))*(1-(x2(n,m1)+a*sin(pi*x2(nn,m1))));
s=mod(s,1);  
y(m1)=1/(1+e)*(s) +e/(2*(1+e))*(x2(n+1,j1)+x2(n+1,k1));
     e=e*mu1*(1-e);
        end
        end
%         xc(:)=yc(:);
         x2(n+1,:)=y(1,:);
%           if n>1500
            xx(i,:,n)=y(:);
%               xx(i,:,n)=y(:);
%             xxc(i,:,n-1500)=xc(:);
          end
    end
% end
K=size(xx);
k1=K(1,1);
k2=K(1,2);
k3=K(1,3);
Y=zeros(k1,k2);
for n=1:k1
    for m=1:k2
       Y(n,m)=info_entropy_gaijin(xx(n,m,:),256);
%        Y(n,m)=8;
% zz=xx(n,m,:);
%         Y(n,m)=yyshang(xx(n,m,:),10);
    end
end

x=1:kx;
e=0:0.05:1;
[X,E]=meshgrid(x,e);
mesh(X,E,Y);
 axis([0 100 0 1 0 log2(256)]);
xlabel('\it i');
ylabel('\it e');
zlabel('InformationEntropy \it H');