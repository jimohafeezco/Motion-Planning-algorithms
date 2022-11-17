function [tC1ext,tC2ext, tC1int, tC2int ]= tangentscircle(C1, C2, r)
% Circle A
xA=C1(1);
yA=C1(2);
RA=r;

% Circle B
xB=C2(1);
yB=C2(2);
RB=r;


% Draw circles
a=[0:pi/16:2*pi];
Xa=xA+RA*cos(a);
Ya=yA+RA*sin(a);
plot (Xa,Ya,'k');
hold on;
axis square equal;
grid on;
plot (xA,yA,'xk');


Xb=xB+RB*cos(a);
Yb=yB+RB*sin(a);
plot (Xb,Yb,'k');
plot (xB,yB,'xk');


% Compute distance between circle centers
D=sqrt ( (xB-xA)^2 + (yB-yA)^2 );

%% First case : process external tangents

if (D^2 - (RA-RB)^2>=0)
    
    % Compute the length of the tangents
    L=sqrt(D^2 - (RA-RB)^2);

    % Compute the parameters
    R1=sqrt(L^2+RB^2);    
    Sigma1= (1/4) * sqrt ( ( D+RA+R1 )*( D+RA-R1 )*( D-RA+R1 )*( -D+RA+R1 )  );
    R2=sqrt(L^2+RA^2);
    Sigma2= (1/4) * sqrt ( ( D+RB+R2 )*( D+RB-R2 )*( D-RB+R2 )*( -D+RB+R2 )  );
    
    
    % Compute the first tangent
    x11= (xA+xB)/2 + (xB-xA)*(RA^2-R1^2)/(2*D^2) + 2*(yA-yB)*Sigma1/(D^2);
    y11= (yA+yB)/2 + (yB-yA)*(RA^2-R1^2)/(2*D^2) - 2*(xA-xB)*Sigma1/(D^2);
    x21= (xB+xA)/2 + (xA-xB)*(RB^2-R2^2)/(2*D^2) - 2*(yB-yA)*Sigma2/(D^2);
    y21= (yB+yA)/2 + (yA-yB)*(RB^2-R2^2)/(2*D^2) + 2*(xB-xA)*Sigma2/(D^2);   
    
    tC1ext = [x11;y11];
    tC2ext = [x21; y21];
    % Display tangent
%     plot (x11,y11,'ob');
%     plot (x21,y21,'ob');
    line ([x11 x21],[y11 y21],'Color','b');
       
    
    % Compute second tangent
    x12= (xA+xB)/2 + (xB-xA)*(RA^2-R1^2)/(2*D^2) - 2*(yA-yB)*Sigma1/(D^2);
    y12= (yA+yB)/2 + (yB-yA)*(RA^2-R1^2)/(2*D^2) + 2*(xA-xB)*Sigma1/(D^2);
    x22= (xB+xA)/2 + (xA-xB)*(RB^2-R2^2)/(2*D^2) + 2*(yB-yA)*Sigma2/(D^2);
    y22= (yB+yA)/2 + (yA-yB)*(RB^2-R2^2)/(2*D^2) - 2*(xB-xA)*Sigma2/(D^2);   
    
    % Display tangent|
%     Cxt = [x12, y12];
%     Cyt = [x22, y22];
% %     plot (x12,y12,'om');
%     plot (x22,y22,'om');
%     line ([x12 x22],[y12 y22],'Color','m');
% else
%     disp ('No external tangents');
% end






%% Second case : process internal tangents

if (D^2 - (RA+RB)^2>=0)
    
    % Compute the length of the tangents
    L=sqrt(D^2 - (RA+RB)^2);

    % Compute the parameters
    R1=sqrt(L^2+RB^2);    
    Sigma1= (1/4) * sqrt ( ( D+RA+R1 )*( D+RA-R1 )*( D-RA+R1 )*( -D+RA+R1 )  );
    R2=sqrt(L^2+RA^2);
    Sigma2= (1/4) * sqrt ( ( D+RB+R2 )*( D+RB-R2 )*( D-RB+R2 )*( -D+RB+R2 )  );
    
    
    % Compute the first tangent
    x11= (xA+xB)/2 + (xB-xA)*(RA^2-R1^2)/(2*D^2) + 2*(yA-yB)*Sigma1/(D^2);
    y11= (yA+yB)/2 + (yB-yA)*(RA^2-R1^2)/(2*D^2) - 2*(xA-xB)*Sigma1/(D^2);
    x21= (xB+xA)/2 + (xA-xB)*(RB^2-R2^2)/(2*D^2) + 2*(yB-yA)*Sigma2/(D^2);
    y21= (yB+yA)/2 + (yA-yB)*(RB^2-R2^2)/(2*D^2) - 2*(xB-xA)*Sigma2/(D^2);   
    tC1int =[ x11, y11];
    tC2int = [x21, y21];
    % Display tangent
%     plot (x11,y11,'og');
%     plot (x21,y21,'og');
%     line ([x11 x21],[y11 y21],'Color','g');
       
    
    % Compute second tangent
    x12= (xA+xB)/2 + (xB-xA)*(RA^2-R1^2)/(2*D^2) - 2*(yA-yB)*Sigma1/(D^2);
    y12= (yA+yB)/2 + (yB-yA)*(RA^2-R1^2)/(2*D^2) + 2*(xA-xB)*Sigma1/(D^2);
    x22= (xB+xA)/2 + (xA-xB)*(RB^2-R2^2)/(2*D^2) - 2*(yB-yA)*Sigma2/(D^2);
    y22= (yB+yA)/2 + (yA-yB)*(RB^2-R2^2)/(2*D^2) + 2*(xB-xA)*Sigma2/(D^2);   
    tC1int = [x12; y12];
    tC2int = [x22; y22];
    % Display tangent
%     plot (x12,y12,'or');
%     plot (x22,y22,'or');
%     line ([x12 x22],[y12 y22],'Color','r');
else
    disp ('No internal tangents');
end

end

