function Carte_nav_dym = update_carte_nav(Carte_explo)

List1=find(Carte_explo(:,:,1)==0);
List2=find(Carte_explo(:,:,2)==0);
C = intersect(List1,List2);
A=Carte_explo(:,:,1);
AA=Carte_explo(:,:,2);


for i=1:length(C)
    pointeur = C(i);
    AA(pointeur-1)=0;
    AA(pointeur+1)=0;
    AA(pointeur-size(AA,1))=0;
    AA(pointeur+size(AA,1))=0;
    A(pointeur-1)=255;
    A(pointeur+1)=255;
    A(pointeur-size(AA,1))=255;
    A(pointeur+size(AA,1))=255;
end
Carte_nav_dym=Carte_explo;
Carte_nav_dym(:,:,1)=A;
Carte_nav_dym(:,:,2)=AA;
Carte_nav_dym(:,:,3)=A;
