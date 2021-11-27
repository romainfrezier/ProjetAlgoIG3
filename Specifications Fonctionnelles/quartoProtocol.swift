protocol quartoProtocol{

  // Variable contenant le joueur n°1
  var j1 : joueurProtocol {get}

  // Variable contenant le joueur n°2
  var j2 : joueurProtocol {get}

  // Variable contenant le joueur actuel ou aucun si il n'a pas encore été choisi en début de partie
  var currentPlayer : joueurProtocol? {get set}

  // Collection contenant toutes les caseProtocol du jeu
  var collectionCase : Collection

  // Collection contenant toutes les pieces qui n'ont pas été placés
  var collectionPieceRestantes : Collection

  // Variable indiquant si on est en mode difficile ou normal,
  // Renvoie vrai si on est en mode difficile, faux sinon
  var estModeDifficile : Bool {get set}

  // Fonction qui modifie la variable currentPlayer pour désigner le 
  mutating func tirageSort(joueur1 : joueurProtocol, joueur2 : joueurProtocol) 
  
  // Crée l'instance quartoProtocol
  init()

  /* finEgalite -> Bool
  Cette fonction indique s'il y a égalité
  Return : true si la partie est finie parce qu'il y a eu égalité
  Pour savoir s'il y a egalité, il suffit de vérifier que toutes les pieces ont été joués ou que toutes les cases sont remplies*/
  func finEgalite() -> Bool

  /* finVictoire X Bool -> Bool
  
  
  
  */
  func finVictoire(estModeDifficile : Bool) -> Bool

  // Fonction qui met un terme a la partie, elle indique qu'il y a égalité si estVictoire est false, et indique qu'il y a Quarto et qui a gagné lorsque le paramètre estVictoire est vrai
  func finPartie(estVictoire : Bool)

  // Verifie s'il y a un quarto de forme ligne
  func verifLigne() -> Bool

  // Verifie s'il y a un quarto de forme colonne
  func verifColonne() -> Bool

  // Verifie s'il y a un quarto de forme diagonale
  func verifDiagonale() -> Bool

  // Verifie s'il y a un quarto de forme carré
  func verifCarre() -> Bool

  // Passe au joueur suivant
  func next() -> joueurProtocol
}