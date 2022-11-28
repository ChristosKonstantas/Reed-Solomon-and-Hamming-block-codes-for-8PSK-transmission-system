function oct = bits2octal(b)

j=0;
for i=1:3:length(b)
    j=j+1;
    if(b(i)==0 && b(i+1)==0 && b(i+2)==0)
        oct(j)=0;
    elseif(b(i)==0 && b(i+1)==0 && b(i+2)==1)
        oct(j)=1;
     elseif(b(i)==0 && b(i+1)==1 && b(i+2)==0)
        oct(j)=2;   
     elseif(b(i)==0 && b(i+1)==1 && b(i+2)==1)
        oct(j)=3;    
     elseif(b(i)==1 && b(i+1)==0 && b(i+2)==0)
        oct(j)=4; 
     elseif(b(i)==1 && b(i+1)==0 && b(i+2)==1)
        oct(j)=5;
     elseif(b(i)==1 && b(i+1)==1 && b(i+2)==0)
        oct(j)=6;
     elseif(b(i)==1 && b(i+1)==1 && b(i+2)==1)
        oct(j)=7;  
    end
end


end

