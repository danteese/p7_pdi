function [filter] = notchFilter(density, u0, v0, u, v, n)

    % This function creates the notch filter with the given values:
    %   (Consider polar)
    %   density: how big the circle would be
    %   u0: Distance 
    %   v0: Angle

    D0 = density;
    D1 = (((u-u0).^2) + ((v-v0).^2)).^(1/2);
    D2 = (((u+u0).^2) + ((v+v0).^2)).^(1/2);

    filter = 1./(1+(((D0.^2)./(D1.*D2)).^n));

end

