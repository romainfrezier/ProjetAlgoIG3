protocol joueurProtocol{

  // Nom du joueur (exemple : "Toto")
  var nomJoueur : String {get}

  // Indique la partie actuelle dans laquelle se trouve le joueur (self)
  var currentGame : quartoProtocol {get}

  // init : String x quartoProtocol -> joueurProtocol
  // Crée l'instance joueurProtocol en assigant le nomJoueur passé en parametre au joueur et en initialisant la variable currentGame avec la partie de jeu en parametre
  // Pre : le parametre nomJoueur doit être différent de "" 
  // Pre : le parametre currentGame est une instance valide de quartoProtocol dans laquelle le joueur doit s'illustrer
  // Post : si les pré-conditions sont respectées, crée une instance de joueurProtocol
  init(nomJoueur : String, currentGame : quartoProtocol)

  // placerPiece : joueurProtocol x caseProtocol -> joueurProtocol
  // Place une pièce a la case indiquée dans la partie dans laquelle se trouve le joueur
  // Pre : une piece a été selectionné correctement (piece qui n'a pas déjà été posée) précedement afin qu'elle puisse etre placée
  // Pre : la case donnée en parametre existe et fait partie du plateau de jeu (Collection de cases)
  // Post : Si les pré conditions sont respectées, la piece est placée dans la case donnée en parametre
  func placerPiece(pos : caseProtocol)

  // choisirPiece : joueurProtocol x pieceProtocol -> joueurProtocol
  // Selectionne la piece envoyé en parametre 
  // Pre : la piece passé en parametre se trouve parmis celle.s restante.s/disponible.s, ç-a-d celle.s qui n'ont pas été joué précedement
  // Post : Si les précondition sont respectées, la piece passée en parametre est selectionné pour que le prochain joueur puisse la poser
  func choisirPiece(piece : pieceProtocol)

}
