protocol caseProtocol{
  associatedtype piece : pieceProtocol
  
  // Stocke la position latérale de la case
  var x : Int {get}
  
  // Stocke la position verticale de la case
  var y : Int {get}

  // Contient la piece présente dans la case s'il y en a une, sinon vaut nil
  var piece : piece? {get set}
  
  // init : Int x Int -> caseProtocol
  // Crée l'instance de caseProtocol en assignant ses coordonnées aux coordonnées passés en paramètre et en initialisant la variable piece a nil 
  // Pre : les coordonnées x et y passées en paramètre sont conformes au plateau de jeu (qui fais une taille de 4 * 4 cases)
  // Post : si les préconditions sont remplies, crée une instance de caseProtocol
  init(x : Int, y : Int)

}
