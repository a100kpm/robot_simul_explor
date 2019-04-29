function direction = detect_direction(x,y,x_suiv,y_suiv)

if y_suiv<y
    direction = 1;
end

if y_suiv>y
    direction = 3;
end

if x_suiv<x
    direction = 2;
end

if x_suiv>x
    direction = 4;
end