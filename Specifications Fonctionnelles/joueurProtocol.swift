protocol joueurProtocol{

  var nomJoueur : String
  var nbPiecesPlace : Int

  init(nomJoueur : String)

  func placerPiece(case : caseProtocol)

  func choisirPiece(piece : pieceProtocol)

}