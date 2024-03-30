
ICrecognition('PCB.jpg', 'IC.jpg');


function ICrecognition(PCBimage, ICimage)
    
    Img = rgb2gray(imread(PCBimage));
    Img_temp = rgb2gray(imread(ICimage));
   
    c_original = normxcorr2(Img_temp, Img);
    
    Img_temp_rotated = imrotate(Img_temp, 180);

    c_rotated = normxcorr2(Img_temp_rotated, Img);

    c_combined = max(c_original, c_rotated);

    threshold = 0.75;
    [ypeak, xpeak] = find(c_combined > threshold);
    
    min_peak_distance = 5;
    for n = 1:length(ypeak) - 1
        if abs(ypeak(n) - ypeak(n+1)) < min_peak_distance
            ypeak(n) = 0;
            xpeak(n) = 0;
        end
    end

    xpeak = nonzeros(xpeak);
    ypeak = nonzeros(ypeak);

    yoffSet = ypeak - size(Img_temp, 1);
    xoffSet = xpeak - size(Img_temp, 2);

    figure;
    imshow(Img);
    title('Matching Result');

    for m = 1:length(ypeak)
        imrect(gca, [xoffSet(m) + 1, yoffSet(m) + 1, size(Img_temp, 2), size(Img_temp, 1)]);
    end
end
