%************************************************%
% ### Matlab code to carry out inversion of single prism
% ### Code is written only for research purpose.The codes are having 
% ### copyrights and required proper citation.
% ### Codes are witten by:
% ###         Dr. Chandra Prakash Dubey(email: p.dubey482gmail.com)
% ###         Madhusree Majhi (majhi.madhusree@gmail.com)
% ###         National Centre for Earth Science Studies,Thiruvanantapuram,Kerala.       
% ###         Indian Institute of Technology(Indian School of Mines),Dhanbad
%************************************************%

To invert the gravity data using Neural Network run Train_Single_Prism. To run this program PrismD and sigmoid function is required.PrismD calculate the gravity anomaly of the prism. sigmoid calculate the value of sigmoid function. After running this code network configuration is being saved in a mat file'invert.mat'.To run test_single_prism this mat file can be loaded at first or just run the code simultaneously without clearing the workspace.