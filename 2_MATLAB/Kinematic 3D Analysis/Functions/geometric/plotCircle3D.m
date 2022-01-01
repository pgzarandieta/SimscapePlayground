function [] = plotCircle3D(axes, center,normal,radius,color)
normal = reshape(normal,1,[]);    
center = reshape(center,[],1);
theta=0:0.1:2*pi;
    v=null(normal);
    points=repmat(center,1,size(theta,2))+radius*(v(:,1)*cos(theta)+v(:,2)*sin(theta));
switch nargin
    case 4
        plot3(axes, points(1,:),points(2,:),points(3,:),'color',[.1 .1 .1],'linewidth',1.2);
        plot3(axes, [points(1,end) points(1,1)], [points(2,end) points(2,1)], [points(3,end) points(3,1)],'color',[.1 .1 .1],'linewidth',1.2);
    case 5
        plot3(axes, points(1,:),points(2,:),points(3,:),'color',color,'linewidth',1.2);
        plot3(axes, [points(1,end) points(1,1)], [points(2,end) points(2,1)], [points(3,end) points(3,1)],'color',color,'linewidth',1.2);
    otherwise
end

end