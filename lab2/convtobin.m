function bin = convtobin(in)
    b = in *(2^(7));     
    if in < 0
        bin2 = dec2twos((2^(10)+ b),11);
        bin  = str2double(bin2); 
    else
        bin1 = dec2twos(b,10);
        bin  = str2double(bin1);
    end