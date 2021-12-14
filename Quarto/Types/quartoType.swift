struct quartoType : quartoProtocol{

  private var j1 : joueurProtocol
  private var j2 : joueurProtocol
  private var selectedPiece : pieceProtocol?
  private var currentPlayer : joueurProtocol?
  private var collectionCase : Collection?
  private var collectionPieceRestantes : Collection
  private var estModeDifficile : Bool
  
  // Crée l'instance quartoProtocol
  init(j1 : joueurProtocol, j2 : joueurProtocol, estModeDifficile : Bool){
    self.j1 = j1
    self.j2 = j2
    self.selectedPiece = nil
    self.estModeDifficile = estModeDifficile
    self.initCase()
    self.initPiece()
    self.tirageSort()
  }

  mutating func tirageSort(){
    let number = Int.random(in: 0...1)

    if(number==0){
      self.currentPlayer = self.j1
    }
    else{
      self.currentPlayer = self.j2
    }
  }

  func finEgalite() -> Bool

  func finVictoire(estModeDifficile : Bool) -> Bool

  func finPartie(estVictoire : Bool){
    print("la partie est finie")
  }

  func verifLigne() -> Bool

  func verifColonne() -> Bool

  func verifDiagonale() -> Bool

  func verifCarre() -> Bool

  func next() -> joueurProtocol{
    if(self.currentPlayer == self.j1){
      return j2
    }
    else{
      return j1
    }
  }

  mutating func initCase(){
    self.collectionCase = [[caseType]]

    self.collectionCase[0][0] = caseType(x : 0, y : 0)
    self.collectionCase[0][1] = caseType(x : 0, y : 1)
    self.collectionCase[0][2] = caseType(x : 0, y : 2)
    self.collectionCase[0][3] = caseType(x : 0, y : 3)

    self.collectionCase[1][0] = caseType(x : 1, y : 0)
    self.collectionCase[1][1] = caseType(x : 1, y : 1)
    self.collectionCase[1][2] = caseType(x : 1, y : 2)
    self.collectionCase[1][3] = caseType(x : 1, y : 3)

    self.collectionCase[2][0] = caseType(x : 2, y : 0)
    self.collectionCase[2][1] = caseType(x : 2, y : 1)
    self.collectionCase[2][2] = caseType(x : 2, y : 2)
    self.collectionCase[2][3] = caseType(x : 2, y : 3)

    self.collectionCase[3][0] = caseType(x : 3, y : 0)
    self.collectionCase[3][1] = caseType(x : 3, y : 1)
    self.collectionCase[3][2] = caseType(x : 3, y : 2)
    self.collectionCase[3][3] = caseType(x : 3, y : 3)

  }

  //Liste pièces :
  /*Clair :
  petit plein rond
  petit plein carre
  petit troue carre
  petit troue rond
  grand plein rond
  grand plein carre
  grand troue carre
  grand troue rond
  
    Fonce :
  petit plein rond
  petit plein carre
  petit troue carre
  petit troue rond
  grand plein rond
  grand plein carre
  grand troue carre
  grand troue rond
  */
  mutating func initPiece(){
    private var 1 = pieceType(estClair : true,estRonde : true,estHaute : false,estPleine : true)
    private var 2 = pieceType(estClair : true,estRonde : false,estHaute : false,estPleine : true)
    private var 3 = pieceType(estClair : true,estRonde : false,estHaute : false,estPleine : false)
    private var 4 = pieceType(estClair : true,estRonde : true,estHaute : false,estPleine : false)
    private var 5 = pieceType(estClair : true,estRonde : true,estHaute : true,estPleine : true)
    private var 6 = pieceType(estClair : true,estRonde : false,estHaute : true,estPleine : true)
    private var 7 = pieceType(estClair : true,estRonde : false,estHaute : true,estPleine : false)
    private var 8 = pieceType(estClair : true,estRonde : true,estHaute : true,estPleine : false)

    private var 9 = pieceType(estClair : false,estRonde : true,estHaute : false,estPleine : true)
    private var 10 = pieceType(estClair : false,estRonde : false,estHaute : false,estPleine : true)
    private var 11 = pieceType(estClair : false,estRonde : false,estHaute : false,estPleine : false)
    private var 12 = pieceType(estClair : false,estRonde : true,estHaute : false,estPleine : false)
    private var 13 = pieceType(estClair : false,estRonde : true,estHaute : true,estPleine : true)
    private var 14  = pieceType(estClair : false,estRonde : false,estHaute : true,estPleine : true)
    private var 15 = pieceType(estClair : false,estRonde : false,estHaute : true,estPleine : false)
    private var 16 = pieceType(estClair : false,estRonde : true,estHaute : true,estPleine : false)
  }

  mutating func resetGame()

  func run(){
    // Partie : Tant que le match n'est pas terminé (égalité ou victoire d'un des joueur)

    while !self.finVictoire(estModeDifficile : self.estModeDifficile) && !self.finEgalite() {

      // Le joueur tiré au sort choisi une pièce
      self.currentPlayer.choisirPiece(piece: )
      self.currentPlayer.next()

      // Le joueur suivant place la pièce puis en choisi une autre
      self.currentPlayer.placerPiece(pos: )
      self.currentPlayer.choisirPiece(piece: )
      self.currentPlayer.next()

      // Le premier joueur place la pièce tiré par le joueur précédent
      self.currentPlayer.placerPiece(pos: )
    }

    // Post-partie

    // Le joueur qui remplie une des conditions de victoire à gagner sinon c'est une égalité

    jeu.finPartie(estVictoire : self.finVictoire(estModeDifficile : self.estModeDifficile))
  }
}