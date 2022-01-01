function [translatedPoint] = translatePoint(P,v)
%Translate point P by vector v
translatedPoint = P(:) + v(:);
if isrow(P)
    translatedPoint = translatedPoint';
end
end

