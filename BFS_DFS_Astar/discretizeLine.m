function pts = discretizeLine(line, stepsize) 
% % 
% p1 = line(1,:); p2 = line(2,:); 
% L = norm(diff(line)); N = ceil(L/stepsize) + 1; 
% t=linspace(0,1,N);
% pts = [(1-t)'.*p1 + t'.*p2];
% 

p1 = line(1,:); p2 = line(2,:); 
L = norm(diff(line)); N = ceil(L/stepsize) + 1; 
% points = []; 
end2end = linspace(0,1,N); 
f = end2end(2:end-1)'; 
pts = ones(size(f))*p1 + f*(p2-p1); 