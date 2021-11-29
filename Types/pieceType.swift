struct pieceType : pieceProtocol{

  private var estClair : Bool
  private var estRonde : Bool
  private var estHaute : Bool
  private var estPleine : Bool

  private var estPlace : Bool

  init(estClair : Bool, estRonde : Bool, estHaute : Bool,estPleine : Bool){
    self.estClair = estClair
    self.estRonde = estRonde
    self.estHaute = estHaute
    self.estPleine = estPleine
    self.estPlace = false
  }

  func compareTo(pieceToCompare : pieceProtocol) -> Collection{
    var tab : [Int] = Array(repeating: -1, count: 4)

    if(self.estClair == pieceToCompare.estClair){
      if(self.estClair){
        tab[0] = 1
      }
      else{
        tab[0] = 0
      }
    }

    if(self.estRonde == pieceToCompare.estRonde){
      if(self.estRonde){
        tab[1] = 1
      }
      else{
        tab[1] = 0
      }
    }

    if(self.estHaute == pieceToCompare.estHaute){
      if(self.estHaute){
        tab[2] = 1
      }
      else{
        tab[2] = 0
      }
    }

    if(self.estPleine == pieceToCompare.estPleine){
      if(self.estPleine){
        tab[3] = 1
      }
      else{
        tab[3] = 0
      }
    }

    return tab
  }
}