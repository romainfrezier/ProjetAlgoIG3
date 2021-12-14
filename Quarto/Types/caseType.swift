struct caseType : caseProtocol{

  private var x : Int
  private var y : Int
  private var piece : pieceProtocol?

  init(x : Int, y : Int){
    self.x = x
    self.y = y
  }
}