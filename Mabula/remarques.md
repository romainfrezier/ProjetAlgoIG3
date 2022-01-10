# Remarques 

## Anciens commentaires (commentaires sur la période entre spécif et dev)

- Méthodes de calcul est une enum alors que ça pourrait juste être un bool puisque c'est une méthode ou une autre, on pourrait mettre un booléen estModeCalculClassique ou 2 fonctions

- Contenu case : 1 bool inutile, soit utiliser estBlanc soit estNoir

- Nom TContenuCase confus

- Pourquoi 2 init dans Mabula puisque le joueur est toujours choisi aléatoirement, quelle est la différence ?

- Pourquoi pouvoir calculer le score avec la méthode qui n'a pas été passé en paramètre puisque le principe de la passer en paramètre c'est de définir le mode de calcul ?

- On aurai pu eventuellement créer un protocol avec une structure de données et un itérateur pour pouvoir faire toutes les actions relatives au plateau de jeu

- Pas de fonction pour récuperer tous les groupes de billes d'une couleur (ou des deux)

- Pas de fonction pour récuperer le plus grand ensemble de billes et la personne a qui appartiennent ces billes

- Pas besoin de xFin et yFin pour le déplacement puisqu'on peut se déplacer que sur un axe, autant remplacer ses variables par un int indiquant de combien de case on veut avancer la bille

- Pareil pour déplacementPossible

- Fonction qui permet de verifier s'il y a des déplacements possibles pour un joueur

- Fonction qui permet de verifier s'il y a des déplacements possibles pour les 2 joueurs

- l'enum joueur n'est pas nécessaire

## Nouveaux commentaires (commentaires sur la période de développement)

- pas d'init dans TContenuCase avec param x,y

- ContenuCaseCollection : protocol inutile, ça aurait du servir pour faire le plateau, ou programmé différement pour pouvoir faire soit un plateau soit une liste, sachant que la fonction ajouter limite la dimension de la collection et est inutilisable dans une autre dimension

- recupererContenuCase(x: Int, y: Int) -> ContenuCase renvoie ContenuCase alors qu'il devrait renvoyer ContenuCase?

- Oubli du cas principal de vérification dans peutJouer, a savoir le cas ou on a une bille sur le bord mais ou on ne peut pas jouer

- recupererPlusGrandGroupeBilles(joueur: Joueur) -> ContenuCaseCollection pourquoi renvoyer une collection quand on a juste besoin d'un Int

- recupererGroupesBilles(joueur: Joueur) -> [ContenuCaseCollection] pourquoi un tableau de collection quand on a besoin que d'un tableau d'int

- (vérifier s'il n'y a pas de blocage par rapport aux 2 implémentations de contenucasecollection)

- redondance de code a cause des deux booléens estNoir et estBlanc

- renvoyer un itératorProtocol pour etre générique et ne pas forcer un nom de type

- getContenuCase doit renvoyer ContenuCase? et pas ContenuCase

- affichage non commode pour l'utilisateur, et affichage a l'envers (inversion x,y)

- Ajout au main de ne pouvoir jouer que les billes qui nous appartiennent