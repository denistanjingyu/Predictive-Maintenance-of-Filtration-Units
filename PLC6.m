load('PLC6.mat')
%FIT601_t_1=PLC6(1);
P6O1_t_1=PLC6(2);
%P6O2_t_1=PLC6(3);
%P6O3_t_1=PLC6(4);
LSL601_t_1=PLC6(5);
LSH601_t_1=PLC6(6);
P601*RO PERMEATE &PLC1
P602*UF BACKWASH &PLC3
P603*CIP &PLC5
If (LSH601_t_1= active) && (LIT101<H)
P6O1_t = 2
If (LIT101>=H) || (LSL601_t_1 = active) 
    P6O1_t = 1
%%------------------------------------