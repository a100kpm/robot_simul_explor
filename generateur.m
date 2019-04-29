clear all
close all
%% N=1;W=2;S=3;E=4;
% direction =1;
%% creation nouvelle carte
% A = randi([1,100],75,75);
% A(A<=90)=255;
% A(A>=91&A<=96)=128;
% A(A>=97&A<=100)=0;
% Carte=ones(size(A,1)+6,size(A,2)+6,3);
% Carte(4:end-3,4:end-3,1)=A;
% Carte(4:end-3,4:end-3,3)=A;
% Carte(Carte==128)=0;
% Carte(4:end-3,4:end-3,2)=A;
% figure(1)
% subplot(1,3,1)
% imshow(Carte)
% Carte=murrr(Carte);
%% creation nouvelle carte
%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%
% load Carte Carte
% load Carte2 Carte
% load Carte3 Carte
load Carte4 Carte
figure(1)
subplot(1,3,1)
imshow(Carte)
A = Carte(:,:,1);
AA = Carte(:,:,2);
AAA = Carte(:,:,3);
List=find(AA==128);
A(List)=255;
AA(List)=255;
AAA(List)=255;

List=find(AA==0);

taille = size(AA,1)*size(AA,2);
for i=1:length(List)
    pointeur = List(i);
    AA(pointeur-1)=0;
    AA(pointeur+1)=0;
    if pointeur>=size(AA,1)
        AA(pointeur-size(AA,1))=0;
    end
    if pointeur<=taille-size(AA,1)
        AA(pointeur+size(AA,1))=0;
    end
end


subplot(1,3,2)
% Carte_nav=zeros(size(A,1)+6,size(A,2)+6,3);%
Carte_nav=zeros(size(Carte,1),size(Carte,2),3);
% Carte_nav(4:end-3,4:end-3,1)=A;%
Carte_nav(4:end-3,4:end-3,1)=A(4:end-3,4:end-3,1);
% Carte_nav(4:end-3,4:end-3,3)=A;%
Carte_nav(4:end-3,4:end-3,3)=AAA(4:end-3,4:end-3);
% Carte_nav(:,:,2)=AA;%
Carte_nav(:,:,2)=AA;
imshow(Carte_nav)

Carte_explo=zeros(size(A,1),size(A,2),3);
Carte_explo(:,:,1)=255;
Carte_decision=zeros(size(A,1),size(A,2),2);
Carte_nav_dym=zeros(size(A,1),size(A,2),3);
Carte_nav_dym(:,:,1)=255;
Carte_nav_dym=zeros(size(A,1),size(A,2),2);
%% Sert à la décision de déplacement
prompt = 'direction ? N=1 W=2 S=3 E=4  ';
direction = input(prompt);
disp('choisir un point de départ')

[x,y] = ginput(1);
x=round(x);
y=round(y);
subplot(1,3,3)
imshow(Carte_explo)
[Carte_explo,Carte_decision]=scout2(x,y,direction,Carte_explo,Carte,Carte_decision);
imshow(Carte_explo);

subplot(1,3,2)
hold on
plot(x,y,'.r')
Carte_decision=envi(Carte_decision);

position_depart = [x,y];
position = [x,y]; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% première étape
if direction ==1
    y=y-1;
end
if direction ==3
    y=y+1;
end
if direction ==2
    x=x-1
end
if direction ==4
    x=x+1
end
position = [x,y];
[Carte_explo,Carte_decision]=scout(x,y,direction,Carte_explo,Carte,Carte_decision);
subplot(1,3,3)
imshow(Carte_explo)

subplot(1,3,2)
hold on
plot(x,y,'.r')
Carte_decision=envi(Carte_decision);
%% début de la partie automatisée
nombre_deplacement=0;
% [xd,yd] = choix(Carte_decision,Carte_nav,Carte,position,position_depart);%% mise aussi tôt ?
%% imo attendre le graph
suppr=[];

figure(2)
subplot(1,3,2)
Carte_nav_dym = update_carte_nav(Carte_explo);
imshow(Carte_nav_dym)
for GGG=531:1000
    figure(1)
    [pass_X,pass_Y] = pathss(x,y,Carte_explo,Carte_nav_dym,Carte_decision,Carte,position,position_depart,suppr);
    %     [pass_X,pass_Y,suppr] = pathss(x,y,Carte_explo,Carte_nav,Carte_decision,Carte,position,position_depart,suppr);
    autorise = 1;
    for i=1:length(pass_X)-1
        direction = detect_direction(x,y,pass_X(i+1),pass_Y(i+1));
        [Carte_explo,Carte_decision]=scout2(x,y,direction,Carte_explo,Carte,Carte_decision);
        Carte_nav_dym = update_carte_nav(Carte_explo);
        autorise = autorrize(autorise,pass_X(i+1),pass_Y(i+1),Carte_nav_dym);
        if autorise ==0
            subplot(1,3,2)
            hold on
            plot(x,y,'.r')
            drawnow
            
            subplot(1,3,3)
            imshow(Carte_explo)
            figure(2)
            subplot(1,3,2)
            imshow(Carte_nav_dym)
            position = [x,y];
            position_depart=(GGG*position_depart+position)/(GGG+1);
            break
        end
        x=pass_X(i+1);
        y=pass_Y(i+1);
        [Carte_explo,Carte_decision]=scout2(x,y,direction,Carte_explo,Carte,Carte_decision);
        
        %     pause()
        figure(1)
        subplot(1,3,2)
        hold on
        plot(x,y,'.r')
        nombre_deplacement=nombre_deplacement+1
        drawnow
        
        subplot(1,3,3)
        imshow(Carte_explo)
        figure(2)
        subplot(1,3,2)
        imshow(Carte_nav_dym)
        %     pause()
    end
    position = [x,y];
    position_depart=(GGG*position_depart+position)/(GGG+1);
    subplot(1,3,1)
    imshow(Carte)
    hold on
    plot(x,y,'xb')
    hold off
    Carte_decision=envi(Carte_decision);
    GGG
end

