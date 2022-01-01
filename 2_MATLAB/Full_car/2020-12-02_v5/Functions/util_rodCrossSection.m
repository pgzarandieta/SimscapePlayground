function [vertices] = util_rodCrossSection(length,diameter,thickness)
% Returns 4 vertices of a straight tube cross section, to create a revolute
% solid in simscape multibody.
vertices = [diameter/2-thickness length/2; diameter/2-thickness -length/2; diameter/2 -length/2; diameter/2 length/2];
end
