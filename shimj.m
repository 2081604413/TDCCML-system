clc;
 clear all;
 close all;
kx=100;
lattice=kx;
mu1=1.99;
mu=3.88;
e=0.64;
pt=2000;
x=linspace(0.1,0.99,kx);
xc=linspace(0.1,0.99,kx); 
 xt=ones(1,pt);
x2=meshgrid(x,xt');
y=zeros(1,kx);
yc=zeros(1,kx);

xx=zeros(kx,500);
xxc=zeros(kx,500);
  temp=zeros(1,lattice);
  for i=1:lattice
      temp(i)=i/(lattice+1);
  end
xn=0.2341414134;
a=1.8;
u1=3.89;
xx2(1)=0.6;
 for i=1:pt  
 xx2(i+1)=u1*(xx2(i))*(1-(xx2(i)));
 xx3(i+1)=mod(floor(xx2(i+1)*10^4),i);
 end
xx3=xx3(2:pt+1);
xn=0.2341414134;
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
           x2(n+1,:)=y(1,:);
             if n>100
                xx(:,n)=y(:);
             end
 end
mutualinfo=zeros(kx,kx);
for n=1:kx
    for m=1:kx
        if n==m
%             mutualinfo(n,m)=0;
        else
            mutualinfo(n,m)=calc_mi(xx(n,:)',xx(m,:)',2);
        end
    end
end
kxx=1:kx;
kxy=1:kx;
[X,Y]=meshgrid(kxx,kxy);
figure(1)
mesh(X,Y,mutualinfo);
%  text(X(50,60),Y(50,60),mutualinfo(50,60),['(' num2str(X(50,60)) ',' num2str(Y(50,60)) ',' num2str(mutualinfo(50,60))  ')'],'color','r','FontSize',13)

axis([0 kx 0 kx 0 1]);
xlabel('i');
ylabel('j');
zlabel('Mutual Information I');
hold on
h6=plot3(50,60,0.008534672044270,'.','color','r','MarkerSize',20);
  legend([h6],['(' num2str(X(50,50)) ',' num2str(Y(60,60)) ',' num2str(mutualinfo(50,60)) ')'])
% text(50,60,0.008534672044270,['  X=',num2str(50,50),char(10),'  Y=',num2str(60,60),char(10),'  mutualinfo=',num2str(mutualinfo(50,60)]); 
% figure(2)
% mesh(X,Y,mutualinfoc);
% axis([0 kx 0 kx 0 1]);
% xlabel('i');
% ylabel('j');
% zlabel('Mutual Information I');