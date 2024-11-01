clc;
 clear all;
 close all;
tic;    
% alpha=3.87;
% epslon=0.1;
alpha=3.99;
mu=0.3;
%3.78
digits(14);
lattice=100;
times=2000;
cs=zeros(lattice,times);
ks=cs;
cs_cml=zeros(lattice,times);

x=linspace(0.1,0.99,lattice);
         xt=ones(1,2000);
          cs=meshgrid(xt',x);
a=1.4;
u1=3.89;
xx2(1)=0.6;
pt=2000;
 for i=1:pt  
 xx2(i+1)=u1*(xx2(i))*(1-(xx2(i)));
 xx3(i+1)=mod(floor(xx2(i+1)*10^4),i);
 end
xx3=xx3(2:pt+1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%arnold %%%%%%%%%%%%%%%%%%%%%%
x=0;
y=0;
xn=0.01;
for n=1:times-1
%   xn=0.1+(10^-4)*n;%伪动态里的全动态（即每个格子之间，每次迭代之间都不同）
     %xn=0.34;%0<mu<3.56时是伪动态中的半动态（即每个个之间不同，但每次迭代之间相同），mu>3.56时是真动态里的半动态
    for i=1: floor(lattice/2)   

      for m=i*2
            j1=m-1;
            k1=m+1;
            if j1==0
                j1=lattice;
            end
            if k1==0
                k1=lattice;
            end
            if j1==lattice+1
                j1=1;
            end
            if k1==lattice+1
                k1=1;
            end
                nn=n-xx3(n);     
                s=alpha*(cs(m,n)+a*sin(pi*cs(m,nn)))*(1-(cs(m,n)+a*sin(pi*cs(m,nn))));
                s=mod(s,1); 
                cs(m,n+1)=1/(1+xn)*(s) +xn/(2*(1+xn))*(cs(j1,n)+cs(k1,n));
                xn=xn*mu*(1-xn);
              end
            for m1=i*2-1
            j1=m1+1; 
            k1=m1-1;
             if j1==0
                j1=lattice;
            end
            if k1==0
                k1=lattice;
            end
            if j1==lattice+1
                j1=1;
            end
            if k1==lattice+1
                k1=1;
            end
      nn=n-xx3(n); 
      s=alpha*(cs(m1,n)+a*sin(pi*cs(m1,nn)))*(1-(cs(m1,n)+a*sin(pi*cs(m1,nn))));
      s=mod(s,1);  
     cs(m1,n+1)=1/(1+xn)*(s)+xn/(2*(1+xn))*(cs(j1,n+1)+cs(k1,n+1));
      xn=mu*xn*(1-xn);
            end   
%    cs(i,n)=(1-xn)*alpha*cs(i,n-1)*(1-cs(i,n-1)) +(xn/4)*(alpha*cs(x,n-1)*(1-cs(x,n-1))+alpha*cs(y,n-1)*(1-cs(y,n-1))+alpha*cs(y,kk)*(1-cs(y,kk))+alpha*cs(x,kk)*(1-cs(x,kk)));
% ii=ii+1;
    if cs(i,n) >1-(1/alpha )
        ks(i,n)=i;
    else
        ks(i,n)=0;
    end
    
   end
   
end
ma=max(max(cs(:,times-200:1:times)));
mi=min(min(cs(:,times-200:1:times)));
t=toc;
disp(t);
figure(1);
 plot(1:1:lattice,cs(:,times-200:1:times),'k','MarkerSize',2);
 axis([1 lattice 0 1]);
 xlabel('\iti');
 ylabel('\itx_i(n)');
   figure(2)
 plot(200:10:times,ks(:,200:10:times),'k.','MarkerSize',2);
%  figure(3)
%  plot(1:times,cs);
%%%%%%%%%%%%%%%%%%%%%%%%%%%arnold %%%%%%%%%%%%%%%%%%%%%%

%   
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%cs cml 
%   for i=2:lattice*4
%      c(i)=alpha*c(i-1)*(1-c(i-1));
%  end
%  for i=1:lattice    
%         cs(i,1)=c(i*3);
%          cs_cml(i,1)=c(i*3);
% end
% for n=2:times
%     for i=1:lattice    
%  x=mod(((i)+p*(i)),lattice);
%     y=mod(q*(i)+(p*q+1)*(i),lattice);
%     if x==0
%     x=lattice;
%     end
%     if y==lattice+1
%         y=1;
%     end
%     if y==0
%         y=lattice;
%     end
%     if x==lattice+1
%         x=1;
%     end
% cs_cml(i,n)=(1-epslon)*alpha*cs_cml(i,n-1)*(1-cs_cml(i,n-1)) +(epslon/2)*(    alpha*cs_cml(x,n-1)*(1-cs_cml(x,n-1))   +    alpha*cs_cml(y,n-1)*(1-cs_cml(y,n-1))     );      
%         if cs_cml(i,n) > 1-(1/alpha )
%         ks(i,n)=i;
%         else
%             ks(i,n)=0;
%         end
%     end
% end
% sk=ks';
% figure(3);
%  plot(1:1:lattice,cs_cml(:,times-200:1:times),'k','MarkerSize',2);
%  axis([1 lattice 0 1]);
%   figure(4)
%  plot(200:10:times,ks(:,200:10:times),'k.','MarkerSize',2);
 %%%%%%%%%%%%%%%%%%%%%%%%%%cs cml%%%%%%%%%%%%%%5







