function detected = detection_8PSK(r) %%ML_DETECTOR
L=1;
for i=1:length(r)
  if(angle(r(i))>=0)
    if(angle(r(i))<=pi/8)
    	detected(i)=0;   	
    elseif(angle(r(i))>pi/8 && angle(r(i))<=3*pi/8)
    	detected(i)=1;
    elseif(angle(r(i))>3*pi/8 && angle(r(i))<=5*pi/8)
    	detected(i)=2;  
    elseif(angle(r(i))>5*pi/8 && angle(r(i))<=7*pi/8)
    	detected(i)=3;
    elseif(angle(r(i))>7*pi/8 && angle(r(i))<=pi)
    	detected(i)=4;
    end
  else
    if(angle(r(i))>-pi/8)
    	detected(i)=0;
    elseif(angle(r(i))>-3*pi/8 && angle(r(i))<=-pi/8)
    	detected(i)=7;
    elseif(angle(r(i))>-5*pi/8 && angle(r(i))<=-3*pi/8)
    	detected(i)=6;
    elseif(angle(r(i))>-7*pi/8 && angle(r(i))<=-5*pi/8)
    	detected(i)=5;  
    elseif(angle(r(i))<=-7*pi/8)
    	detected(i)=4;
    end 
  end
       L=L+3;
end


