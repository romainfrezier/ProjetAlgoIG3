# Remarques 

- Méthodes de calcul est une enum alors que ça pourrait juste être un bool puisque c'est une méthode ou une autre, on pourrait mettre un booléen estModeCalculClassique ou 2 fonctions

-> nous avons modifié

- Contenu case : 1 bool inutile, soit utiliser estBlanc soit estNoir

-> c'est pas faux non plus. Nous avons rajouté un commentaire expliquant que les variables sont mutuellement exclusives comme ça c'est bien clair qu'on ne peut avoir qu'une seule fois `true` pour les 3 variables du protocole.

- Nom TContenuCase confus

T veut dire Type. Le plateau est représenté par des cases. Chaque case a un contenu : blanc (une bille blanche), noir (une bille noire), inoccupé (aucune bille)

- Pourquoi 2 init dans Mabula puisque le joueur est toujours choisi aléatoirement, quelle est la différence ?

Pour avoir plus de choix dans le main, laisser la possibilité de choisir le premier joueur ou laisser au hasard. Donc la seule différence est que `init(estMethodeCalculPlusGrandGroupe: Bool, joueurActuel: Joueur)` ne choisit pas le premier joueur au hasard (utilise celui en paramètre), alors que `init(estMethodeCalculPlusGrandGroupe: Bool)` choisit le premier joueur au hasard.

Dans l'implémentation très probablement un init va appeler l'autre pour réutiliser le code.

- Pourquoi pouvoir calculer le score avec la méthode qui n'a pas été passé en paramètre puisque le principe de la passer en paramètre c'est de définir le mode de calcul ?

C'est la même chose que pour le joueur : cela permet de laisser plus de choix au programme main. Celle sans paramètre utilise la valeur passée en paramètre dans le init().

(et pour le calcul des scores ça a plus d'utilité : pour le joueur c'est soit on choisit soit au hasard, alors que pour les scores on pourrait afficher les deux scores en fonction de la méthode de calcul)

- On aurai pu eventuellement créer un protocol avec une structure de données et un itérateur pour pouvoir faire toutes les actions relatives au plateau de jeu

ContenuCaseCollection

- Pas de fonction pour récuperer tous les groupes de billes d'une couleur (ou des deux)

`func recupererGroupesBilles(joueur: Joueur) -> [ContenuCaseCollectionAssociatedT]`

- Pas de fonction pour récuperer le plus grand ensemble de billes et la personne a qui appartiennent ces billes

`func recupererPlusGrandGroupeBilles(joueur: Joueur) -> ContenuCaseCollectionAssociatedT`

- Pas besoin de xFin et yFin pour le déplacement puisqu'on peut se déplacer que sur un axe, autant remplacer ses variables par un int indiquant de combien de case on veut avancer la bille

On y a pensé aux deux méthodes (coordonnées début + fin ou coordonnées début + nombre de cases), et on s’est dit que ce serait plus simple de mettre les coordonnées début et fin. Mais du coup vu que vous préférez la méthode coordonnée début + nombre de cases on a changé comme vous voulez.

- Pareil pour déplacementPossible

Pareil.

- Fonction qui permet de verifier s'il y a des déplacements possibles pour un joueur

fait : `func peutJouer(joueur: Joueur) -> Bool` (on ne l’a pas appelé deplacementPossible car ça fait doublon avec le déplacement des billes)

- Fonction qui permet de verifier s'il y a des déplacements possibles pour les 2 joueurs

utilisez peutJouer(joueur: Joueur.blanc) && peutJouer(joueur: Joueur.noir)

- l'enum joueur n'est pas nécessaire

C'est vrai qu'on pourrait utiliser un booléen mais je trouve ça plus clair d'utiliser Joueur.noir ou Joueur.blanc que true ou false : on ne sait pas ce qu'est true ou false sans regarder la documentation.
