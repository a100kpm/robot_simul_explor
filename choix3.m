function [xd,yd,ppoids2] = choix3(Carte_decision,Carte_nav,Carte,position,position_depart,graph,col,row,suppr)
%%% il faudra revenir dessus (suppression de point interdit -fait, mais ptet qc d'autre a revoir-)
%% (éventuellement supprimer les points fully explores)
% %  risque d'arrêt prématuré
BBB=Carte_decision(:,:,2); %%90-94
[col2,row2]=find(BBB==3);
% ratio=zeros(length(row2),1);
x=position(1);
y=position(2);
% %  risque d'arrêt prématuré
%% zone a optimiser !!!!!!!
ignore = [];
for i=1:length(row)
    if graph(i,:)==0
        ignore=[ ignore ; col(i) , row(i) ];
    end
end
ignore = [ignore ; y , x ]; %%%%% ????? peut être a enlever
ignore = [ignore ; suppr ]; %%%%% ????? peut être a enlever (mastic)
%% zone a optimiser !!!!!!!
%%%%% a revoir éventuellement !!!!!!!!!!!!!!!!!!!!!!!!!!!!!

% for i=1:length(row2)
%     if Carte_nav(row2(i),col2(i),2)==255
%     eloigne=abs(row2(i)-position_depart(2))+abs(col2(i)-position_depart(1));
%     but=abs(row2(i)-position(2))+abs(col2(i)-position(1));
%     ratio(i)=but/eloigne;
%     end
% end
% choix=find(ratio==max(ratio),1);
%%%%%% a revoir éventuellement !!!!!!!!!!!!!!!!!!!!!!!!!!!!!
AA=[col,row];
BB=[col2,row2];
c = intersect(AA, BB, 'rows');
% if ignore~=[]
if ~isempty(ignore)
    c = setdiff(c,ignore,'rows');
end
ratio=zeros(size(c,1),1);
for i=1:size(c,1)
    if Carte_nav(c(i,1),c(i,2),2)==255
        eloigne=abs(c(i,1)-position_depart(2))+abs(c(i,2)-position_depart(1));
        but=abs(c(i,1)-position(2))+abs(c(i,2)-position(1));
                ratio(i)=but/(eloigne); %%%%%%%%%%%

    end
end
if ~isempty(ratio(ratio>0))
    choixx=find(ratio==min(ratio(ratio>0)),1);
    yd=c(choixx,1);
    xd=c(choixx,2);
else
    xd=[];
    yd=[];
end
ppoids2=min(ratio(ratio>0));