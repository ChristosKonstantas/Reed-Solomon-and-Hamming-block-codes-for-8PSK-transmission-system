function [b,b_gray] = octal2bits_2D(table_2D)
[r c]=size(table_2D);
for i=1:r
    for j=1:c
        if(table_2D(i,j)==0)
            b(i,:)=[0 0 0];
        elseif(table_2D(i,j)==1)
            b(i,:)=[0 0 1];
        elseif(table_2D(i,j)==2)
            b(i,:)=[0 1 0];
        elseif(table_2D(i,j)==3)
            b(i,:)=[0 1 1];
        elseif(table_2D(i,j)==4)
            b(i,:)=[1 0 0];
        elseif(table_2D(i,j)==5)
            b(i,:)=[1 0 1];
        elseif(table_2D(i,j)==6)
            b(i,:)=[1 1 0];
        elseif(table_2D(i,j)==7)
            b(i,:)=[1 1 1];
        end
    end
end
for i=1:r
    b_gray(i,:)=triads2gray(b);
end


end

