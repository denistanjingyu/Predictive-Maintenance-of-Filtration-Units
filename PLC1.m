load('PLC1.mat')
MV101_t_1=PLC1(1);
P1O1_t_1=PLC1(2);
LIT101_t_1=PLC1(3);
FIT101_t_1=PLC1(4);
FIT201_t_1=PLC1(5);
%%----update current state------
LIT101_t=LIT101_t_1+(FIT101_t_1-FIT201_t_1)*5/AreaTank1+PLC6 one parameters
if (LIT101_t>HLimit)
MV101_t=1
else 
   MV101_t=2.0
   FIT101_t=30
end if
  if (LIT101_t>HLimit)
P101_t=2.0
FIT201_t=30
else 
   P101_t=1.0
end if  
    
    
%%------------------------------------