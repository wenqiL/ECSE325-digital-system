%% find max W and max F
clc;
% get file data
filename = 'lab2-x.txt';
A = importdata(filename);
% find max W
W = zeros(1,1000);
for i = 1:1000
    decpart = dec2bin(abs(floor(A(1,i))));
    % convert decimal int to binary for part before '.'
    % get w
    w = numel(num2str(decpart));
    W(1,i) = w;
end
Wm = max (W)

% find max F
F = zeros(1,1000);
for i = 1:1000
    f = 0;
    inp = abs(A(1,i)) - abs(floor(A(1,i)));
    fi = inp;
    while fi~=0
        f = f+1;
        fi = fi*2;
        fi = fi - floor(fi);
    end
    F(1,i) = f;
end
Fm = max (F)

% By running this part of the code,
% Wm = 3; Fm = 7. for both x and y txt file

%% output data
clc;
B = strings(0,1000);
for i = 1:1000
    a = A(1,i);
    bi = convtobin(a);
    n = numel(num2str(bi)); %count the number of digits of each string
    if n <= 10
        if a >= 0
            b = pad(num2str(bi),10,'left','0');
        else
            b = pad(num2str(bi),10,'left','1');
        end
    else
        disp('error');
    end
    B(i) = b;
end
fileID = fopen ('\\campus.mcgill.ca\EMF\ELE\wliang11\Desktop\ecse 325\lab2\lab2-x-fixed-point.txt','wt');
fprintf(fileID, '%s\n', B);
fclose(fileID);