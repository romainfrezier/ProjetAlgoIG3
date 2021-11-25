protocol caseProtocol{
  
  // Position latérale de la case
  var x : Int
  
  // Position verticale de la case
  var y : Int

  // Contient la piece présente dans la case s'il y en a une, sinon vaut nil
  var piece : pieceProtocol?

  
  // Crée l'instance de caseProtocol en assignant ses coordonnées aux coordonnées passés en paramètre
  init(x : Int, y : Int)

}