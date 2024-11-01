function [ApEn_value,C_m,C_m_1] = ApEn(signal,m,r_factor) 
 
% Estimate the Aproximate Entropy (ApEn) of a signal. 
% m=1 or m=2 
% r between 0.1*SD and 0.25*SD, where SD is the signal standard deviation 
% N (signal length) between 75 and 5000; 
% [ApEn_value] = ApEn(signal,m,r); 
 
% Input variables: 
% signal - signal 
% m - pattern length 
% r_factor - factor of the criterion of similarity   r_factor*std(signal) 
 
% Output variables: 
% ApEn_value - ApEn calculated from the signal 
 
% Optional output variables: 
% C_m 
% C_m_1 
 
signal=signal(:)'; 
N=length(signal); 
% C computation for the "m" pattern. 
[C_m] = C_m_computation(signal,m,r_factor); 
% C computation for the "m+1" pattern. 
[C_m_1] = C_m_computation(signal,m+1,r_factor); 
 
 
% Phi??s computation. 
phi_m=mean(log(C_m)); 
phi_m_1=mean(log(C_m_1)); 
% Final ApEn computation. 
ApEn_value=[phi_m-phi_m_1]