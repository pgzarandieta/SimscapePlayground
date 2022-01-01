function [u,v] = findVectorsInPlane(n)
%find two vectors contained in a plane defined by its normal vector n

n = reshape(n,1,[]);

if n(1) == 0
    u(1)=1;
    if n(2) == 0
        if n(3) == 0
            disp('error');
        else
            u(2) = 1;
            u(3) = 0;
        end
    else
        if n(3) == 0
            u(2)=0;
            u(3)=1;
        else
            u(2)=1;
            u(3)=-n(2)/n(3);
        end
    end
else
    u(1)=0;
    if n(2) == 0
        if n(3) == 0
            u(2)=1;
            u(3)=1;
        else
            u(2)=1;
            u(3)=0;
        end
    else
        if n(3) == 0
            u(2)=0;
            u(3)=1;
        else
            u(2)=1;
            u(3)=-n(2)/n(3);
        end
    end
end   

v = cross(u,n);
v = v./norm(v);
u = u./norm(u);

end

