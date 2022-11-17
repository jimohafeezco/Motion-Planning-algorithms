function isfree = isFree(q, Obstacles)
isfree = 1;
    numObs= length(Obstacles);
    for n = 1:numObs
       isfree = isfree && (~inpolygon(q(1), q(2), Obstacles{n}(1,:),Obstacles{n}(2,:)));
       if ~isfree
           break;
        end
    end
end
% function isfree = isFree(q, Obstacles)
% if(size(q,1) == 1)
%     in = 1;
%     for n = 1:numel(Obstacles)
%        in = inpolygon(q(1), q(2), Obstacles{n}(:,1),Obstacles{n}(:,2));
%        if in
%            break;
%        end
%     end
%     isfree = ~in;
% elseif(size(q,1)>1)
%     collided = 1;
%     for n = 1:size(q,1)
%         collided = ~isFree(q(n,:), Obstacles);
%         if collided
%             break;
%         end
%     end
%     isfree = ~collided;
% end
% 
