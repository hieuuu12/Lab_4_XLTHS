clc;
clear;

if ~isempty(winsid()) then
    close(winsid());
end

if ~isdef('imread') then
    atomsLoad('IPCV');
end

image_path = "input_image.png"; 

if ~isfile(image_path) then
    disp("Không tìm thấy input_image.png, đang tạo ảnh thử nghiệm...");
    img_raw = uint8(grand(256, 256, "uin", 0, 255));
else
    img_raw = imread(image_path);
end

if size(img_raw, 3) == 3 then
    img_gray = rgb2gray(img_raw);
else
    img_gray = img_raw;
end
img_gray = double(img_gray); 

function counts = calc_hist(img_in)
    img_u = uint8(img_in);
    counts = zeros(1, 256);
    [r, c] = size(img_u);
    for i = 1:r
        for j = 1:c
            val = double(img_u(i, j)) + 1;
            counts(val) = counts(val) + 1;
        end
    end
endfunction

function img_out = do_hist_equalize(img_in)
    img_u = uint8(img_in);
    [rows, cols] = size(img_u);
    total_pixels = rows * cols;
    
    counts = calc_hist(img_u);
    cdf = cumsum(counts) / total_pixels;
    cdf_map = round(cdf * 255);
    
    img_out = matrix(cdf_map(double(img_u) + 1), rows, cols);
    img_out = uint8(img_out);
endfunction

function plot_clean_hist(img_in, title_str)
    counts = calc_hist(img_in);
    bar(0:255, counts);
    title(title_str);
    a = gca();
    a.x_ticks = tlist(['ticks', 'locations', 'labels'], [0, 64, 128, 192, 255], ['0', '64', '128', '192', '255']);
endfunction

img_uint8 = uint8(img_gray);

img_eq = do_hist_equalize(img_uint8); 

h_blur = ones(5, 5) / 25; 
img_blur = imfilter(double(img_uint8), h_blur);
img_blur = uint8(img_blur);

img_watermarked = img_gray;
[height, width] = size(img_gray);

wm_h = floor(height * 0.12); 
wm_w = floor(width * 0.35);
alpha = 0.6; 
watermark_val = 255; 

r_start = height - wm_h - 10;
c_start = width - wm_w - 10;
img_watermarked(r_start:r_start+wm_h, c_start:c_start+wm_w) = ...
    alpha * img_watermarked(r_start:r_start+wm_h, c_start:c_start+wm_w) + (1 - alpha) * watermark_val;
img_watermarked = uint8(img_watermarked);

figure("Figure_Name", "Lab 4 - Exercise 5: Image Processing Demo");

subplot(2, 3, 1);
imshow(img_uint8);
title("1. Gốc (Original Gray)");

subplot(2, 3, 2);
plot_clean_hist(img_uint8, "2. Histogram Gốc");

subplot(2, 3, 3);
imshow(img_eq);
title("3. Cân bằng Histogram");

subplot(2, 3, 4);
plot_clean_hist(img_eq, "4. Histogram Sau Cân Bằng");

subplot(2, 3, 5);
imshow(img_blur);
title("5. Làm mờ (Blur 5x5)");

subplot(2, 3, 6);
imshow(img_watermarked);
title("6. Watermarking (Spatial)");
