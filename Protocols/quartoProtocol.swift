protocol quartoProtocol{

  // Variable contenant le joueur n°1
  var j1 : joueurProtocol {get}

  // Variable contenant le joueur n°2
  var j2 : joueurProtocol {get}

  // Piece selectionné actuellement
  var selectedPiece : pieceProtocol? {get set}
  
  // Variable contenant le joueur actuel ou aucun si il n'a pas encore été choisi en début de partie
  var currentPlayer : joueurProtocol {get set}

  // Collection contenant toutes les caseProtocol du jeu
  var collectionCase : collectionCaseProtocol {get}

  // Collection contenant toutes les pieces qui n'ont pas été placés
  var collectionPieceRestantes : collectionPieceProtocol {get}

  // Variable indiquant si on est en mode difficile ou normal,
  // Renvoie vrai si on est en mode difficile, faux sinon
  var estModeDifficile : Bool {get set}
  
  // init : joueurProtocol x joueurProtocol x Bool -> quartoProtocol
  // Crée l'instance quartoProtocol avec les paramètres reçus
  // Post : Crée une instance de quartoProtocol avec les 2 joueurs passés en paramètre et ayant le bon mode de difficulté (le mode difficile inclus les quartos en carré alors que le mode normal ne l'inclus pas). Défini également quel joueur va jouer en premier.
  init(j1 : joueurProtocol, j2 : joueurProtocol, estModeDifficile : Bool)

  // tirageSort : quartoProtocol -> joueurProtocol
  // Fonction qui modifie la variable currentPlayer pour désigner la première personne qui doit jouer
  // Post : renvoie un des deux joueurs de la partie selectionné aléatoirement
  mutating func tirageSort() -> joueurProtocol

  // finEgalite : quartoProtocol -> Bool
  // Cette fonction indique s'il y a égalité
  // Return : true si la partie est finie parce qu'il y a eu égalité
  //Pour savoir s'il y a egalité, il suffit de vérifier que toutes les pieces ont été joués ou que toutes les cases sont remplies
  func finEgalite() -> Bool

  // finVictoire: quartoProtocol x Bool -> Bool
  // Cette fonction indique si la partie est finie parce qu'un des joueur a gagné la partie
  // Return : Renvoie true si la partie a été gagné par le joueur qui vient de jouer (Attention : il faut prendre en compte le mode de jeu dans lequel nous nous trouvons, si le mode est difficile il faut rajouter les carrés dans les vérifications)
  func finVictoire(estModeDifficile : Bool) -> Bool

  // finPartie : quartoProtocol x Bool -> quartoProtocol
  // Fonction qui met un terme a la partie, elle indique qu'il y a égalité si estVictoire est false, et indique qu'il y a Quarto et qui a gagné lorsque le paramètre estVictoire est vrai (la personne qui a gagné est obligatoirement la personne stockée dans currentPlayer)
  // Post met en place l'affichage necessaire pour indiquer la fin de la partie au joueur et propose de relancer une nouvelle partie
  func finPartie(estVictoire : Bool)

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
  // Cette fonction remet la partie a 0 afin que l'on puisse rejouer
  // Post : remise a 0 de la partie puis une nouvelle partie commence
  mutating func resetGame()
  
  // run : quartoProtocol -> quartoProtocol
  // demarre le jeu et déroule le jeu jusqu'a la fin de la partie
  // Post : démarre le jeu jusqu'a que celui ci se termine par victoire ou par égalité
  func run()
}