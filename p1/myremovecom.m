function BW_cleaned = myremovecom(BW, minArea)
    [L, ~] = mysegmentation(BW);
    keepLabels = [];
    
    for label = 1:max(L(:))
        component = (L == label);
        componentArea = sum(component(:));
        
        if componentArea >= minArea
            keepLabels = [keepLabels, label];
        end
    end
    BW_cleaned = ismember(L, keepLabels);
end