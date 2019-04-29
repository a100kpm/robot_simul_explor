function Carte = murrr(Carte)

prompt = 'nombre de mur ?'
nbr_mur = input(prompt)
    figure
for i=1:nbr_mur
    imshow(Carte)
    prompt2 = 'direction ? N=1 W=2 S=3 E=4  '
    dir = input(prompt2)
    [x1,y1]=ginput(1)
    x1=round(x1)
    y1=round(y1)
    [x2,y2]=ginput(1)
    x2=round(x2)
    y2=round(y2)
    if dir ==1
        Carte(y2:y1,x1,:)=0;
    end
    if dir ==2
        Carte(y1,x2:x1,:)=0;
    end
    if dir ==3
        Carte(y1:y2,x1,:)=0;
    end
    if dir ==4
        Carte(y1,x1:x2,:)=0;
    end
end