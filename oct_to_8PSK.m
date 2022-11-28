function s = oct_to_8PSK(b_oct)
for i=1:length(b_oct) 
    if b_oct(i)==0
        s(i)=cos(2*pi*0/8)+1j*sin(2*pi*0/8);
    elseif b_oct(i)==1
        s(i)=cos(2*pi*1/8)+1j*sin(2*pi*1/8);
    elseif b_oct(i)==2
        s(i)=cos(2*pi*2/8)+1j*sin(2*pi*2/8);
    elseif b_oct(i)==3
        s(i)=cos(2*pi*3/8)+1j*sin(2*pi*3/8);
    elseif b_oct(i)==4
        s(i)=cos(2*pi*4/8)+1j*sin(2*pi*4/8);
    elseif b_oct(i)==5
        s(i)=cos(2*pi*5/8)+1j*sin(2*pi*5/8);
    elseif b_oct(i)==6
        s(i)=cos(2*pi*6/8)+1j*sin(2*pi*6/8);
    elseif b_oct(i)==7
        s(i)=cos(2*pi*7/8)+1j*sin(2*pi*7/8);
    else
        sprintf("we should not be here");
    end
end
end

