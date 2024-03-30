function grayimage = mygrayfunc(picture)
    if size(picture, 3) == 3
        grayimage = 0.299 * picture(:,:,1) + 0.587 * picture(:,:,2) + 0.114 * picture(:,:,3);
    else
        grayimage = picture;
    end
    grayimage = uint8(grayimage);
end