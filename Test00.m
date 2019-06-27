close all;
clear all;
clc;

fprintf('Avvio\n');

input_path = 'C:\Workspace\Python\FFMPEGContinous\output\';
input_ffmpeg_raw = 'dataRaw_20190626-103846.rgb24';
input_my_processing = 'data_20190627-212834.rgb24';
input_my_processing_all = 'dataAll_20190627-211840.rgb24';

s_width = 108;
s_height = 192;
rgb_frame_size = s_width * s_height * 3;

fullfilename_ffmpeg_raw = fullfile(input_path, input_ffmpeg_raw);
f_ffmpeg_raw_hndlr = dir(fullfilename_ffmpeg_raw);
if exist(fullfilename_ffmpeg_raw, 'file') ~= 2
    fprintf(2, 'File %s doesn''t exist!\n\n', fullfilename_ffmpeg_raw);
    return;
end
len_ffmpeg_raw = f_ffmpeg_raw_hndlr.bytes;
n_frames_ffmpeg_raw = floor(len_ffmpeg_raw/rgb_frame_size);
frames_ffmpeg_raw = {n_frames_ffmpeg_raw};
[R_ffmpeg_raw, G_ffmpeg_raw, B_ffmpeg_raw] = rgb_import( ...
    fullfile(input_path, input_ffmpeg_raw), ...
    [s_height, s_width], ...
    n_frames_ffmpeg_raw);
for i=1:1:n_frames_ffmpeg_raw
    frames_ffmpeg_raw{i} = cat(3, R_ffmpeg_raw{i}, G_ffmpeg_raw{i}, B_ffmpeg_raw{i});
end

fullfilename_my_processing = fullfile(input_path, input_my_processing);
f_my_processing_hndlr = dir(fullfilename_my_processing);
if exist(fullfilename_my_processing, 'file') ~= 2
    fprintf(2, 'File %s doesn''t exist!\n\n', fullfilename_my_processing);
    return;
end
len_my_processing = f_my_processing_hndlr.bytes;
n_frames_my_processing = floor(len_my_processing/rgb_frame_size);
frames_my_processing = {n_frames_my_processing};
[R_frames_my_processing, G_frames_my_processing, B_frames_my_processing] = rgb_import( ...
    fullfile(input_path, input_my_processing), ...
    [s_height, s_width], ...
    n_frames_my_processing);
for i=1:1:n_frames_my_processing
    frames_my_processing{i} = cat(3, R_frames_my_processing{i}, G_frames_my_processing{i}, B_frames_my_processing{i});
end

fullfilename_my_processing_all = fullfile(input_path, input_my_processing_all);
f_my_processing_all_hndlr = dir(fullfilename_my_processing_all);
if exist(fullfilename_my_processing_all, 'file') ~= 2
    fprintf(2, 'File %s doesn''t exist!\n\n', fullfilename_my_processing_all);
    return;
end
len_my_processing_all = f_my_processing_all_hndlr.bytes;
n_frames_my_processing_all = floor(len_my_processing_all/rgb_frame_size);
frames_my_processing_all = {n_frames_my_processing_all};
[R_frames_my_processing_all, G_frames_my_processing_all, B_frames_my_processing_all] = rgb_import( ...
    fullfile(input_path, input_my_processing_all), ...
    [s_height, s_width], ...
    n_frames_my_processing_all);
for i=1:1:n_frames_my_processing_all
    frames_my_processing_all{i} = cat(3, R_frames_my_processing_all{i}, G_frames_my_processing_all{i}, B_frames_my_processing_all{i});
end

% Select a random integer between 1 and n_frames
pick_a_frame = randperm(min(n_frames_ffmpeg_raw, n_frames_my_processing), 1);
subplot(1,3,1), imshow(frames_ffmpeg_raw{pick_a_frame}), title(sprintf('Frame %d' ,pick_a_frame));
subplot(1,3,2), imshow(frames_my_processing{pick_a_frame}), title(sprintf('Frame %d' ,pick_a_frame));
subplot(1,3,3), imshow(frames_my_processing_all{pick_a_frame}), title(sprintf('Frame %d' ,pick_a_frame));

max_frames = 18;
frame_rate_plot = 0.01;
for i=1:1:min([max_frames, max([n_frames_ffmpeg_raw, n_frames_my_processing, n_frames_my_processing_all])])
    if i<= n_frames_ffmpeg_raw
        subplot(1,3,1), imshow(frames_ffmpeg_raw{i}), title(sprintf('Frame %d' ,i));
    end
    if i<= n_frames_my_processing
        subplot(1,3,2), imshow(frames_my_processing{i}), title(sprintf('Frame %d' ,i));
    end
    if i<= n_frames_my_processing_all
        subplot(1,3,3), imshow(frames_my_processing_all{i}), title(sprintf('Frame %d' ,i));
    end
    pause(frame_rate_plot);
end

fprintf('Completato\n');