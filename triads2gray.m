function b_gray = triads2gray(b)

j=1;
for i=1:3:length(b)
    btemp=bi2gray([b(i) b(i+1) b(i+2)]);
    b_gray(j)=btemp(1);
    b_gray(j+1)=btemp(2);
    b_gray(j+2)=btemp(3);
    j=j+3;
end

end

