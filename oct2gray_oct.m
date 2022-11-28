function b_oct_gray = oct2gray_oct(b_oct)
[r c]=size(b_oct);
if(r~=1)
 for i=1:r
    for j=1:c
        if(b_oct(i,j)==0)
            b_oct_gray(i,j)=0;
        elseif(b_oct(i,j)==1)
            b_oct_gray(i,j)=1;
        elseif(b_oct(i,j)==2)
            b_oct_gray(i,j)=3;
        elseif(b_oct(i,j)==3)
            b_oct_gray(i,j)=2;
        elseif(b_oct(i,j)==4)
            b_oct_gray(i,j)=7;
        elseif(b_oct(i,j)==5)
            b_oct_gray(i,j)=6;
        elseif(b_oct(i,j)==6)
            b_oct_gray(i,j)=4;
        elseif(b_oct(i,j)==7) 
            b_oct_gray(i,j)=5;
        end    
    end
 end

else
     for j=1:c
        if(b_oct(j)==0)
            b_oct_gray(j)=0;
        elseif(b_oct(j)==1)
            b_oct_gray(j)=1;
        elseif(b_oct(j)==2)
            b_oct_gray(j)=3;
        elseif(b_oct(j)==3)
            b_oct_gray(j)=2;
        elseif(b_oct(j)==4)
            b_oct_gray(j)=7;
        elseif(b_oct(j)==5)
            b_oct_gray(j)=6;
        elseif(b_oct(j)==6)
            b_oct_gray(j)=4;
        elseif(b_oct(j)==7) 
            b_oct_gray(j)=5;
        end    
    end
end
end

