function [A] = util_generate_grid_x(Floor_size,Grid_size)
Equispace = linspace(-Floor_size/2,Floor_size/2,Floor_size/Grid_size+1);
n=1;
for i=-Floor_size/2:Grid_size:Floor_size/2
    A(n:Floor_size/Grid_size+n,:) = [repelem(i,Floor_size/Grid_size+1);Equispace]';
    Equispace = flip(Equispace);
    n = n + Floor_size/Grid_size+1;
end
end