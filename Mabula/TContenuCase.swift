protocol TContenuCase {
  // toutes les variables booléennes sont mutuellement exclusives, si une est true les 2 autres sont false

  init(x: Int, y: Int)

  // indique si la case est inoccupée
  var estInoccupe : Bool { get set }

  // indique si la case est occupée par une bille de couleur blanche
  var estBlanc : Bool { get set }

  // indique si la case est occupée par une bille de couleur noire
  var estNoir : Bool { get set }

  // coordonnées de la case sur le plateau de 8x8 cases
  // x, y ∈ [0, 7]
  var x : Int { get set }
  var y : Int { get set }
}

struct ContenuCase : TContenuCase {
    // toutes les variables booléennes sont mutuellement exclusives, si une est true les 2 autres sont false

    // indique si la case est inoccupée
    // estVide
    private var estInoccupe : Bool

    // indique si la case est occupée par une bille de couleur blanche
    private var estBlanc : Bool

    // indique si la case est occupée par une bille de couleur noire
    private var estNoir : Bool

    // coordonnées de la case sur le plateau de 8x8 cases
    // x, y ∈ [0, 7]
    private var x : Int 
    private var y : Int 

    init(x:Int, y: Int){
      self.estInoccupe = True
      self.estBlanc = False
      self.estNoir = False
      self.x = x
      self.y = y
    }
}
