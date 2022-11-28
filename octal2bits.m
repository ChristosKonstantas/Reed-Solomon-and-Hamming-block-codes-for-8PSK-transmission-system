function b = octal2bits(oct)
k=1;
for i=1:length(oct)
    if(oct(i)==0)
        b(k)=0;b(k+1)=0;b(k+2)=0;
    elseif(oct(i)==1)
        b(k)=0;b(k+1)=0;b(k+2)=1;
    elseif(oct(i)==2)
        b(k)=0;b(k+1)=1;b(k+2)=0;
    elseif(oct(i)==3)
        b(k)=0;b(k+1)=1;b(k+2)=1;
    elseif(oct(i)==4)
        b(k)=1;b(k+1)=0;b(k+2)=0;
    elseif(oct(i)==5)
        b(k)=1;b(k+1)=0;b(k+2)=1;
    elseif(oct(i)==6)
        b(k)=1;b(k+1)=1;b(k+2)=0;
    elseif(oct(i)==7)
        b(k)=1;b(k+1)=1;b(k+2)=1;
    else
        sprintf("No way");
    end
    k=k+3;
end
end

