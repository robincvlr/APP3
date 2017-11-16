%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Tutorat JI
%Robin Cavalieri
%Afaf Taik
%Zakaria Belgoum
%date : novembre 11/2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%----------------------------------------------------------
%Par Charles-Antoine Brunet
% Un JI doit �tre un module afin d'�viter les conflits de noms entre les JI.
:- module(p12,[p12_nom/1,p12_auteurs/1,p12_reset/0,p12_plan/1,p12_action/2]).
%----------------------------------------------------------

%----------------------------------------------------------
%Pr�dicats du jeu
%----------------------------------------------------------
%Pr�dicat de nom : p12_nom(-Nom).
p12_nom('Joueur 12').

%Pr�dicat d'auteurs : p12_auteurs(-Auteurs).
p12_auteurs('Afaf - Robin - Zakaria').

%Pr�dicat de remise � z�ro : p12_reset.
p12_reset :- planInitial(P), setPlan(P).

%Pr�dicat du plan : p12_plan(-PlanCourant).
p12_plan(Plan) :- getPlan(Plan).

%Pr�dicat d'action : p12_action(+Etat,-Action).
p12_action(Etat,Action) :- trouveAction(Etat, Action).
%----------------------------------------------------------

%----------------------------------------------------------
%Pr�dicats interne de plan
%----------------------------------------------------------
%Plan d�clar� en dynamique car il peut changer au cours du temps
:- dynamic([planRestant/1]).

%Plan Initial r�gissant les mouvements effectu�s
planInitial([move(1),move(2),move(3),move(4)]).

%R�cup�ration du plan de jeu actuel
getPlan(Plan) :- with_mutex(p12,planRestant(Plan)).

%Update du plan de jeu
setPlan(Plan) :- with_mutex(p12,changePlan(Plan)).

% Modification du plan de jeu � partir de retractall(Supprime les
% donn�es pr�c�dentes et les remplace)
changePlan(Plan) :- retractall(planRestant(_)), assert(planRestant(Plan)).
%----------------------------------------------------------

%----------------------------------------------------------
%Actions possibles � effectuer
%Par Robin Cavalieri
%----------------------------------------------------------
%Monter
bouger(mov_monter).
%Descendre
bouger(mov_descendre).
%Gauche
bouger(mov_gauche).
%Droite
bouger(mov_droite).
%Diagonale haute droite
bouger(mov_DHdroite).
%Diagonale haute gauche
bouger(mov_DHgauche).
%Diagonale bas droite
bouger(mov_DBdroite).
%Diagonale bas gauche
bouger(mov_DBgauche).

%Prendre
prendre(p_haut).    %haut
prendre(p_bas).     %bas
prendre(p_gauche).  %gauche
prendre(p_droite).  %droite
prendre(p_DHdroite).%diagonale haut droit
prendre(p_DHgauche).%diagonale haut gauche
prendre(p_DBdroite).%diagonale bas droit
prendre(p_DBgauche).%diagonale bas gauche

%Droper
drop(d_haut).     %haut
drop(d_bas).      %bas
drop(d_gauche).   %gauche
drop(d_droite).   %droite
drop(d_DHdroite). %diagonale haut droit
drop(d_DHgauche). %diagonale haut gauche
drop(d_DBdroite). %diagonale bas droit
drop(d_DBgauche). %diagonale bas gauche

%Passer
passer().
%----------------------------------------------------------


%-----------------------------------------------------------------------------
% Pr�dicats internes d'action |A MODIFIER POUR OPTIMISER L'ACTION|
%-----------------------------------------------------------------------------
% Calcul de la prochaine action du JI. Ce JI ne fera jamais rien de bon...
%-----------------------------------------------------------------------------
trouveAction(EtatJeu, ProchaineAction) :- getPlan([ProchaineAction]), !, planInitial(P), setPlan(P).
trouveAction(EtatJeu, ProchaineAction) :- getPlan([ProchaineAction|PlanRestant]), setPlan(PlanRestant).
%-----------------------------------------------------------------------------













