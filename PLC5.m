load('PLC5.mat')

P5_state = PLC5(1)

vsd_min_speed = 10 % these values are preset in the PLC code itself
HMI_HPP_Q_SET_M3H = 0.6

%%----update current state------
if p5_state = 1:    % Standby state
  p5_permissive = 1 % to let the plant start
  plant = 1         % plant starts           
  P5_state = 3      % go to 3rd state
end if

if p5_state = 2:  % checks RO feed pump status
  if RO_feed = 1: % 1 means running, 0 means not running 
    p5_state = 3
  end if
end if

if p5_state = 3:  % opens MV503 & MV504
  if MV503 = 2 && MV504 = 2 && RO_feed = 1: % for MVxxx, 2 means open, 1 means closed, 0 means it's in the process
                                              % for RO_feed, 1 means pump is running, 0 means it's  closed
    p5_state = 4
  end if
end if 

if p5_state = 4:  % low pressure flushing
  flushing_minute = flushing_minute + 1       
  if flusing_minute > flushing_minute_sp:     
    p5_state = 5
  end if
end if

if p5_state = 5:  % starts high pressure pump (HPP), either P501 or P502
  if P501_speed > pump_auto_speed | P502_speed > pump_auto_speed : % pump speed has to be more than its automated speet / default speed
    p5_state = 6
  end if
end if

if p5_state = 6:  % maintain at least 10% of FIT501 flow. ramps 4.5 per second of final flow until desired flow is reached
  if pump_auto_speed < vsd_high_speed :
    if PIT502 < PIT503 && PIT501<275 :
      pump_auto_speed = pump_auto_speed + 0.5
    end if
    if FIT501 > HMI_HPP_Q_SET_M3H && PIT502<PIT503 && PIT501.>260 : % HMI_HPP_Q_SET_M3H is preset to be 0.6 (see above)
      p5_state = 7
    end if
  end if
end if

if p5_state = 7 : % checks if conductivity > conductivity setpoint
  if AIT504 < AIT504_SAH :  % which one is the conductivity setpoint, AIT504 or AIT504.SAH
    p5_state = 8
  end if
end if

% for MVxxx, 1 means closed, 2 means open, 0 means in-between

if p5_state = 8 : % opens MV501
  if MV501 = 2 :
    p5_state = 9
  end if
end if

if p5_state = 9 : % closes MV503
  if MV503 = 1
    p5_state = 10
  end if
end if

if p5_state = 10 : % opens MV502
  if MV502 = 2
    p5_state = 11
  end if
end if

if p5_state = 11 : % closes MV504
  if MV504 = 1
    p5_state = 12
  end if
end if

if p5_state = 12 :  % RO permeate production
  if plant = 0 :    % if plant stops
    p5_state = 13
  end if
end if
  
if p5_state = 13:   % ramp down / decrease VSD ; 
  if P501_speed > vsd_min_speed : % vsd_mean_speed = 10, preset
    pump_auto_speed = pump_auto_speed + 0.5
  end if
  if P501_speed < vsd_min_speed :
    p5_state = 14
  end if
end if

if p5_state = 14 : % stops high-pressure pump
  if RO_high = 0  : % 0 means not running, 1 means running
    p5_state = 15
  end if
end if

if p5_state = 15 :  % opens MV504  (automatic when it reaches timeout of 120 seconds)
  MV504_timeout = MV504_timeout + 1
  if MV504 = 2 | MV504_timeout >120  
    p5_state = 16
  end if
end if

if p5_state = 16 :  % opens MV502  (automatic when it reaches timeout of 120 seconds)
  MV502_timeout = MV502_timeout + 1
  if MV502 = 1 | MV502_timeout >120 :
    p5_state = 17
  end if
end if

if p5_state = 17 :  % opens MV503 (automatic when it reaches timeout of 120 seconds)
  MV503_timeout = MV503_timeout + 1
  if MV503 = 2 | MV503_timeout >120 :
    p5_state = 18
  end if
end if

if p5_state = 18 :  % opens MV501 (automatic when it reaches timeout of 120 seconds)
  MV501_timeout = MV501_timeout + 1
  if MV501 = 2 | MV501_timeout > 120 :
    p5_state = 19
  end if
end if

if p5_state = 19 :  % keeps RO feed pumping
  RO_flushing_minute = RO_flushing_minute + 1
  if RO_flushing_minute = RO_flushing_minute_sp : % WHAT IS flushing_minute_sp
    p5_state = 20
  end if
end if

if p5_state = 20 :  % shuts down RO feed pump
  if RO_feed = 0 :
    p5_state = 21
  end if
end if

if p5_state = 21 :  % closes MV503 and MV504
  MV503_timeout = MV503_timeout + 1
  MV504_timeout = MV504_timeout + 1
  if (MV503 = 1 && MV504 = 1) | (MV503_timeout > 120 && MV504_timeout > 120) :
    p5_state = 1
  end if
end if
