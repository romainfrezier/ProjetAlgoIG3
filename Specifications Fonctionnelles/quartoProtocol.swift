protocol quartoProtocol{

  var j1 : joueurProtocol
  var j2 : joueurProtocol

  //Type : Collection quelconque contenant les cases du jeu
  var collectionCase 

  //
  var estModeDifficile : Bool 

  func tirageSort(joueur1 : joueurProtocol, joueur2 : joueurProtocol)

  init()

  func finEgalite() -> Bool

  func finVictoire(estModeDifficile : Bool) -> Bool

  func finPartie(estVictoire : Bool)

  func verifLigne() -> Bool

  func verifColonne() -> Bool

  func verifDiagonale() -> Bool

  func verifCarre() -> Bool

}