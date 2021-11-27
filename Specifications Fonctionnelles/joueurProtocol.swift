protocol joueurProtocol{
  // Nom du joueur (exemple : Toto)
  var nomJoueur : String {get set}

  // Nombre de pièce.s déjà placée.s par le joueur
  var nbPiecesPlace : Int {get}


  // Crée l'instance joueurProtocol en assigant un nomJoueur au joueur
  init(nomJoueur : String)

  // Place une pièce a la case indiquée
  func placerPiece(pos : caseProtocol)

  // Choisi une pièce parmis celle.s restante.s/disponible.s
  func choisirPiece(piece : pieceProtocol)

}

