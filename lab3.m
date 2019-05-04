%% find max W and max F of coef
clc;
% get file data
filename = 'lab3-coef.txt';
A = importdata(filename);
% find max W
W = zeros(25,1);
for i = 1:25
    decpart = dec2bin(abs(floor(A(i,1))));
    % convert decimal int to binary for part before '.'
    % get w
    w = numel(num2str(decpart));
    W(i,1) = w;
end
Wm = max (W)

% find max F
F = zeros(25,1);
for i = 1:25
    f = 0;
    inp = abs(A(i,1)) - abs(floor(A(i,1)));
    fi = inp;
    while fi~=0
        f = f+1;
        fi = fi*2;
        fi = fi - floor(fi);
    end
    F(i,1) = f;
end
Fm = max (F)

% By running this part of the code,
% Wm = 1; Fm = 61. for both x and y txt file

%% find max W and max F of coef
clc;
% get file data
filename = 'lab3-In.txt';
A = importdata(filename);
% find max W
W = zeros(1,999);
for i = 1:999
    decpart = dec2bin(abs(floor(A(1,i))));
    % convert decimal int to binary for part before '.'
    % get w
    w = numel(num2str(decpart));
    W(1,i) = w;
end
Wm = max (W)

% find max F
F = zeros(1,999);
for i = 1:999
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
% Wm = 1; Fm = 55. for both x and y txt file

%% output data for coeff
clc;
filename = 'lab3-coef.txt';
Ac = importdata(filename);
Bc = strings(0,25);
for i = 1:25
    ac = Ac(i,1);
    bi = convtobin2(ac);
    n = numel(num2str(bi)); %count the number of digits of each string
    if n <= 16
        if ac >= 0
            b = pad(num2str(bi),16,'left','0');
        else
            b = pad(num2str(bi),16,'left','1');
        end
    else
        disp('error');
    end
    Bc(i) = b;
end
fileID = fopen ('\\campus.mcgill.ca\EMF\ELE\wliang11\Desktop\ecse 325\lab3\lab3-coef-fixed-point.txt','wt');
fprintf(fileID, '%s\n', Bc);
fclose(fileID);

%% output data for coeff
clc;
filename = 'lab3-In.txt';
Ai = importdata(filename);
Bi = strings(0,999);
for i = 1:999
    ai = Ai(1,i);
    bi = convtobin2(ai);
    n = numel(num2str(bi)); %count the number of digits of each string
    if n <= 16
        if ai >= 0
            b = pad(num2str(bi),16,'left','0');
        else
            b = pad(num2str(bi),16,'left','1');
        end
    else
        disp('error');
    end
    Bi(i) = b;
end
fileID = fopen ('\\campus.mcgill.ca\EMF\ELE\wliang11\Desktop\ecse 325\lab3\lab3-In-fixed-point.txt','wt');
fprintf(fileID, '%s\n', Bi);
fclose(fileID);