function [value] = area_RP(recall, precision)

[recallsize,~] = size(recall);

area = 0;

if(recallsize > 0)
    if(recall(1)~=0)
        recall_size = size(recall)
        xx = [0,recall'];
        yy = [precision(1), precision'];
    else
        xx = [recall'];
        yy = [precision'];
    end

    [xx, index] = unique(xx);
    yy = yy(index);
    for iii = 1:length(xx)
        ic = length(xx)-iii+1;
        if(yy(ic) >= 0)
            % nothing
        else
            yy(ic) = yy(ic+1);
        end

    end
    area = 0;
    for i=1:(length(xx)-1)
        subarea = 0.5*(xx(i+1)-xx(i))*(yy(i+1)+yy(i));
        area = area+subarea;
    end
    
%     precision_min = precision(end)
%     recall_max = recall(end)
%     extra_subarea = precision_min*recall_max
%     area = area + extra_subarea;
    
end
value = area;