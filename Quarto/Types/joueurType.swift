struct joueurType : joueurProtocol{

  private var nomJoueur : String
  //private var 
  private var currentGame : quartoProtocol

  init(nomJoueur : String, currentGame : quartoProtocol){
    self.nomJoueur = nomJoueur
    self.currentGame = currentGame
  }

  // Pre : une piece a été selectionné correctement avec qu'elle puisse etre placée
  func placerPiece(pos : caseProtocol){
    pos.piece = self.currentGame.selectedPiece
  }
    
  func choisirPiece(piece : pieceProtocol){
    self.currentGame.selectedPiece = piece
  }


}