function angle = vectsAngle(u,v,units)
angle = acos(dot(u,v)/(norm(u)*norm(v)));
switch nargin
    case 3
        switch units
            case 'deg'
                angle = angle*180/pi;
            case 'rad'
            otherwise
                disp('anlge in radians');
        end   
    case 2
        angle = angle*180/pi;
    otherwise
end

end