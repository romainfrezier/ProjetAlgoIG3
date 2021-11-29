protocol pieceProtocol{

  // pièce claire ou non (sombre)
  var estClair : Bool {get}

  // pièce ronde ou non (carré)
  var estRonde : Bool {get}

  // pièce haute ou non (basse)
  var estHaute : Bool {get}

  // pièce pleine ou non (creuse)
  var estPleine : Bool {get}

  // pièce placée ou non (en main ou non selectionné)
  var estPlace : Bool {get}

  // init : Bool x Bool x Bool x Bool -> pieceProtocol
  // Crée l'instance de pieceProtocol en assignant des caractéristiques à la pièce en fonction des booléens passés en paramètre
  // Post : Crée l'instance en initialisant les caractéristiques en fonction de celles passées en paramètre
  init(estClair : Bool, estRonde : Bool, estHaute : Bool, estPleine : Bool)

  // compareTo : pieceProtocol x pieceProtocol -> Collection
  // Fonction pour comparer les caractéristiques d'une pièce avec self
  // Return : Collection de caractéristiques communes entre les 2 pièces
  func compareTo(pieceToCompare : pieceProtocol) -> Collection

}