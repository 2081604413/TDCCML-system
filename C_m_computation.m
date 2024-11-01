function [C_im] = C_m_computation(signal,m,r_factor) 
X=[];C_im=[];n_im=[];max_dif=[]; 
N=length(signal); 
 
% Construction of the X??s vectors. 
for j=1:N-m+1 
X(j,:)=signal(j:j+m-1); 
end 
 
% C computation. 
for j=1:N-m+1 
aux1=repmat(X(j,:),N-m+1,1); 
dif_aux=abs(X-aux1); 
n_im=0; 
for k=1:N-m+1 
if max(abs(dif_aux(k,:)))<r_factor*std(signal) 
n_im=n_im+1; 
end 
end 
C_im=[C_im; n_im/(N-m+1)]; 
end