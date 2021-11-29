// ajouter , rendre indisponible, retourner les piece dispos, itérer, 
protocol CollectionPieceProtocol : Sequence{

  // init : -> CollectionPieceProtocol
  // Initialise une collection de pieceProtocol vide
  init()

  // addPiece : collectionPieceProtocol x pieceProtocol -> CollectionPieceProtocol
  // Ajoute une piece a la collection de pieces
  // Pre : pieceToAdd est une piece qui n'est pas déjà présente dans la collection
  // Post si le pré requis est rempli, la collection est mise à jour
  mutating func addPiece(pieceToAdd: pieceProtocol) 

  // makeUnavailable : CollectionPieceProtocol x pieceProtocol -> collectionPieceProtocol
  // Cette fonction fait les changements nécessaires pour indiquer qu'une pièce ne peut plus être selectionnée (car elle a déjà été posée sur le plateau)
  // Pre : piece est une pieceProtocol qui viens d'être placée et était jusqu'a présent disponible
  func makeUnavailable(piece : pieceProtocol)

  // getAvailablePieces : collectionPieceProtocol -> collection<pieceProtocol>
  // Cette fonction renvoie toutes les pièces de la collection qui peuvent encore être jouée (qui n'ont pas été jouée auparavent)
  // Return : renvoie une collection de pieceProtocol contenant toutes les pieces disponibles 
  func getAvailablePieces() -> Collection<pieceProtocol>

  // getLine : collectionPieceProtocol x Int -> Collection<pieceProtocol>
  // Cette fonction sers a récupérer toutes les pieces d'une ligne donnée en paramètre
  // Pre : line est un entier compris entre 0 et le nombre de lignes - 1 (inclu)
  // Return : Si les pré conditions sont remplies, retourne une collection contenant toutes les pieces de la ligne passée en paramètre
  func getLine(line : Int) -> Collection<pieceProtocol>

  // getColumn : collectionPieceProtocol x Int -> Collection<pieceProtocol>
  // Cette fonction sers a récupérer toutes les pieces d'une colonne donnée en paramètre
  // Pre : column est un entier compris entre 0 et le nombre de colonnes - 1 (inclu)
  // Return : Si les pré conditions sont remplies, retourne une collection contenant toutes les pieces de la colonne passée en paramètre
  func getColumn(column : Int) -> Collection<pieceProtocol>

  // getDiagonal : collectionPieceProtocol x Int -> Collection<pieceProtocol>
  // Cette fonction sers a récupérer toutes les pieces d'une diagonale donnée en paramètre
  // Pre : diagonal est un entier compris entre 0 et 1 (inclu)
  // Pre : la valeur 1 représente la diagonale qui part d'en haut a gauche vers en bas a droite et 0 représente l'autre diagonale
  // Return : Si les pré conditions sont remplies, retourne une collection contenant toutes les pieces de la diagonale passée en paramètre
  func getDiagonal(diagonal : Int) -> Collection<pieceProtocol>

  // getSquare : collectionPieceProtocol x Int x Int x Int x Int -> Collection<pieceProtocol>
  // Cette fonction sert a récupérer toutes les pieces d'un carré donné en paramètre
  // Pre : xStart et xEnd sont des entiers compris entre 0 et le nombre de colonnes - 1 (inclu)
  // Pre : yStart et yEnd sont des entiers compris entre 0 et le nombre de lignes - 1 (inclu)
  // Pre : Le carré selectionné doit obligatoirement renvoyer 4 valeurs, s'il en renvoie plus ou moins, cela n'est pas valable
  // Return : Si les pré conditions sont remplies, retourne une collection contenant toutes les pieces du carré passée en paramètre
  func getSquare(xStart : Int, yStart : Int, xEnd : Int, yEnd : Int) -> Collection<pieceProtocol>

  // makeIterator : collectionPieceProtocol -> collectionPieceIterator
  // Cette fonction crée et retourne un iterateur afin de pouvoir itérer sur la collection de pieces
  func makeIterator() -> collectionPieceIterator
}

// Itérateur de la collection de piece
protocol collectionPieceIterator : IteratorProtocol{

  // init : -> collectionPieceIterator
  // Cette fonction initialise l'itérateur en initialisant ses variables privées
  init()

  // next : collectionPieceIterator -> pieceProtocol?
  // Cette fonction retourne le prochain élément de la collection, s'ils ont tous été parcourrus, alors retourne nil pour indiquer la fin du parcours
  func next() -> pieceProtocol?

}