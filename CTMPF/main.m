warning('off','all');
clear all; close all; clc;

% 更新路径：取消 Method 文件夹，保留 utils 和 metrics
addpath('utils','metrics'); 

%% ================== 输入与输出设置 ==================
% 指定单幅图片路径
in_path = 'image\67_img_.png';
output_folder = 'image\result\';
if ~exist(output_folder,'dir')
    mkdir(output_folder);
end
% 解析文件名和扩展名
[~, img_name, img_ext] = fileparts(in_path);


window  = 5;
r       = 32;
eps_val = 0.01;
theta   = 0.8;  
phi     = 0.5;  
beta    = 1.0;   

if ~exist(in_path, 'file')
    error('找不到输入文件：%s', in_path);
end
fprintf('正在处理图片: %s\n', img_name);


input_img = imread(in_path);


Input_uint8 = uint8(CSCT(input_img) .* 255);
I = double(Input_uint8) / 255.0;

J = ISAM(I, window, r, eps_val, theta, phi, beta);

out_name = [img_name, img_ext];
out_path = fullfile(output_folder, out_name);
imwrite(J, out_path);
fprintf('结果已保存至: %s\n', out_path);

fields = fieldnames(metrics_out);
 for i = 1:length(fields)
     name = fields{i};
     v0 = metrics_in.(name); 
     v1 = metrics_out.(name);
     fprintf('%s: %.4f -> %.4f ( %+6.2f%% )\n', name, v0, v1, 100*(v1-v0)/(abs(v0)+1e-12));
 end