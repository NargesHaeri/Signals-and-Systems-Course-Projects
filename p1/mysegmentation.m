function [L, Ne] = mysegmentation(BW)
    L = zeros(size(BW));
    label = 0;
    for row = 1:size(BW, 1)
        for col = 1:size(BW, 2)
            if BW(row, col) == 1
                neighbors = [L(max(row-1,1):min(row+1,end), max(col-1,1):min(col+1,end))];
                neighbor_labels = unique(nonzeros(neighbors));
                if isempty(neighbor_labels)
                    label = label + 1;
                    L(row, col) = label;
                else
                    L(row, col) = min(neighbor_labels);
                end
            end
        end
    end
    Ne = label;
end
