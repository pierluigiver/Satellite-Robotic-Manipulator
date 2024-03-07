function [globe,cdata] = PlotCelestialBody(x0,y0,z0,rx,ry,rz,earth)

npanels = 180;   
GMST0 = [];

[x, y, z] = ellipsoid(x0, y0, z0, rx, ry, rz, npanels);
globe = surf(x, y, -z, 'FaceColor', 'none', 'EdgeColor', 'none');
if ~isempty(GMST0)
    hgx = hgtransform;
    set(hgx,'Matrix', makehgtform('zrotate',GMST0));
    set(globe,'Parent',hgx);
end

cdata = imread(earth);

end