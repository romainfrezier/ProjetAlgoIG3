// PRESENTATION ET PREPARATION DU JEU
  // Un plateau de 16 cases
  // 16 pièces différentes ayant chacune 4 caractères : claire ou foncée, ronde ou carrée, haute ou basse, pleine ou creuse.

// BUT DU JEU
  // Créer sur le plateau un alignement de 4 pièces ayant au moins un caractère commun. Cet alignement peut-être horizontal, vertical ou diagonal.

// DEROULEMENT D’UNE PARTIE
  // Le premier joueur est tiré au sort.
  // Il choisit une des 16 pièces et la donne à son adversaire.
  // Celui-ci doit la placer sur une des cases du plateau et choisir ensuite une des 15 pièces restantes pour la donner à son adversaire.
  // A son tour, celui-ci la place sur une case libre et ainsi de suite...

// GAIN DE LA PARTIE
  // Un joueur gagne la partie lorsque, en plaçant la pièce donnée:
    // Il crée une ligne (ou un carré en mode difficile) de 4 claires ou 4 foncées ou 4 rondes ou 4 carrées ou 4 hautes ou 4 basses ou 4 pleines ou 4 creuses. Plusieurs caractères peuvent se cumuler.
    // Il n’est pas obligé d’avoir lui même déposé les trois autres pièces.

// FIN DE LA PARTIE
  // Victoire: un joueur annonce et montre un “QUARTO !”.
  // Egalité: toutes les pièces ont été posées sans vainqueur.



protocol quartoProtocol{
  associatedtype joueur : joueurProtocol
  associatedtype piece : pieceProtocol
  associatedtype collectionCase : collectionCaseProtocol
  associatedtype collectionPiece : collectionPieceProtocol

  // Variable contenant le joueur n°1
  var j1 : joueur {get}

  // Variable contenant le joueur n°2
  var j2 : joueur {get}

  // Piece selectionné actuellement
  var selectedPiece : piece? {get set}
  
  // Variable contenant le joueur actuel ou aucun si il n'a pas encore été choisi en début de partie
  var currentPlayer : joueur {get set}

  // Collection contenant toutes les caseProtocol du jeu
  var collectionCase : collectionCase {get}

  // Collection contenant toutes les pieces qui n'ont pas été placés
  var collectionPieceRestantes : collectionPiece {get}

  // Variable indiquant si on est en mode difficile ou normal,
  // Renvoie vrai si on est en mode difficile, faux sinon
  // Le mode difficile rajoute une manière de gagner en disposant des pièces ayant au moins une caractéristique commune en carré 
  // Exemple : pour des pièces ayant une caractéristique commune x, les dispositions pour gagner sont :
  // - la ligne : xxxx (verticale, horizontale & diagonale) -> mode facile et mode difficile
  // - le carré : xx () -> mode difficile uniquement
  //              xx
  var estModeDifficile : Bool {get set}
  
  // init : joueurProtocol x joueurProtocol x Bool -> quartoProtocol
  // Crée l'instance quartoProtocol avec les paramètres reçus
  // Post : Crée une instance de quartoProtocol avec les 2 joueurs passés en paramètre et ayant le bon mode de difficulté (le mode difficile inclus les quartos en carré alors que le mode normal ne l'inclus pas). Défini également quel joueur va jouer en premier. Initialise les cases et les pieces
  init(j1 : joueur, j2 : joueur, estModeDifficile : Bool)

  // tirageSort : quartoProtocol -> joueurProtocol
  // Fonction qui modifie la variable currentPlayer pour désigner la première personne qui doit jouer
  // Post : renvoie un des deux joueurs de la partie selectionné aléatoirement
  mutating func tirageSort() -> joueur

  // finEgalite : quartoProtocol -> Bool
  // Cette fonction indique s'il y a égalité
  // Return : true si la partie est finie parce qu'il y a eu égalité
  //Pour savoir s'il y a egalité, il suffit de vérifier que toutes les pieces ont été joués ou que toutes les cases sont remplies
  func finEgalite() -> Bool

  // finVictoire: quartoProtocol x Bool -> Bool
  // Cette fonction indique si la partie est finie parce qu'un des joueur a gagné la partie
  // La fonction utilise les sous-fonctions de verifications afin de vérifier si un Quarto est réalisé dans les directions (le nom des )
  // Return : Renvoie true si la partie a été gagné par le joueur qui vient de jouer (Attention : il faut prendre en compte le mode de jeu dans lequel nous nous trouvons, [voir specifications et variable `estModeDifficile`])
  func finVictoire() -> Bool

  // verifLignes : quartoProtocol -> Bool
  // Verifie s'il y a un quarto de forme ligne
  // Return : true si il y a un quarto, false sinon
  func verifLignes() -> Bool

  // verifColonnes: quartoProtocol -> Bool
  // Verifie s'il y a un quarto de forme colonne
  // Return : true si il y a un quarto, false sinon
  func verifColonnes() -> Bool

  // verifDiagonales : quartoProtocol -> Bool
  // Verifie s'il y a un quarto de forme diagonale
  // Return : true si il y a un quarto, false sinon
  func verifDiagonales() -> Bool

  // verifCarres : quartoProtocol -> Bool
  // Verifie s'il y a un quarto de forme carré
  // N'est utilisée que pour le mode difficile
  // Return : true si il y a un quarto, false sinon
  func verifCarres() -> Bool

  // next : quartoProtocol -> quartoProtocol
  // Passe au joueur suivant (met dans currentPlayer le joueur qui n'y est pas actuellement)
  // Post : le joueur n'étant pas dans currentPlayer rentre dans currentPlayer
  mutating func next()

  // initCase : quartoProtocol -> quartoProtocol
  // Cette fonction initialise toutes les cases nécessaires au jeu
  // Post : Initialise les cases du plateau de jeu
  mutating func initCase()

  // initPiece : quartoProtocol -> quartoProtocol
  // Cette fonction permet d'initialiser les pieces du jeu
  // Post : initialise les différentes pieces du jeu et les ajoutes dans la collection de pieces
  mutating func initPiece()

  // resetGame : quartoProtocol -> quartoProtocol
  // Cette fonction reinitialise la partie afin que l'on puisse rejouer, dans l'état où était la partie juste après le init, ce qui signifie que : 
  // - toute les pièces sont disponibles
  // - le plateau de jeu est vierge
  // - le tirage au sort du joueur qui jouera en premier est réalisé
  // Post : remise a 0 de la partie puis une nouvelle partie commence
  mutating func resetGame()
}