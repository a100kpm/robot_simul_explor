function Carte_decision = envi(Carte_decision)

% List=find(Carte_decision(:,:,1)==1);

h = [ 0 , 1 , 0 ; 1 , 0 , 1 ; 0 , 1 , 0 ];
BBB=imfilter(Carte_decision(:,:,1),h);
BBB(BBB==1)=0;
Carte_decision(:,:,2)=BBB;
