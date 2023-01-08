 # $~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$ **TP2 - Jeux de mots** 
## $~~~~~~~~~~~~~~~~~~~~$ Synthèse et analyse spectrale d’une gamme de musique
***
<a name="retour"></a>
## Sommaire :
1. [ Jeux de mots ](#part1)
2. [ Synthèse et analyse spectrale d’une gamme de musique ](#part2)
###### $~~~~~~~~~~~~~~~~~~~~$[ - Synthèse d’une gamme de musique ](#part2a)
###### $~~~~~~~~~~~~~~~~~~~~$[ - Spectre de la gamme de musique ](#part2b)
###### $~~~~~~~~~~~~~~~~~~~~$[ - Approximation du spectre d’un signal sinusoïdal à temps continu par FFT ](#part2c)
***
<a name="part1"></a>
### **1. Jeux de mots:**
***

« phrase.wave » est un fichier audio enregistré à l’aide d’un smartphone, en 
prononçant lentement la phrase : 
#### $~~~~~~~~~~~~~~~~~~~~$ **« Rien ne sert de courir, il faut partir à point ».** 
#### $~~~~~~$ **1- Sauvegardez ce fichier sur votre répertoire de travail, puis charger-le dans MATLAB à l’aide de la commande « audioread ».** 
***
```matlab
%qst1

[x,fe]=audioread('phrase.wave');

```
***
 ### **Explication :**
 ###### la fonction audioread() retourne les données audio sous forme de vecteur, ainsi que la fréquence d'échantillonnage du fichier audio.
***
#### $~~~~~~$ **2- Tracez le signal enregistré en fonction du temps, puis écoutez-le en utilisant la commande « sound ».** 
***
```matlab
%qst2

sound(signal,fe)
te=1/fe; %te: periode d echantillonnage
t = (0:length(signal)-1) / fe;
plot(t,signal)
xlabel('Temps (s)');
ylabel('signal(t)');


```
![qst2](https://user-images.githubusercontent.com/106840796/211190408-c75b6159-5c78-4874-a3e6-c56ba6e6cf86.PNG)
***
 ### **Explication :**
 ###### Ce code crée des vecteurs de temps et d'amplitude en utilisant la fréquence d'échantillonnage fe, puis tracer le signal audio en utilisant la fonction plot(). Le signal audio est affiché en fonction du temps, avec l'amplitude du signal sur l'axe des ordonnées et le temps sur l'axe des abscisses.

***
#### $~~~~~~$ **3- Cette commande permet d’écouter la phrase à sa fréquence d’échantillonnage d’enregistrement. Ecoutez la phrase en modifiant la fréquence d’échantillonnage à double ou deux fois plus petite pour vous faire parler comme « Terminator » ou « Donald Duck ». En effet, modifier la fréquence d’échantillonnage revient à appliquer un changement d’échelle y(t) = x(at) en fonction de la valeur du facteur d’échelle, cela revient à opérer une compression ou une dilatation du spectre initial d’où la version plus grave ou plus aigüe du signal écouté.** 
***
```matlab
%qst3

sound(x,2*fe); %Donald Duck
sound(x,fe/2); %Terminator


```
***
 ### **Explication :**
 ###### La compression du spectre consiste à réduire l'écart entre les fréquences les plus hautes et les plus basses du signal, tandis que la dilatation du spectre consiste à augmenter cet écart. Si le spectre est comprimé, les fréquences les plus hautes et les plus basses du signal seront plus proches l'une de l'autre, ce qui peut entraîner une version plus grave du signal. Si le spectre est dilaté, les fréquences les plus hautes et les plus basses seront plus éloignées l'une de l'autre, ce qui peut entraîner une version plus aigüe du signal.

***
$~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$ [ (Revenir au sommaire) ](#retour)
***
#### $~~~~~~$ **4- Tracez le signal en fonction des indices du vecteur x, puis essayez de repérer les indices de début et de fin de la phrase « Rien ne sert de ».** 
***
###### on peut convertir le son en texte avec la fonction speech2text(). Le texte est ensuite analysé à l'aide de la fonction find() pour repérer les indices de début et de fin de la phrase "rien ne sert de". Ces indices sont utilisés pour sélectionner la phrase dans le vecteur x du signal audio, qui est stocké dans le vecteur "rien_ne_sert_de".voici le code :
```matlab
%qst4

%Tracez le signal en fonction des indices

plot(signal);
xlabel('indices');
title('signal')

% Trouver les indices du vecteur "rien ne sert de" dans le signal
rien_ne_sert_de_indice_debut = 5000;
rien_ne_sert_de_indice_fin = 100000;


```
![qst4](https://user-images.githubusercontent.com/106840796/211190467-3cbc5381-7ac1-4f2e-97d8-984f6f6a4db2.PNG)
***
 ### **Explication :**
 
 ###### plot(signal) sert de tracer le signal en fonction des indices et non pas en fonction de temps, alors on peut maintenant clairement visualiser les mots constituant le signal .
 ###### Alors , pour detecter la phrase "rien ne sert de" , il faut prendre l indice de debut du mot "rien" et l indice de fin du mot "de" pour construire l intervalle des indices du vecteur "rien ne sert de" .

***
$~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$ [ (Revenir au sommaire) ](#retour)
***
#### $~~~~~~$ **5- Pour segmenter le premier mot, il faut par exemple créer un vecteur « riennesertde » contenant les n premières valeurs du signal enregistré x qui correspondent à ce morceau. Créez ce vecteur, puis écoutez le mot segmenté.** 
***
```matlab
%qst 5 

rien_ne_sert_de=signal(rien_ne_sert_de_indice_debut:rien_ne_sert_de_indice_fin);

% ecouter le vecteur "rien ne sert de"

 sound(rien_ne_sert_de,fe)

%Tracez le vecteur "rien ne sert de" en fonction des indices

plot(rien_ne_sert_de);
xlabel('indices');
title('rien ne sert de')
```
***
 ### **Explication :**
 ###### sound(rien_ne_sert_de,fe) envoie le signal audio y au haut-parleur à la fréquence d’échantillonnage  fe , puis , plot(rien_ne_sert_de); pour tracer le vecteur "rien ne sert de" en fonction des indices , on peut clairement voir les 4 mots qui contituent ce vecteur a partir des pics.

***
$~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$ [ (Revenir au sommaire) ](#retour)
***
#### $~~~~~~$ **6- Segmentez cette fois-ci toute la phrase en créant les variables suivantes : riennesertde, courir, ilfaut, partirapoint.** 
***
```matlab
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

```
***
 ### **Explication :**
 ###### de la meme maniere , on peut detecter facilement les autres vecteurs a partir des pics .

***
$~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$ [ (Revenir au sommaire) ](#retour)
***

#### $~~~~~~$ **7- Notez que le signal initial de parole est un vecteur colonne contenant un certain nombre de valeurs (length(x)). Réarrangez ce vecteur pour écouter la phrase synthétisée « Rien ne sert de partir à point, il faut courir ».** 
***
```matlab
%qst 7

reconstitution_signal =[rien_ne_sert_de;partir_a_point;il_faut;courir];
sound(reconstitution_signal,fe);

```
***
 ### **Explication :**
 ###### on peut rearranger le vecteur initial pour ecouter differentes phrases en creant un vecteur colonne constituant des vecteurs du signal decomposés . 

***
$~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$ [ (Revenir au sommaire) ](#retour)
***
<a name="part2"></a>

### **2. Analyse fréquentielle du chant du rorqual bleu**
$~~~~~~~~~~~~~~~~~~~~~~$<a name="part2a"></a>
### $~~~~~~~~~~~~~~~~~~~~~~$ **- Synthèse d’une gamme de musique**

##### Les notes de musique produites par un piano peuvent être synthétisées approximativement numériquement. En effet, chaque note peut être considérée comme étant un son pur produit par un signal sinusoïdal. La fréquence de la note « La » est par exemple de 440 Hz.
***
#### $~~~~~~$ **1- Créez un programme qui permet de jouer une gamme de musique. La fréquence de chaque note est précisée dans le tableau ci-dessous. Chaque note aura une durée de 1s. La durée de la gamme sera donc de 8s. La fréquence d’échantillonnage fe sera fixée à 8192 Hz.** 
***
![tab](https://user-images.githubusercontent.com/106840796/211191126-9fded348-e722-4760-adf3-f569500a6b9a.PNG)
```matlab
%qst 1

 m_Fs=8192;
 Ts=1/m_Fs;
 t=[0:Ts:1];

 
 F_dol=262;
 F_re=294;
 F_m=330;
 F_fa=349;
 F_sol=392;
 F_si=494;
 F_do2=523;
 F_la=440;

 Dol=sin(2*pi*F_dol*t); 
 re=sin(2*pi*F_re*t);
 mi=sin(2*pi*F_m*t);
 fa=sin(2*pi*F_fa*t);
 so=sin(2*pi*F_sol*t);
 la=sin(2*pi*F_la*t);
 si=sin(2*pi*F_si*t);
 do=sin(2*pi*F_do2*t);

gamme_de_musique= [Dol,re,mi,fa,so,la,si,do];
sound(gamme_de_musique,m_Fs);


```

***
 ### **Explication :**
 ###### le vecteur"gamme_De_musique" est une gamme de musique constituee de 8 notes qui sont representées comme des signaux sinusoidaux avec leurs frequences correspondantes . 

***
$~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$ [ (Revenir au sommaire) ](#retour)
***
$~~~~~~~~~~~~~~~~~~~~~~$<a name="part2b"></a>
### $~~~~~~~~~~~~~~~~~~~~~~$ **- Spectre de la gamme de musique**
#### $~~~~~~$ **2- Utilisez l’outil graphique d’analyse de signaux signalAnalyzer pour visualiser le spectre de votre gamme. Observez les 8 fréquences contenues dans la gamme et vérifiez leur valeur numérique à l’aide des curseurs.** 
***
 ###### Le Signal Analyzer est un outil de visualisation de signal dans MATLAB. Il permet de visualiser et d'analyser des signaux numériques en utilisant diverses techniques d'analyse, telles que la transformée de Fourier, la décomposition en ondelettes, l'analyse de corrélation, etc.

***
$~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$ [ (Revenir au sommaire) ](#retour)
***

#### $~~~~~~$ **3- Tracez le spectrogramme qui permet de visualiser le contenu fréquentiel du signal au cours du temps (comme le fait une partition de musique) mais la précision sur l’axe des fréquences n’est pas suffisante pour relever précisément les 8 fréquences.** 
***
![part2](https://user-images.githubusercontent.com/106840796/211198550-0bae4f2b-dcf2-4a28-a112-03d78a77734d.PNG)
***
$~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$ [ (Revenir au sommaire) ](#retour)
***
$~~~~~~~~~~~~~~~~~~~~~~$<a name="part2c"></a>
### $~~~~~~~~~~~~~~~~~~~~~~$ **- Approximation du spectre d’un signal sinusoïdal à temps continu par FFT**
#### $~~~~~~$ **4- Le spectre d’un signal à temps continu peut être approché par transformée de Fourier discrète (TFD) ou sa version rapide (Fast Fourier Transform (FFT). Afficher le spectre de fréquence de la gamme musicale crée en échelle linéaire, puis avec une échelle en décibels.** 
![4](https://user-images.githubusercontent.com/106840796/211198688-5929ba5e-b764-4ea7-9885-43b6630841d3.PNG)
***
```matlab
%qst 4

%tracer le spectre en echelle lineaire
spectre_lineaire=abs(fft(gamme_de_musique));
subplot(2,1,1);
fshift=(-length(gamme_de_musique)/2:length(gamme_de_musique)/2 -1 )*m_Fs/length(gamme_de_musique);
plot(fshift,fftshift(spectre_lineaire));
title('spectre en échelle linéaire');

%tracer le spectre en echelle en decibels
subplot(2,1,2);
spectre_db = 20 * log10(spectre_lineaire); % convertion en dB
plot(fshift,fftshift(spectre_db));
title(' spectre en échelle en décibels');

```
![5](https://user-images.githubusercontent.com/106840796/211199372-01bfdf0b-fb8e-4b24-8c07-22221349967c.PNG)
***
 ### **Explication :**
 ###### L'échelle en décibels (dB) est une échelle logarithmique utilisée pour mesurer le niveau de puissance d'un signal. En revanche, l'échelle linéaire est une échelle qui représente les valeurs d'un signal de manière proportionnelle, sans utiliser de transformation logarithmique.

***
$~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$ [ (Revenir au sommaire) ](#retour)
***

>## **Mariam Aboujenane**
>## **Filiere :** robotique et cobotique .
>## **Encadré par :** Pr. Ammour Alae .
