# Remarques

---
```
quartoProtocol

resetGame()
pas utilisé dans main
-> après discussion, utilisée par finPartie() MAIS ->

// finPartie : quartoProtocol x Bool -> quartoProtocol
// Fonction qui met un terme a la partie, elle indique qu'il y a égalité si estVictoire est false, et indique qu'il y a Quarto et qui a gagné lorsque le paramètre estVictoire est vrai (la personne qui a gagné est obligatoirement la personne stockée dans currentPlayer)
// Post met en place l'affichage necessaire pour indiquer la fin de la partie au joueur et propose de relancer une nouvelle partie
func finPartie(estVictoire : Bool)

l’affichage et l’interaction avec les joueurs doivent être géré par le main
d’après les échanges cette fonction appelerait la fonction resetGame()
cette fonction devrait donc être écrite dans le main
(et si le joueur demande de relancer une partie, appeler resetGame() par conséquent)

resetGame() 2ème retour

// resetGame : quartoProtocol -> quartoProtocol
// Cette fonction remet la partie a 0 afin que l'on puisse rejouer
// Post : remise a 0 de la partie puis une nouvelle partie commence
mutating func resetGame()

pour moi "remettre la partie à 0" c’est pas assez clair et ça va peut-être poser des problèmes :
puisque on n’a pas la liste de ce que doit faire la fonction on doit deviner ce que veut dire exactement "remettre la partie à 0"
par exemple dire (si c’est vrai), collectionPieceRestantes doit avoir la même valeur qu’après la fonction init()
ou plus formellement, collectionPieceRestantes(resetGame()) == collectionPieceRestantes(init())
autre exemple : le joueur est à nouveau choisi au hasard ? ou alors c’est le perdant ou gagnant qui commence s’il y en a un ?

```


```
mode difficile :
définir plus clairement ce que c’est et ce que ça change

actuellement on a une variable estModeDifficile qui n’explique rien
dans la spécification de init il y a 
(le mode difficile inclus les quartos en carré alors que le mode normal ne l'inclus pas)
dans finVictoire il y a 
(Attention : il faut prendre en compte le mode de jeu dans lequel nous nous trouvons, si le mode est difficile il faut rajouter les carrés dans les vérifications)

"les carrés" n’est pas très clair,
au départ j’avais compris qu’on n’inclus pas les pièces carrées (et qu’on joue seulement avec les rondes, hautes ou non, claires ou non, pleines ou non)
et après avoir lu la règle du jeu + le sujet je pense avoir compris qu’avec le mode difficile il y a deux façons de gagner :

xxxx, chaque x est une pièce et toutes partagent une caractéristique commune, sur une ligne / colonne / diagonale

xx
xx

pareil mais sur un carré

est-ce bien ça le mode difficile ?
si oui je pense il faut mieux expliquer ce qu’est le mode difficile soit à la déclaration de la variable,
soit dans finVictoire() et dans ce cas dans la spécif de `var estModeDifficile` référer à finVictoire() (à mon avis)
```


```
  // finVictoire: quartoProtocol x Bool -> Bool
  // Cette fonction indique si la partie est finie parce qu'un des joueur a gagné la partie
  // Return : Renvoie true si la partie a été gagné par le joueur qui vient de jouer (Attention : il faut prendre en compte le mode de jeu dans lequel nous nous trouvons, si le mode est difficile il faut rajouter les carrés dans les vérifications)
  func finVictoire() -> Bool

la fonction ne spécifie pas qu’est ce qui fait qu’une partie est gagnée
j’imagine c’est si verifLigne() ou verifColonne() ou verifDiagonales() ou (verifCarre() et estModeDifficile) est vrai,
mais c’est pas spécifié
```


```
verifLignes(), verifColonnes(), verifDiagonales(), verifCarres()
  // Verifie s'il y a un quarto de forme ligne ( / colonne pour verifColonne, diagonale ou carré selon la fonction)
  // Return : true si il y a un quarto, false sinon

la fonction ne spécifie pas ce qu’est "un quarto" (et je pense pas que c’est non plus indiqué ailleurs dans le fichier quartoProtocol)
je pense avoir compris que c’est quatre pièces partageant au moins une caractéristique commune (haut ou pas, plein ou pas…)
sur la même ligne / colonne / diagonale / carré
mais c’est pas spécifié
```


```
joueurProtocol

  // init : String x quartoProtocol -> joueurProtocol
  // Crée l'instance joueurProtocol en assigant le nomJoueur passé en parametre au joueur et en initialisant la variable currentGame avec la partie de jeu en parametre
  // Pre : le parametre nomJoueur doit être différent de "" 
  // Pre : le parametre currentGame est une instance valide de quartoProtocol dans laquelle le joueur doit s'illustrer
  // Post : si les pré-conditions sont respectées, crée une instance de joueurProtocol
  init(nomJoueur : String, currentGame : quartoProtocol)

  Je connais pas swift très bien mais notamment avec ce qu’on a fait avec les aéroports je pense qu’il y a un problème :
  init() impose de créer une instance dans tous les cas, or la post condition indique de créer une instance de joueurProtocol uniquement si les pré-conditions sont respectées
  je pense donc qu’il faudrait utiliser init?()

  (pour l’aéroport il y avait un init qui peut échouer, et il était spécifié comme ça
  
    // init : String -> (IndicatifAeroport | Vide)
    // création d'un IndicationAeroport à partir d'un fichier csv de données
    // Pre: String représente le nom d'un fichier existant
    //      sinon la création échoue
    init?(file: String)

  )
```

---

```
pour tous les endroits où il y a une type protocol qui doit être utilisé, il faudrait utiliser un associatedType
https://docs.swift.org/swift-book/LanguageGuide/Generics.html#ID189
Ça permet d'indiquer que ce soit le même type dans les différentes fonctions
ex dans quartoProtocol, il y a plusieurs fois joueurProtocol utilisé, il faudrait créér un associatedType et l'utiliser comme type à la place pour indiquer que c'est toujours la même classe implémentant le protocol joueurProtocol 
```

