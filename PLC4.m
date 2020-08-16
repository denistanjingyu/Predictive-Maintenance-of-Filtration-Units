load('PLC4.mat')
%AIT401_t_1 = PLC4(); # no data
%AIT402_t_1 = PLC4(); # no data
FIT401_t_1 = PLC4(1);
LIT401_t_1 = PLC4(2);
UV401_t_1 = PLC4(3);
P4O1_t_1 = PLC4(4);
P4O2_t_1 = PLC4(5); 
P4O3_t_1 = PLC4(6); 
P4O4_t_1 = PLC4(7); 
LS401_t_1 = PLC4(8); 
P4_state = PLC4(9);
ROfeed_t_1 = PLC3(5);
ROfeed_limit = 30

%%----update current state------
LIT401_t = LIT401_t_1 + (FIT301_t_1 - FIT401_t_1) * 5 / AreaTank4 + PLC3 one parameters

%%---judge situation this PLC-------
if ((MV503_t_1 = 2.0) &&  (MV504_t_1 = 2.0) && (P401_t_1 = 1.0)) 
   ROfeed_t= ROfeed_t_1 +1
End if

If((ROfeed_t_1 > 0) && (ROfeed_t < ROfeed_limit))
P4O1_t = 2
FIT401_t = FIT401_t_1 + parafit * ROfeed_t
UV401_t = 1
else 
P4O1_t = 2
FIT401_t = FIT401_t_1 + parafit * ROfeed_t
UV401_t = 2 
End if
