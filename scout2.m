function [Carte_explo,Carte_decision]=scout2(x,y,direction,Carte_explo,Carte,Carte_decision)
%% explore puis donne des valeurs pour l'exploration.
K=1;
ligne = size(Carte_explo,1);
colonne = size(Carte_explo,2);
if direction ==1
    Carte_explo(y-1,x-1:x+1,:)=Carte(y-1,x-1:x+1,:);
    Carte_decision(y-1,x-1:x+1,1)=ones(1,3)*K;
    if Carte(y-1,x,2)==255 || Carte(y-1,x,2)==128
        Carte_explo(y-2,x-1:x+1,:)=Carte(y-2,x-1:x+1,:);
        Carte_decision(y-2,x-1:x+1,1)=ones(1,3)*K;
    end
end
if direction ==2
    Carte_explo(y-1:y+1,x-1,:)=Carte(y-1:y+1,x-1,:);
    Carte_decision(y-1:y+1,x-1,1)=ones(3,1)*K;
    if Carte(y,x-1,2)==255 || Carte(y,x-1,2)==128
        Carte_explo(y-1:y+1,x-2,:)=Carte(y-1:y+1,x-2,:);
        Carte_decision(y-1:y+1,x-2,1)=ones(3,1)*K;
    end
end
if direction ==3
    Carte_explo(y+1,x-1:x+1,:)=Carte(y+1,x-1:x+1,:);
    Carte_decision(y+1,x-1:x+1,1)=ones(1,3)*K;
    if Carte(y+1,x,2)==255 || Carte(y+1,x,2)==128
        Carte_explo(y+2,x-1:x+1,:)=Carte(y+2,x-1:x+1,:);
        Carte_decision(y+2,x-1:x+1,1)=ones(1,3)*K;
    end
end
if direction ==4
    Carte_explo(y-1:y+1,x+1,:)=Carte(y-1:y+1,x+1,:);
    Carte_decision(y-1:y+1,x+1,1)=ones(3,1)*K;
    if Carte(y,x+1,2)==255 || Carte(y,x+1,2)==128
        Carte_explo(y-1:y+1,x+2,:)=Carte(y-1:y+1,x+2,:);
        Carte_decision(y-1:y+1,x+2,1)=ones(3,1)*K;
    end
end

