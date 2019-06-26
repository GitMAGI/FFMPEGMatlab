close all;
clear all;
clc;

fprintf('Avvio\n');

input_path = 'C:\Workspace\Python\FFMPEGContinous\output\';
input_file_yuv = 'dataRaw_20190626-103846.yuv';

pathfilename = fullfile(input_path, input_file_yuv);

f_hndlr = dir(pathfilename);
f_size = f_hndlr.bytes;

w = 192;
h = 108;
format = 'YUV420_8';
n_frames = floor(f_size/(w*h*3/2));

[Y,U,V] = yuv_import(pathfilename, [w h], n_frames, 0, format);

RGBs = {n_frames};
for i=1:1:n_frames
    RGB = yuv2rgb(Y{i},U{i},V{i}, format);
    RGBs{i} = RGB;
end
clear RGB i;

% Select a random integer between 1 and n_frames
pick_a_frame = randperm(n_frames, 1);
imshow(RGBs{pick_a_frame});
title(sprintf('Frame %d' ,pick_a_frame));

for i=1:1:min(1000, n_frames)
    imshow(RGBs{i});
    title(sprintf('Frame %d' ,i));
    pause(0.05);
end

fprintf('Completato\n');