load('PLC1.mat')
PLC3_t_1 = PLC3(1);
MV301_t_1 = PLC3(2);
MV302_t_1 = PLC3(3);
MV303_t_1 = PLC3(4);
MV304_t_1 = PLC3(5);
P301_t_1 = PLC3(6);
P602_t_1 = PLC3(7);
LIT301_t_1 = PLC3(8);
FIT301_t_1 = PLC3(9);
DPIT201_t_1 = PLC3(10);
refill_t_1 = PLC3(11);
filtr_t_1 = PLC3(12);
backwash_t_1 = PLC3(13);
drain_t_1 = PLC3(14);

refill_limit = 30
filtr_limit = 30
backwash_limit = 30
drain_limit = 30

%%----update current state------
LIT301_t = LIT101_t_1 + (FIT201_t_1 - FIT301_t_1) * 5 / AreaTank1;

%%---judge situation this PLC-------
if ((MV304_t_1 = 2.0) && (P301_t_1 = 2.0) && (MV302_t_1 = 1.0) ) %% refilling phase
    refill_t = refill_t_1 + 1
end if
 if ((MV304_t_1 = 2.0) && (P301_t_1 = 2.0) && (MV302_t_1 = 2.0) ) %% filtration phase
    filtr_t=filtr_t_1+1   
 end if
 if ((MV301_t_1 = 2.0) && (MV303_t_1 = 2.0) && (P602_t_1 = 2.0) ) %% filtration phase
    backwash_t=backwash_t_1+1   
 end if 
  if ((MV301_t_1 = 1.0) && (MV303_t_1 = 2.0) && (P602_t_1 = 1.0) ) %% filtration phase
    drain_t = drain_t_1 + 1   
 end if 
     
     
 %%%---filtration---------------------   
     
  if ((refill_t < refill_limit) && (refill_t_1 > 0.0))
      MV304_t = 2.0
      P301_t = 2.0
      P602_t = 1.0
      MV302_t = 1.0
      FIT301_t = FIT301_t_1
      DPIT_t=%%relationship defines
      MV301_t = 1.0
      MV303_t = 1.0
  else if ((refill_t = refill_limit) && (refill_t_1 > 0.0))
          refill_t = 0.0
          MV304_t = 1.0
          MV302_t = 2.0
          filtr_t = 1.0
          P301_t = 2.0         
          P602_t = 1.0
          MV301_t = 1.0
          MV303_t = 1.0
          filtr_t = 1.0
          DPIT_t = %%relationship defines
      else
      end if
      end if
    %%%---filtration---------------------         
          
          if ((filtr_t < filtr_limit) && (filtr_t_1 > 0.0)
              MV302_t = 2.0
              MV304_t = 1.0
              P301_t = 2.0            
              P602_t = 1.0
              MV301_t = 1.0
              MV303_t = 1.0
              DPIT_t=%%relationship defines
             else if ((filtr_t = filtr_limit) && (filtr_t_1 > 0.0)) 
                     filtr_t = 0.0
                     P301_t = 1.0
                     MV302_t = 1.0
                     MV301_t = 2.0
                     MV303_t = 2.0
                     MV304_t = 1.0                   
                     P602_t = 1.0
                     DPIT_t = %%relationship defines
                     backwash_t = 1.0
                 else 
                 end if
                 end if
    %%%---backwash---------------------   
             if ((backwash_t < backwash_limit) && (backwash_t_1 > 0.0)
              MV302_t = 1.0
              MV304_t = 1.0
              P301_t = 1.0
              MV301_t = 2.0
              MV303_t = 2.0
              DPIT_t = %%relationship defines
              P602_t = 2.0
             else if ((backwash_t = backwash_limit) && (backwash_t_1 > 0.0)) 
                     backwash_t = 0.0
              MV302_t = 1.0
              MV304_t = 2.0
              P301_t = 1.0
              MV301_t = 1.0
              MV303_t = 2.0
              DPIT_t = %%relationship defines
              P602_t = 1.0
              drain_t = 1.0
                 else 
                 end if
                 end if         
                     
%%%---drain stage---------------------              
             if ((drain_t < drain_limit) && (drain_t_1 > 0.0)
              MV302_t = 1.0
              MV304_t = 2.0
              P301_t = 1.0
              MV301_t = 1.0
              MV303_t = 2.0
              DPIT_t = %%relationship defines
              P602_t = 1.0
              drain_t = 1.0
             else if ((drain_t = drain_limit) && (drain_t_1 > 0.0)) 
                     drain_t = 0.0
              MV302_t = 2.0
              MV304_t = 1.0
              P301_t = 2.0            
              P602_t = 1.0
              MV301_t = 1.0
              MV303_t = 1.0
              DPIT_t = %%relationship defines
              filtr_t = 1.0
                 else 
                 end if
                 end if        
%%------------------------------------
