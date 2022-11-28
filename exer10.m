clear all; close all; clc;
tic
%Init
sigma=1; %s^2
SNRdB=0:2:14;
SNR=10.^(SNRdB./10);
BERnoCoding=zeros(1,length(SNRdB));
BERnoCodingGray=zeros(1,length(SNRdB));
BER_ReedSolomongray=zeros(1,length(SNRdB));
BER_ReedSolomon=zeros(1,length(SNRdB));
BERhamming=zeros(1,length(SNRdB));
BERhamminggray=zeros(1,length(SNRdB));

%%
%question 1
Eb=SNR.*sigma
%%
%question 2
%We have a transmission system with 8-PSK modulation/Bits are given in gray form
%For the code to be more intuition friendly/ we changed the names b<->b_gray
M=3*10^4;
b_gray=randi([0,1],1,M); %data
%%
%question 3
b=graytriads2bi(b_gray); %coded %gray2bi
%%
%question4
b_oct=bits2octal(b); %binary to octal (it is not from gray form)
%%
%question5,8,9
s1=oct_to_8PSK(b_oct);
for i=1:length(SNR)
    snridx_nocoding=i
    %SIGNAL AMPLIFICATION
    A=sqrt(3*Eb(i));
    s=s1*A;
    n=(1/(sqrt(2)))*(randn(1,length(s))+1j*randn(1,length(s)));% we multiply with 1/(sqrt(2) because we want s^2=1 and we consider a complex gaussian
    r=s+n;
    %DETECTION
    detected_oct=detection_8PSK(r);%symbol estimation//ML_detector
    detected=octal2bits(detected_oct);
    detected_gray=triads2gray(detected);%bi2gray
    BERnoCodingGray(i)=BERnoCodingGray(i)+sum(detected_gray~=b_gray)/(M);
    BERnoCoding(i)=BERnoCoding(i)+sum(detected~=b)/(M);
end
    


%%
%question 6,8,10 antistoixhsh mod_g 5ades se reed solomon 7ades//2 parity octal dits linear code 
k1=5;n1=7;L=3;
ReedSolomonCodebook=load('Reed_Solomon_Codebook.mat');
rsCodebook=ReedSolomonCodebook.Reed_Solomon_Codebook;
[r c]=size(rsCodebook);
R_rs=k1/n1;
Ec_r=(k1/n1)*Eb;
a=0;
for j=1:5:length(b_oct)
    mat1=[b_oct(j) b_oct(j+1) b_oct(j+2) b_oct(j+3) b_oct(j+4)];
    for i=1:r
        mat2=[rsCodebook(i,1) rsCodebook(i,2) rsCodebook(i,3) rsCodebook(i,4) rsCodebook(i,5)];
        if(mat1==mat2)
            a=a+1;
            rsCodewords(a,:)=[rsCodebook(i,1) rsCodebook(i,2) rsCodebook(i,3) rsCodebook(i,4) rsCodebook(i,5) rsCodebook(i,6) rsCodebook(i,7)];
        end
    end
end



rsCodebook_gray=oct2gray_oct(rsCodebook);
rsCodewords_gray=oct2gray_oct(rsCodewords);
[ro co] = size(rsCodebook);
for i=1:ro
    rscdbk(i,:)=oct_to_8PSK(rsCodebook(i,:));
    rscdbk_gray(i,:)=oct_to_8PSK(rsCodebook_gray(i,:));
end
for i=1:length(SNR)
     snridx_reed_solomon=i
     [r1 c1]=size(rsCodewords);
     A=sqrt(3*Ec_r(i));
     rsCodebook_amp=rscdbk*A;
     rsCodebook_amp_gray=rscdbk_gray*A;
     for j=1:r1
        s1=oct_to_8PSK(rsCodewords(j,:));
        s1_gray=oct_to_8PSK(rsCodewords_gray(j,:));
        %SIGNAL AMPLIFICATION
        s=s1*A;
        s_gray=s1_gray*A;
        %COMPLEX NOISE
        n=(1/(sqrt(2)))*(randn(1,length(s))+1j*randn(1,length(s)));% we multiply with 1/(sqrt(2) because we want s^2=1 and we consider a complex gaussian
        %ADD NOISE TO SIGNAL
        r=s+n;
        r_gray=s_gray+n;
        [r2 c2]=size(rsCodebook);
        %SOFT DECISION DECODING
        rnew=repmat(r,r2,1); 
        rnew_gray=repmat(r_gray,r2,1);   
        %Norm Calculation-Euclidean Distance
        %//part1.1 norm cnalculation//
        pin1=abs((rnew-rsCodebook_amp)); 
        pin1_gray=abs((rnew_gray-rsCodebook_amp_gray));
        %//part1.2 norm calculation//
        pin2=pin1.^2;
        pin2_gray=pin1_gray.^2;
        %//part1.3 norm calculation//sum of 2nd dimension=>sum(A,2) is a column vector containing the sum of each row.
        pin3=(sum(pin2,2))'; 
        pin3_gray=(sum(pin2_gray,2))'; 
        %part1.4 norm calculation//find minimum value of all possible norms
        [minVal,idx]=min(pin3); 
        [minValg,idxg]=min(pin3_gray); 
        
        %BER CALCULATION
        demod=rsCodebook(idx,:);
        demod1=demod(1:5);
        demod1=octal2bits(demod1);
        demod_gray=rsCodebook_gray(idxg,:);
        demod1_gray=demod_gray(1:5);
        demod1_gray=triads2gray(octal2bits(demod1_gray));
        codeword=[rsCodewords(j,1) rsCodewords(j,2) rsCodewords(j,3) rsCodewords(j,4) rsCodewords(j,5)];
        codeword=octal2bits(codeword);
        codeword_gray=[rsCodewords_gray(j,1) rsCodewords_gray(j,2) rsCodewords_gray(j,3) rsCodewords_gray(j,4) rsCodewords_gray(j,5)];
        codeword_gray=triads2gray(octal2bits(codeword_gray));
        BER_ReedSolomongray(i)=BER_ReedSolomongray(i)+sum(demod1_gray~=codeword_gray)/M;
        BER_ReedSolomon(i)=BER_ReedSolomon(i)+sum(demod1~=codeword)/M;
     end
end




%%
%question 7,8,11 antistoixhsh apo 4ades se hamming 7ades//3 parity bits linear code 

%--HAMMING CODEBOOK CREATION------------------------------------------------------------------------------------------------------%

n1=7;k1=4; %Hamming (7,4)
m1=n1-k1; %m=3
[H1o,G1o]=hammgen(m1); %Create H1,G1 matrices
H1=rot90(H1o,2);G1=rot90(G1o,2); %H1 and G1 must be in systematic form
b1=de2bi(0:(2^k1)-1);
codebook1=mod(b1*G1,2) ;% O pinakas G pollaplasiazetai me th leksh plhroforias gia na dinei apotelesma kwdikh leksh//c_1......c_n1
%--------------------------------------------------------------------------------------------------------------------------------%
[r c]=size(codebook1);
R_h=k1/n1;
Ec_h=R_h*Eb;
a=0;
for j=1:4:length(b_gray)
    mat1=[b(j) b(j+1) b(j+2) b(j+3)];
    for i=1:r
        mat2=[codebook1(i,1) codebook1(i,2) codebook1(i,3) codebook1(i,4)];
        if(mat1==mat2)
            a=a+1;
            ham_indexes(a)=i;
            tetrades_indexes(a)=j;
            hamCodewords(a,:)=[codebook1(i,1) codebook1(i,2) codebook1(i,3) codebook1(i,4) codebook1(i,5) codebook1(i,6) codebook1(i,7)];
        end
        
    end
end


%bitstream creation
[r1 c1]=size(hamCodewords);
k=0;
for i=1:r1 
    for j=1:c1
        k=k+1;
        bitstream(k)=hamCodewords(i,j);
    end
end
%bitstream and bitstream gray to octal
bitstream_oct=bits2octal(bitstream);
bitstream_gray=triads2gray(bitstream);
bitstream_gray_oct=bits2octal(bitstream_gray);
% cdbk_gray=cat(2,codebook1,codebook1,codebook1);
% [r c]=size(cdbk_gray);
% for i=1:r
%     codebook1_gray(i,:)=triads2gray(cdbk_gray(i,:));
% end


%modulation 8PSK
s1=oct_to_8PSK(bitstream_oct);
s1_gray=oct_to_8PSK(bitstream_gray_oct);
for k=1:length(SNR)
    snridx_hamming_hdd=k
    %SIGNAL AMPLIFICATION
    A=sqrt(3*Ec_h(k));
    s=s1*A;
    s_gray=s1_gray*A;
    n=(1/(sqrt(2)))*(randn(1,length(s))+1j*randn(1,length(s)));% we multiply with 1/(sqrt(2) because we want s^2=1 and we consider a complex gaussian
    r=s+n;
    r_gray=s_gray+n;
    %DETECTION//ML DECODING
    detected_oct=detection_8PSK(r);%symbol estimation//ML_detector
    detected=octal2bits(detected_oct);
    detected_oct_gray=detection_8PSK(r_gray);%symbol estimation//ML_detector
    detected_gray=octal2bits(detected_oct_gray);
    for i=1:7:length(detected)
      det1=[detected(i) detected(i+1) detected(i+2) detected(i+3) detected(i+4) detected(i+5) detected(i+6)];
      det2=[detected_gray(i) detected_gray(i+1) detected_gray(i+2) detected_gray(i+3) detected_gray(i+4) detected_gray(i+5) detected_gray(i+6)];
      %HARD DECISION DECODING%
      cc=size(codebook1);
      ccrows=cc(1);
      ccols=cc(2);
      rnew=repmat(det1,ccrows,1);
      AA=xor(codebook1,rnew);
      AA=sum(AA,2);
      [minVal,idx]=min(AA');
      demod1=codebook1(idx,:);
      BERhamming(k)=BERhamming(k)+sum(demod1~=det1)/M ;
    end
end

figure;
semilogy(SNRdB,BERnoCoding);
hold on
grid on
semilogy(SNRdB,BERnoCodingGray);
semilogy(SNRdB,BER_ReedSolomon);
semilogy(SNRdB,BER_ReedSolomongray);
semilogy(SNRdB,BERhamming);
legend('uncoded','uncoded with Gray mapping','Reed-Solomon(SDD-8PSK)','Reed-Solomon with Gray mapping(SDD-8PSK)','Hamming (HDD-8PSK)') ;
xlabel('SNR per bit(dB)');
ylabel('BER');

toc
%STO THLEPIKOINWNIAKO SYSTHMA DIALEGOUME NO-CODING ME GRAY MAPPING MEXRI TA 2DB KAI APO TA
%2DB KAI META DIALEGOUME REED SOLOMON ME SDD KAI GRAY MAPPING


