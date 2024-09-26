function bin = convtobin2(in)
    b = round(in *(2^(15)));     
    if in < 0
        bin2 = dec2twos((2^(16)+ b),17);
        bin  = str2double(bin2); 
    else
        bin1 = dec2twos(b,16);
        bin  = str2double(bin1);
    end