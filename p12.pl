%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Tutorat JI
%Robin Cavalieri
%Afaf Taik
%Zakaria Belgoum
%date : novembre 11/2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%----------------------------------------------------------
%Par Charles-Antoine Brunet
% Un JI doit être un module afin d'éviter les conflits de noms entre les JI.
:- module(p12,[p12_nom/1,p12_auteurs/1,p12_reset/0,p12_plan/1,p12_action/2]).
%----------------------------------------------------------

%----------------------------------------------------------
%Prédicats du jeu
%----------------------------------------------------------
%Prédicat de nom : p12_nom(-Nom).
p12_nom('Joueur 12').

%Prédicat d'auteurs : p12_auteurs(-Auteurs).
p12_auteurs('Afaf - Robin - Zakaria').

%Prédicat de remise à zéro : p12_reset.
p12_reset :- planInitial(P), setPlan(P).

%Prédicat du plan : p12_plan(-PlanCourant).
p12_plan(Plan) :- getPlan(Plan).

%Prédicat d'action : p12_action(+Etat,-Action).
p12_action(Etat,Action) :- trouveAction(Etat, Action).
%----------------------------------------------------------

%----------------------------------------------------------
%Prédicats interne de plan
%----------------------------------------------------------
%Plan déclaré en dynamique car il peut changer au cours du temps
:- dynamic([planRestant/1]).

%Plan Initial régissant les mouvements effectués
planInitial([move(1),move(2),move(3),move(4)]).

%Récupération du plan de jeu actuel
getPlan(Plan) :- with_mutex(p12,planRestant(Plan)).

%Update du plan de jeu
setPlan(Plan) :- with_mutex(p12,changePlan(Plan)).

% Modification du plan de jeu à partir de retractall(Supprime les
% données précédentes et les remplace)
changePlan(Plan) :- retractall(planRestant(_)), assert(planRestant(Plan)).
%----------------------------------------------------------

%----------------------------------------------------------
%Actions possibles à effectuer
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
% Prédicats internes d'action |A MODIFIER POUR OPTIMISER L'ACTION|
%-----------------------------------------------------------------------------
% Calcul de la prochaine action du JI. Ce JI ne fera jamais rien de bon...
%-----------------------------------------------------------------------------
trouveAction(EtatJeu, ProchaineAction) :- getPlan([ProchaineAction]), !, planInitial(P), setPlan(P).
trouveAction(EtatJeu, ProchaineAction) :- getPlan([ProchaineAction|PlanRestant]), setPlan(PlanRestant).
%-----------------------------------------------------------------------------













