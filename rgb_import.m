function [ R,G,B ] = rgb_import( filename, dims, numfrm )
%RGB_IMPORT Summary of this function goes here
%   Detailed explanation goes here
fid=fopen(filename,'r');
if (fid < 0) 
    error('File does not exist!');
end;
inprec = '*uint8';

R = cell(1,numfrm);
G = cell(1,numfrm);
B = cell(1,numfrm);

fseek(fid, 0 , 0); %go to the starting frame

frame_size = dims(1) * dims(2) * 3;
r_indexes = [1:3:frame_size];
g_indexes = [2:3:frame_size];
b_indexes = [3:3:frame_size];

for i=1:numfrm
    frame = fread(fid, frame_size, inprec);
    Rd = frame(r_indexes);
    Rd = reshape(Rd, dims);
    R{i} = Rd';   
    Gd = frame(g_indexes);
    Gd = reshape(Gd, dims);
    G{i} = Gd';
    Bd = frame(b_indexes);
    Bd = reshape(Bd, dims);
    B{i} = Bd';    
end

fclose(fid);

end