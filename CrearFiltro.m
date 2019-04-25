function [H]=CrearFiltro(W, Do, xv, yv)
    D = sqrt((xv.^2)+(yv.^2)); 
    H= 1./(1+(((D.*W)./(D.^2-(Do^2))).^2)); 
end