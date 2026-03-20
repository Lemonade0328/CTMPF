function M = compute_metrics_underwater(img)
% img: double RGB, range [0,1]

img = max(min(img,1),0);
if size(img,3) ~= 3
    error('compute_metrics_underwater expects RGB image');
end

% --- 基础 ---
gray = rgb2gray(img);

% Entropy (灰度熵)
M.Entropy = entropy(gray);

% RMS contrast
M.RMSContrast = std2(gray);

% Tenengrad (梯度能量锐度)
[Gx, Gy] = imgradientxy(gray, 'sobel');
M.Tenengrad = mean2(Gx.^2 + Gy.^2);

% --- UCIQE / UIQM (水下常用) ---
M.UCIQE = metric_uciqe(img);
M.UIQM  = metric_uiqm(img);

% 可选：如果你有相关工具箱，可打开
% try
%     M.NIQE = niqe(gray);      % 越小越好
% catch
%     M.NIQE = NaN;
% end

end
