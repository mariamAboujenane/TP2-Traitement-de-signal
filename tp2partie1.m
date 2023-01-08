clear all
close all
clc

%qst1

[signal,fe]=audioread('phrase.wave');

%qst2

% sound(signal,fe)
% te=1/fe; %te: periode d echantillonnage
% t = (0:length(signal)-1) / fe;
% plot(t,signal)
% xlabel('Temps (s)');
% ylabel('signal(t)');

%qst3

% sound(x,2*fe); %Donald Duck
% sound(x,fe/2); %Terminator

%qst4

%Tracez le signal en fonction des indices

% plot(signal);
% xlabel('indices');
% title('signal')

% Trouver les indices du vecteur "rien ne sert de" dans le signal
rien_ne_sert_de_indice_debut = 5000;
rien_ne_sert_de_indice_fin = 100000;

%qst 5 

% rien_ne_sert_de=signal(rien_ne_sert_de_indice_debut:rien_ne_sert_de_indice_fin);
% 
% % ecouter le vecteur "rien ne sert de"
% 
%  sound(rien_ne_sert_de,fe)
% 
% %Tracez le vecteur "rien ne sert de" en fonction des indices
% 
% plot(rien_ne_sert_de);
% xlabel('indices');
% title('rien ne sert de')

%qst 6

% Trouver les indices du vecteur "courir" dans le signal
courir_indice_debut = 100000;
courir_indice_fin = 120000;
courir=signal(courir_indice_debut:courir_indice_fin);
%sound(courir,fe)

% Trouver les indices du vecteur "il faut" dans le signal
il_faut_indice_debut = 120000;
il_faut_indice_fin = 160000;
 il_faut=signal(il_faut_indice_debut:il_faut_indice_fin);
% sound(il_faut,fe)

% Trouver les indices du vecteur "partir a point" dans le signal
partir_a_point_indice_debut = 160000;
partir_a_point_indice_fin = 217000;
partir_a_point=signal(partir_a_point_indice_debut:partir_a_point_indice_fin);
%sound(partir_a_point,fe)

%qst 7

% reconstitution_signal =[rien_ne_sert_de;partir_a_point;il_faut;courir];
% sound(reconstitution_signal,fe);


