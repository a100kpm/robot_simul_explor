function [Carte_explo,Carte_decision]=scout(x,y,direction,Carte_explo,Carte,Carte_decision)
%% explore puis donne des valeurs pour l'exploration.
K=1;
ligne = size(Carte_explo,1);
colonne = size(Carte_explo,2);
if direction ==1
    Carte_explo(y-2:y-1,x-1:x+1,:)=Carte(y-2:y-1,x-1:x+1,:);
    Carte_decision(y-2:y-1,x-1:x+1,1)=ones(2,3)*K;
end
if direction ==2
    Carte_explo(y-1:y+1,x-2:x-1,:)=Carte(y-1:y+1,x-2:x-1,:);
    Carte_decision(y-1:y+1,x-2:x-1,1)=ones(3,2)*K;
end
if direction ==3
    Carte_explo(y+1:y+2,x-1:x+1,:)=Carte(y+1:y+2,x-1:x+1,:);
    Carte_decision(y+1:y+2,x-1:x+1,1)=ones(2,3)*K;
end
if direction ==4
    Carte_explo(y-1:y+1,x+1:x+2,:)=Carte(y-1:y+1,x+1:x+2,:);
    Carte_decision(y-1:y+1,x+1:x+2,1)=ones(3,2)*K;
end

