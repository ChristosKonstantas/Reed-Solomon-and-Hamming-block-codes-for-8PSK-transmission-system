function b = graytriads2bi(b_gray)

j=1;
for i=1:3:length(b_gray)  
     btemp=gray2bi([b_gray(i) b_gray(i+1) b_gray(i+2)]);
     b(j)=btemp(1);
     b(j+1)=btemp(2);
     b(j+2)=btemp(3);
    j=j+3;
end 

end

