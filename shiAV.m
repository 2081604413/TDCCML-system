clc;
 clear all;
 close all;
kx=100;
lattice=kx;
mu1=3.89;
ii=1;
pt=2000;
u1=3.89;
a=1.8;
muu=linspace(0,4,100);
xx2(1)=0.6;
 for i=1:pt  
 xx2(i+1)=u1*(xx2(i))*(1-(xx2(i)));
 xx3(i+1)=mod(floor(xx2(i+1)*10^4),i);
 end
  xx3=xx3(2:pt+1);
for mu=muu
    jj=1;
    for e=0:0.05:1
        x=linspace(0.1,0.99,kx);
         xt=ones(1,2000);
        x2=meshgrid(x,xt');
        y=zeros(1,kx);
        pt=2000;
        xx=zeros(kx,500);
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
%             if n>1000
                xx(:,n)=y(:);
%             end
        end
        total=0;
        for m=1:kx
            total=total+info_entropy_gaijin(xx(m,:),256);
        end
        Z(ii,jj)=total/kx;
        jj=jj+1; 
    end
    ii=ii+1;
end
% mu=3.6:0.01:4;
e=0:0.05:1;
[xx,yy]=meshgrid(e,muu);
mesh(xx,yy,Z);
xlabel('\it e');
ylabel('\it u');
zlabel('InformationEntropy \it Hd');
% axis([0 1 3.6 4 0 3.32]);
total=0;
for n=21:41
    for m=1:51
        if m>7&&m<11
        else
            total=total+Z(n,m);
        end
    end
end
disp(total/(21*48));