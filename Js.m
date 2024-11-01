clc;
 clear all;
 close all;
mu=3.99;
entropy_arnold_logistic_t=0;
entropy_arnold_logistic=0;
%    times=200;
    lattice=10;
    kx=lattice;
u1=3.89;
a=1.4;
xx(1)=0.6;
times =200;
 for i=1:times  
 xx(i+1)=u1*(xx(i))*(1-(xx(i)));
 xx3(i+1)=mod(floor(xx(i+1)*10^4),i);
 end
 xx3=xx3(2:times+1);
  alpha1 = linspace(0,4,101);
   xn1= linspace(0,1,21);
for alpha=alpha1
        for  xn=xn1
            p=12;
            q=7;
            M=2;
            %%%%%%%%%%%%%%%%
            digits(14);

            cs=zeros(lattice,times);
            temp=zeros(1,lattice);
            for i=1:lattice
                temp(i)=i/(lattice+1);
            end
             c=zeros(1,lattice);
             c(1)=0.34565487923280;
             for i=1:lattice*4
%                  c(i)=alpha*c(i-1)*(1-c(i-1));
                 c(i+1)=alpha*(c(i)+a*sin(pi*c(i-xx3(i))))*(1-(c(i)+a*sin(pi*c(i-xx3(i)))));
                 c(i+1)=mod(c(i+1),1);
             end
             for i=1:lattice    
                    cs(i,1)=c(i*3);
             end
             %xn=0.434;
             for n=1:times
                 
               
                for i=1:floor(lattice/2)
                     for m=i*2
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
s=alpha*(cs(m,n)+a*sin(pi*cs(m,nn)))*(1-(cs(m,n)+a*sin(pi*cs(m,nn))));
s=mod(s,1); 
cs(m,n+1)=1/(1+xn)*(s) +xn/(2*(1+xn))*(cs(j1,n)+cs(k1,n));
xn=xn*mu*(1-xn);
                     end
        for m=i*2-1
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
s=alpha*(cs(m,n)+a*sin(pi*cs(m,nn)))*(1-(cs(m,n)+a*sin(pi*cs(m,nn))));
s=mod(s,1); 
cs(m,n+1)=1/(1+xn)*(s) +xn/(2*(1+xn))*(cs(j1,n)+cs(k1,n));
xn=xn*mu*(1-xn);
        end
                end
            end                                                                             
             lyapunov_cs=zeros(lattice,1);
             summ=0;
             summ1=0;
             
                for ii=1:lattice
                 sumt=zeros(1,times);
               for nn=1:times
                sumt(1,nn)=log(abs(alpha*((2*cs(ii,nn))/5 + (28*cs(ii,nn-xx3(nn)))/25+ 4/5)));
               end
               sumt=sumt(1,1:times);
                 lyapunov_cs(ii)=sum(sumt(:,:))/times;
                 if lyapunov_cs(ii) >0
                     summ=summ+lyapunov_cs(ii);  
                     summ1=summ1+1;
                 end
             end
              
             entropy_arnold_logistic=[entropy_arnold_logistic summ/lattice];%%
             entropy_arnold_logistic_t=[entropy_arnold_logistic_t summ1/lattice];%%
        end
end
alpha=alpha1;
e=xn1;
%e=0:0.05:1;
% figure(1)
% plot(alpha,entropy_arnold_logistic(2:end));
% hold on
% plot(alpha,entropy_arnold_logistic_t(2:end));
% xlabel('\it e=0');
[xx,yy]=meshgrid(e,alpha);
aa=reshape(entropy_arnold_logistic(2:end),21,101);
bb=reshape(entropy_arnold_logistic_t(2:end),21,101);

% total=0;
% full=0;
% for n=1:21
%     for m=81:101
%                if n==4
%                else
%                    if bb(n,m)==1
%                       total=total+1; 
%                    end
%                    full=full+aa(n,m);
%                end
%                
%     end
% end
% disp(total/(21*20));
% disp(full/(21*20));

figure(1);
mesh(xx,yy,aa');
xlabel('\it e');
ylabel('\it \mu');
zlabel('\it h');
figure(2);
mesh(xx,yy,bb');
xlabel('\it e');  
ylabel('\it \mu');
zlabel('\it hu'); 