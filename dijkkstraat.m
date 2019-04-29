function [pass_X,pass_Y]=dijkkstraat(graph,x,y,xd,yd,col,row)

[C,pos_deb,ib] = intersect([col,row],[y,x],'rows');
[C,pos_fin,ib] = intersect([col,row],[yd,xd],'rows');
pass_X=xd;
pass_Y=yd;
Table_traitement=zeros(length(col),1);

Table_retenu=zeros(length(col),length(col));

Elem=[col,row];

% deb=Elem(pos_deb,:);
% fin=Elem(pos_fin,:);

Table_traitement(pos_deb)=pos_deb;
Table_retenu(pos_deb,:)=graph(pos_deb,:);
next_min=0;
F=15; %% facteur de trop lent

dist=disstance_rapide(xd,yd,x,y);

while Table_traitement(pos_fin)==0
    if next_min>F*dist
        return
    end
    next_=min(Table_retenu(Table_retenu>next_min));
    if isempty(next_)
        return
    end
    [rown,coln]=find(Table_retenu==next_);
    c = setdiff(coln,Table_traitement);
    if isempty(c)
        next_min=next_;
    else
        addition=graph(c(1),:);
        addition(addition>0)=addition(addition>0)+next_;
        Table_retenu(c(1),:)=addition;
        Table_traitement(c(1))=c(1);
    end

end

%%Table_retenu
%%Table_traitement
if next_min>F*dist
    return
end
rown = pos_fin;
if isempty(next_)
    return
else
    while Table_traitement(pos_deb)~=0
        mat_temp=Table_retenu(:,rown);
        prec=min(mat_temp(mat_temp>0));
        [rown,~]=find(mat_temp==prec);
        c = intersect(rown,Table_traitement);
        if isempty(c)
            Table_traitement(pos_deb)=0;
        else
            rown=c(1);
            pass_X=[row(rown) , pass_X];
            pass_Y=[col(rown) , pass_Y];
            Table_traitement(rown)=0;
        end
    end
end