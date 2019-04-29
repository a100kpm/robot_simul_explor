function [pass_X,pass_Y,suppr] = pathss(x,y,Carte_explo,Carte_nav_dym,Carte_decision,Carte,position,position_depart,suppr)
% function [pass_X,pass_Y,suppr] = pathss(x,y,Carte_explo,Carte_nav,Carte_decision,Carte,position,position_depart,GGG,suppr)
% % la fonction n�cessite que l'on consid�re le point de d�part comme
% % explor� m�me si le robot ne peut techniquement pas l'avoir regard�

% % % avec la m�thode utilis�
% % % il faut faire manuellement le premier mouvement
% suppr=[]; %% imo il faut car�ment renvoyer suppr

% Carte_nav_dym = update_carte_nav(Carte_explo,Carte_nav_dym);

[col,row]=find((Carte_explo(:,:,2)~=0)&(Carte_nav_dym(:,:,2)~=0)); %% peut on enlever Carte_explo ici , %%

%% ensemble des points sur lesquels ont peut potentiellement se balader
%% appeler fonction qui cr�er un graph
% graph = cre_graph(col,row,Carte_explo);
graph = cre_graph(col,row,Carte_nav_dym);
%% appeler fonction qui choisit une destination (rajouter le non choix de point s�par�s -fait normalement-)

[xd,yd,ppoids1] = choix(Carte_decision,Carte_nav_dym,Carte,position,position_depart,graph,col,row,suppr);
% if isempty(xd)
[xd2,yd2,ppoids2] = choix3(Carte_decision,Carte_nav_dym,Carte,position,position_depart,graph,col,row,suppr);
% end
if isempty(xd)
    xd=xd2;
    yd=yd2;
else
    if ppoids1>10*ppoids2 %% si ppoids2==[], le test �choue et l'on a le bon point.
        xd=xd2;
        yd=yd2;
    end
end
%% appeler fonction qui fait dijkstra sur le graph

[pass_X,pass_Y]=dijkkstraat(graph,x,y,xd,yd,col,row);
erreur=0;
if length(pass_X)==1
    suppr=[suppr; yd,xd];
    while length(pass_X)==1
        [xd,yd,ppoids1] = choix(Carte_decision,Carte_nav_dym,Carte,position,position_depart,graph,col,row,suppr);
        [xd2,yd2,ppoids2] = choix3(Carte_decision,Carte_nav_dym,Carte,position,position_depart,graph,col,row,suppr);
        if isempty(xd)
            xd=xd2;
            yd=yd2;
        else
            if ppoids1>10*ppoids2 %% si ppoids2==[], le test �choue et l'on a le bon point.
                xd=xd2;
                yd=yd2;
            end
        end
        [pass_X,pass_Y]=dijkkstraat(graph,x,y,xd,yd,col,row)
        suppr=[suppr; yd,xd];
        erreur=erreur+1
    end
    
end
%
% pass_X=0;
% pass_Y=0;