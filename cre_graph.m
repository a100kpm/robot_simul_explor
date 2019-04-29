function graph = cre_graph(col,row,Carte_explo)

graph = zeros(length(col),length(col));

for i=1:length(col)
    for j=1:length(col)
        if abs(col(i)-col(j))+abs(row(i)-row(j))==1
            if (Carte_explo(col(i),row(i),2)==128) || (Carte_explo(col(j),row(j),2)==128)
                graph(i,j)=2;
            else
                graph(i,j)=1;
            end
        end
    end
end
