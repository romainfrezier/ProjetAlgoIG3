// Ce protocole doit permettre plusieurs opérations sur la collection de case, telles que : itérer, consulter une case par coordonnées, recup ligne, colonne, diagonale , carre
protocol CollectionCaseProtocol : Sequence{

  // init : Int -> CollectionCaseProtocol
  // Cette fonction crée une instance de CollectionCaseProtocol en initialisant la collection de caseProtocol
  // Pre : nbCase est le nombre de case qu'il faut pour créer notre plateau
  init(nbCase : Int)

  // getCaseByCoord : collectionCaseProtocol x Int x Int -> caseProtocol
  // Cette fonction permet de récuperer une case a partir de ses coordonnées, afin de pouvoir effetuer des opérations sur cette case
  // Pre : x est un entier compris entre 0 et la taille d'une ligne - 1
  // Pre : y est un entier compris entre 0 et la taille d'une colonne - 1
  // Return : Si les préconditions sont respectées, renvoie la case correspondant aux coordonnées
  func getCaseByCoord(x : Int, y : Int) -> caseProtocol

  // getLine : collectionCaseProtocol x Int -> Collection<caseProtocol>
  // Cette fonction sers a récupérer toutes les cases d'une ligne donnée en paramètre
  // Pre : line est un entier compris entre 0 et le nombre de lignes - 1 (inclu)
  // Return : Si les pré conditions sont remplies, retourne une collection contenant toutes les cases de la ligne passée en paramètre
  func getLine(line : Int) -> Collection<caseProtocol>

  // getColumn : collectionCaseProtocol x Int -> Collection<caseProtocol>
  // Cette fonction sers a récupérer toutes les cases d'une colonne donnée en paramètre
  // Pre : column est un entier compris entre 0 et le nombre de colonnes - 1 (inclu)
  // Return : Si les pré conditions sont remplies, retourne une collection contenant toutes les cases de la colonne passée en paramètre
  func getColumn(column : Int) -> Collection<caseProtocol>

  // getDiagonal : collectionCaseProtocol x Int -> Collection<caseProtocol>
  // Cette fonction sers a récupérer toutes les cases d'une diagonale donnée en paramètre
  // Pre : diagonal est un entier compris entre 0 et 1 (inclu)
  // Pre : la valeur 1 représente la diagonale qui part d'en haut a gauche vers en bas a droite et 0 représente l'autre diagonale
  // Return : Si les pré conditions sont remplies, retourne une collection contenant toutes les cases de la diagonale passée en paramètre
  func getDiagonal(diagonal : Int) -> Collection<caseProtocol>

  // getSquare : collectionCaseProtocol x Int x Int x Int x Int -> Collection<caseProtocol>
  // Cette fonction sers a récupérer toutes les cases d'un carré donné en paramètre
  // Pre : xStart et xEnd sont des entiers compris entre 0 et le nombre de colonnes - 1 (inclu)
  // Pre : yStart et yEnd sont des entiers compris entre 0 et le nombre de lignes - 1 (inclu)
  // Pre : Le carré selectionné doit obligatoirement renvoyer 4 valeurs, s'il en renvoie plus ou moins, cela n'est pas valable
  // Return : Si les pré conditions sont remplies, retourne une collection contenant toutes les cases du carré passée en paramètre
  func getSquare(xStart : Int, yStart : Int, xEnd : Int, yEnd : Int) -> Collection<caseProtocol>

  // makeIterator : collectionCaseProtocol -> collectionCaseIterator
  // Cette fonction crée et retourne un iterateur afin de pouvoir itérer sur la collection de cases
  func makeIterator() -> collectionCaseIterator
}

// Itérateur de la collection de cases
protocol collectionCaseIterator : IteratorProtocol{
  // init : -> collectionCaseIterator
  // Cette fonction initialise l'itérateur en initialisant ses variables privées
  init()

  // next : collectionCaseIterator -> caseProtocol?
  // Cette fonction retourne le prochain élément de la collection, s'ils ont tous été parcourrus, alors retourne nil pour indiquer la fin du parcours
  func next() -> caseProtocol?

}