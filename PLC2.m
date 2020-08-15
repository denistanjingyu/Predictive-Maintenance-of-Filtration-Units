load('PLC2.mat')

%AIT201_t_1 = ;
%AIT202_t_1 = ;
%AIT203_t_1 = ;
MV201_t_1 = 0;
P201_t_1 = 0;
P203_t_1 = 0;
P205_t_1 = 0;
P207_t_1 = 0;
%T201_t_1 = ;
%T202_t_1 = ;
%T203_t_1 = ;

%%---judge situation this PLC-------
if MV201_t_1 == 1
    P201_t_1 = 1;
    P203_t_1 = 1;
    P205_t_1 = 1;
    P207_t_1 = 1;
end
