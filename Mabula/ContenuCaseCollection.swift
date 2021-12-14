   protocol ContenuCaseCollection: Sequence {
    associatedtype ItContenuCase: IteratorProtocol 
    associatedtype ContenuCase: TContenuCase

    // initialisation la collection, vide
    init()

    // ajoute contenuCase à la collection
    mutating func ajouterContenuCase(contenuCase: ContenuCase)

    // nombre d’éléments dans la collection
    var count : Int { get }

    // itérateur sur la collection
    func makeIterator() -> ItContenuCase

    // pré :
    // - le contenu des cases de toute la collection est homogènes, c’est-à-dire
    // c’est-à-dire soit elle sont toutes blanches, soit toutes noires, soit toutes inoccupées 
    func estHomogene() -> Bool

    // retourne contenuCase situé aux coordonnées x y
    func getContenuCase(x: Int, y: Int) -> ContenuCase

}

struct Plateau : ContenuCaseCollection{
    
    fileprivate var grid : [[ContenuCase?]]
    
    // nombre d’éléments dans la collection
    private var count : Int 
    // initialisation la collection, vide
    init(){
      self.grid : [[ContenuCase?]] = [[ContenuCase?]](repeating: [ContenuCase?](repeating: nil, count: 8), count: 8)

      for i in 0..<8{
        for j in 0..<8{
          self.grid[i][j] = ContenuCase(x: j, y: i)
        }
      }  

      self.count = self.grid.count * self.grid[0].count
    } 

    // ajoute contenuCase à la collection
    mutating func ajouterContenuCase(contenuCase: ContenuCase){
      return nil
    }

    

    // itérateur sur la collection
    func makeIterator() -> ItContenuCase {
      return ItContenuCase(self)
    }

    // pré :
    // - le contenu des cases de toute la collection est homogènes, c’est-à-dire
    // c’est-à-dire soit elle sont toutes blanches, soit toutes noires, soit toutes inoccupées 
    func estHomogene() -> Bool {
      var res : Bool = True
      var color : Bool = self.grid[0][0].estBlanc
      var occupated : Bool = self.grid[0][0].estInoccupe
      var it = self.makeIterator()
      var t : ContenuCase? = nil
      var previous : ContenuCase? = nil
      
      repeat{
        // condition d'arret : t == nil
        previous = t
        t = it.next()
        if ((let previous = previous) && previous.estInocupe != t.estInocupe){
          res = False
        }
        else if ((let previous = previous) && previous.estBlanc != t.estBlanc){
          res = False
        } 
      }
      while (t != nil)
    
      return res
    }

    // retourne contenuCase situé aux coordonnées x y
    func getContenuCase(x: Int, y: Int) -> ContenuCase {
      return self.grid[y][x]
    }

}

struct ItContenuCase : IteratorProtocol{

  private collection : ContenuCaseCollection
  private currentX : Int
  private currentY : Int

  init(_ collection : ContenuCaseCollection){
    self.collection = collection.grid
    self.currentX  = 0
    self.currentY = 0
  }

  func next() -> ContenuCaseCollection?{
    if(self.currentX != self.collection[0].count && self.currentX != self.collection.count){
      if currentY == self.collection[0].count - 1{
        self.currentX += 1
        let temp = self.currentY
        self.currentY = 0
        return self.collection[self.currentX-1][temp]
      }
      else{
        self.currentY += 1
        return self.collection[self.currentX][self.currentY-1]
      }
    }
    return nil
  }
  
/* ---------------------------------------------------------------*/

struct List : ContenuCaseCollection{
    
    fileprivate var list : [ContenuCase?]
    
    // nombre d’éléments dans la collection
    private var count : Int 

    // initialisation la collection, vide
    init(){
      self.list : [ContenuCase?] = [ContenuCase?](repeating: nil, count: 24)
      self.count = 0
    } 

    // ajoute contenuCase à la collection
    mutating func ajouterContenuCase(contenuCase: ContenuCase){
      guard self.count < 24 else {return nil}
      self.list[self.count] = contenuCase
      self.count += 1
    }

    // itérateur sur la collection
    func makeIterator1D() -> ItContenuCase1D {
      return ItContenuCase1D(self)
    }

    // pré :
    // - le contenu des cases de toute la collection est homogènes, c’est-à-dire
    // c’est-à-dire soit elle sont toutes blanches, soit toutes noires, soit toutes inoccupées 
    func estHomogene() -> Bool {
      var res : Bool = True
      var color : Bool = self.list[0].estBlanc
      var occupated : Bool = self.list[0].estInoccupe
      var it = self.makeIterator1D()
      var t : ContenuCase? = nil
      var previous : ContenuCase? = nil
      
      repeat{
        // condition d'arret : t == nil
        previous = t
        t = it.next()
        if ((let previous = previous) && previous.estInocupe != t.estInocupe){
          res = False
        }
        else if ((let previous = previous) && previous.estBlanc != t.estBlanc){
          res = False
        } 
      }
      while (t != nil)
    
      return res
    }

    // retourne contenuCase situé aux coordonnées x y

    // TODO
    // FONCTION CERTAINEMENT INUTILE ICI
    func getContenuCase(x: Int, y: Int) -> ContenuCase {
      return self.list[x]
    }

}

struct ItContenuCase1D : IteratorProtocol{

  private collection : ContenuCaseCollection
  private currentX : Int

  init(_ collection : ContenuCaseCollection){
    self.collection = collection.list
    self.currentX  = 0
  }

  func next() -> ContenuCaseCollection?{
    guard self.collection != nil else {return nil}
    guard self.currentX < 24 else {return nil}
    return self.collection[self.currentX]
    self.currentX += 1
  }
}