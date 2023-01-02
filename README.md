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
#### $~~~~~~~~~~~~~~~~~~~~$ **« Rien ne sert de courir, il faut partir à point ». ** 
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

sound(x,fe)
te=1/fe; %te: periode d echantillonnage
t = (0:length(x)-1) / fe;
plot(t,x)
xlabel('Temps (s)');
ylabel('x(t)');

```
![2](https://user-images.githubusercontent.com/106840796/210270921-fe7665ce-c183-4079-ab5f-be90ef1c23c3.PNG)
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
#### $~~~~~~$ **4-4- Tracez le signal en fonction des indices du vecteur x, puis essayez de repérer les indices de début et de fin de la phrase « Rien ne sert de ».** 
***
###### on peut convertir le son en texte avec la fonction speech2text(). Le texte est ensuite analysé à l'aide de la fonction find() pour repérer les indices de début et de fin de la phrase "rien ne sert de". Ces indices sont utilisés pour sélectionner la phrase dans le vecteur x du signal audio, qui est stocké dans le vecteur "rien_ne_sert_de".voici le code :
```matlab
%qst4

% Conversion du signal audio en texte
text = speech2text(x, fe);

% Détermination des indices de début et de fin de la phrase
start_index = find(text == 'rien', 1, 'first');
end_index = find(text == 'de', 1, 'last') + length('de') - 1;

% Sélection de la phrase dans le signal audio
rien_ne_sert_de =x(start_index:end_index)


```
![4](https://user-images.githubusercontent.com/106840796/210172766-ba59b83b-2c55-45ee-833b-b813e4dafd7b.PNG)
***
######Mais , cette fonction speech2text() necessite l intallation d audio toolbox sur matlab qu il faut acheter , mais j ai pas d argent , alors j ai essaye de choisir l intervalle correspondant a cette phrase "rien ne sert de " . voici le code :
```matlab


%qst4

rien_ne_sert_de = x(5055:77249);

```
 ### **Explication :**
 
 ###### xnoise est un bruit généré par la fonction randn() qui suit la loi gaussienne de moyenne 0 et d’écart type 1. 97% des valeurs générées par la fonction randn() se situent entre -3 (moyenne - 3* ecartType = 0-3*1=-3) et 3 (moyenne + 3* ecartType = 0+3*1=3).
 ###### Ainsi , on remarque l ajout des perturbations de haute frequence dans le spectre du signal bruité , c est le bruit .

***
$~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$ [ (Revenir au sommaire) ](#retour)
***
#### $~~~~~~$ **5 – Utiliser la commande sound pour écouter le signal et puis le signal bruité.** 
***
```matlab
% qst 5

sound(bruit,fe)
sound(xnoise,fe)

```
***
 ### **Explication :**
 ###### sound(xnoise , fe) envoie le signal audio y au haut-parleur à la fréquence d’échantillonnage donnée fe=10000hz , si on a pas inseré la fréquence d’échantillonnage ( sound(xnoise) ), elle sera par défaut egale a 8192 Hz.

***
$~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$ [ (Revenir au sommaire) ](#retour)
***
##### La puissance du signal en fonction de la fréquence (densité spectrale de puissance)est une métrique couramment utilisée en traitement du signal. Elle est définie comme étant le carré du module de la TFD, divisée par le nombre d'échantillons de fréquence.
***
#### $~~~~~~$ **6- Calculez puis tracer le spectre de puissance du signal bruité centré à la fréquence zéro.** 
***
```matlab
% qst 6

f =(0:N-1)*(fe/N); % f: frequence du spectre
y = fft(xnoise);     % y: spectre , fft(x) : transformee de fourier
spectreDePuissance=2.^abs(y)/N;
plot(f,spectreDePuissance); 
title('spectre de puissance du signal bruité :');

```
![6](https://user-images.githubusercontent.com/106840796/210170672-d51df29d-c132-44d4-b481-727677c5c320.PNG)
***
 ### **Explication :**
 ###### La spectre de puissance d'un signal est une mesure de la répartition de l'énergie du signal en fonction de la fréquence. Elle permet de visualiser la composition spectral d'un signal et de déterminer les fréquences présentes dans le signal.

***
$~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$ [ (Revenir au sommaire) ](#retour)
***

#### $~~~~~~$ **7- Augmenter l’intensité de bruit puis afficher le spectre. Interpréter le résultat obtenu.** 
***
```matlab
%qst 7

bruit_haute_intensite = 50*randn(size(x));
xnoise= x+bruit_haute_intensite;
subplot(1,2,1)
plot(bruit_haute_intensite)
title('bruit haute intensite');
subplot(1,2,2)
plot(fshift,fftshift(abs(fft(xnoise))));
title('spectre du signal bruité');

```
![7](https://user-images.githubusercontent.com/106840796/210172657-a91ec71a-780f-40a1-917d-186b483fcfa9.PNG)
***
 ### **Explication :**
 ###### xnoise est un bruit généré par la fonction randn() qui suit la loi gaussienne de moyenne 0 et d’écart type 1. 97% des valeurs générées par la fonction randn() se situent entre -3 (moyenne - 3* ecartType = 0-3*1=-3) et 3 (moyenne + 3* ecartType = 0+3*1=3), alors , on a multiplié par 50 pour augmenter l’intensité de bruit , maintenant , les valeurs générées se situent entre -150 et 150 .

***
$~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$ [ (Revenir au sommaire) ](#retour)
***
<a name="part2"></a>

### **2. Analyse fréquentielle du chant du rorqual bleu**
$~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$<a name="part2a"></a>
$~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$<a name="part2b"></a>
$~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$<a name="part2c"></a>
***
##### Il existe plusieurs signaux dont l’information est encodée dans des sinusoïdes. Les ondes sonores est un bon exemple. Considérons maintenant des données audios collectées à partir de microphones sous - marins au large de la Californie. On cherche à détecter à travers une analyse de Fourier le contenu fréquentiel d’une onde sonore émise pas un rorqual bleu.
***
#### $~~~~~~$ **1- Chargez, depuis le fichier ‘bluewhale.au’, le sous-ensemble de données qui correspond au chant du rorqual bleu du Pacifique. En effet, les appels de rorqual bleu sont des sons à basse fréquence, ils sont à peine audibles pour les humains. Utiliser la commande audioread pour lire le fichier.  Le son à récupérer correspond aux indices allant de 2.45e4 à 3.10e4.** 
***
```matlab
%qst 1

[x,fe]=audioread("bluewhale.au");
chant = x(2.45e4:3.10e4);


```

***
 ### **Explication :**
 ###### la commande audioread sert a lire le fichier "bluewhale.au" pour construire son signal chant qui correspond aux indices allant de 2.45e4 à 3.10e4 et la frequence fe .

***
$~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$ [ (Revenir au sommaire) ](#retour)
***
#### $~~~~~~$ **2- Ecoutez ce signal en utilisant la commande sound, puis visualisez-le.** 
***
```matlab
%qst 2

sound(chant,fe)
N = length(chant);
te = 1/fe;
t = (0:N-1)*(10*te);
plot(t,chant)
title('signal du chant du rorqual bleu :');

```
![part2 2](https://user-images.githubusercontent.com/106840796/210175084-9a5df19c-38fc-4246-b8c9-d72d3e132560.PNG)
***
 ### **Explication :**
 ###### sound(xnoise , fe) envoie le signal audio y au haut-parleur à sa fréquence d’échantillonnage fe .
 ###### on a compressé le signal en multipliant le temps par 10 en utilisant Matlab, mais cette technique ne fera que réduire la durée du signal, mais ne supprimera pas les données inutiles ou redondantes.

***
$~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$ [ (Revenir au sommaire) ](#retour)
***
##### La TFD peut être utilisée pour identifier les composantes fréquentielles de ce signal audio. Dans certaines applications qui traitent de grandes quantités de données avec fft, il est courant de redimensionner l'entrée de sorte que le nombre d'échantillons soit une puissance de 2. fft remplit automatiquement les données avec des zéros pour augmenter la taille de l'échantillon. Cela peut accélérer considérablement le calcul de la transformation.
***
#### $~~~~~~$ **3- Spécifiez une nouvelle longueur de signal qui sera une puissance de 2, puis tracer 
la densité spectrale de puissance du signal.** 
***
```matlab
%qst 3 

densite_spectrale= abs(fft(chant)).^2/N; 
f = (0:floor(N/2))*(fe/N)/10;
plot(f,densite_spectrale(1:floor(N/2)+1));
title('densité spectrale de puissance du signal:');

```
![qst3](https://user-images.githubusercontent.com/106840796/210177673-64f265b0-d0a3-46a4-99b5-70662aed39ce.PNG)
***
 ### **Explication :**
 ###### ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff

***
$~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$ [ (Revenir au sommaire) ](#retour)
***
#### $~~~~~~$ **4- Déterminer à partir du tracé, la fréquence fondamentale du gémissement de rorqual bleu.** 
***
```matlab
% qst 4

% Recherche de la fréquence fondamentale
[~, index] = max(densite_spectrale);
freqence_fondamentale = f(index)

```

***
 ### **Explication :**
 ###### d apres le tracé , la frequence fondamentale du gémissement est ensuite trouvée en cherchant la fréquence avec la valeur maximale dans le spectre de puissance qui est egale a 50hz .

***
$~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$ [ (Revenir au sommaire) ](#retour)
***

>## **Mariam Aboujenane**
>## **Filiere :** robotique et cobotique .
>## **Encadré par :** Pr. Ammour Alae .
