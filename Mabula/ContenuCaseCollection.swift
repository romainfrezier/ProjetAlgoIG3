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
    func getContenuCase(x: Int, y: Int) -> ContenuCase?

}

// Type du plateau de jeu
struct Plateau{

    fileprivate var grid : [[ContenuCase?]]

    // nombre d’éléments dans la collection
    internal var count : Int
    // initialisation la collection, vide
    init(){
        self.grid = [[ContenuCase?]](repeating: [ContenuCase?](repeating: nil, count: 8), count: 8)

        // création d'une matrice de taille 8x8
        for i in 0..<8{
            for j in 0..<8{
                self.grid[i][j] = ContenuCase(x: j, y: i) // attribution des coordonnées x,y a la case
            }
        }

        // on garde en mémoire le nombre d'élément de la matrice
        self.count = self.grid.count * self.grid[0].count

    }

    // ajoute contenuCase à la collection
    // fonct ne rien faire du tout ?
    mutating func ajouterContenuCase(contenuCase: ContenuCase){
        return
    }

    // itérateur sur la collection
    func makeIterator() -> ItContenuCase {
        return ItContenuCase(self)
    }

    // pré :
    // - le contenu des cases de toute la collection est homogènes, c’est-à-dire
    // c’est-à-dire soit elle sont toutes blanches, soit toutes noires, soit toutes inoccupées
    func estHomogene() -> Bool {
        var res : Bool = true
        var it = self.makeIterator()
        var current : ContenuCase? = nil
        var previous : ContenuCase? = nil

        repeat{
            // condition d'arret : t == nil
            // invariant : res = True tant qu'on a pas trouvé un élément différent du précédent
            previous = current
            current = it.next()
            if let previous = previous{
                if let current = current{
                    if previous.estInoccupe != current.estInoccupe{
                        res = false
                    }
                }
            }

            else if let previous = previous{
                if let current = current{
                    if previous.estBlanc != current.estBlanc{
                        res = false
                    }
                }

            }
        }
        while (current != nil)

        return res
    }

    // retourne contenuCase situé aux coordonnées x,y
    func getContenuCase(x: Int, y: Int) -> ContenuCase? {
        if let grid = self.grid[y][x]{
            return grid
        }
        else{
            return nil
        }
    }

}

// Itérateur du plateau, permet de parcourir tout les élément de la matrice
struct ItContenuCase {

    private var collection: [[ContenuCase?]]
    private var currentX: Int
    private var currentY: Int

    init(_ collection: Plateau) {
        self.collection = collection.grid
        self.currentX = 0
        self.currentY = 0
    }

    mutating func next() -> ContenuCase? {
        if (self.currentX != self.collection[0].count && self.currentX != self.collection.count) {
            if currentY == self.collection[0].count - 1 {
                self.currentX += 1
                let temp = self.currentY
                self.currentY = 0
                return self.collection[self.currentX - 1][temp]
            } else {
                self.currentY += 1
                return self.collection[self.currentX][self.currentY - 1]
            }
        }
        return nil
    }
}
/* ---------------------------------------------------------------*/

// Type des collections du ContenuCase du jeu
struct List{

    fileprivate var list : [ContenuCase?]

    // nombre d’éléments dans la collection
    internal var count : Int

    // initialisation la collection, vide, de 24 élément `nil`
    init(){
        self.list = [ContenuCase?](repeating: nil, count: 24)
        self.count = 0
    }

    // ajoute contenuCase à la collection
    mutating func ajouterContenuCase(contenuCase: ContenuCase){
        guard self.count < 24 else {return}
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
        var res : Bool = true
        var it = self.makeIterator1D()
        var current : ContenuCase? = nil
        var previous : ContenuCase? = nil

        repeat{
            // condition d'arret : t == nil
            // invariant : res = True tant qu'on a pas trouvé un élément différent du précédent
            previous = current
            current = it.next()
            if let previous = previous {
                if let current = current {
                    if(previous.estInoccupe != current.estInoccupe){
                        res = false
                    }
                }
            }
            else if let previous = previous{
                if let current = current {
                    if(previous.estBlanc != current.estBlanc){
                        res = false
                    }
                }
            }
        }
        while (current != nil)

        return res
    }

    // retourne contenuCase situé aux coordonnées x y
    // VERIFY : FONCTION CERTAINEMENT INUTILE ICI
    func getContenuCase(x: Int, y: Int) -> ContenuCase? {
        if let list = self.list[x]{
            return list
        }
        else{
            return nil
        }
    }

}

// Itérateur de la collection, permet de parcourir tout les élément de la collection
struct ItContenuCase1D{
    private var collection : [ContenuCase?]
    private var currentX : Int

    init(_ collection : List){
        self.collection = collection.list
        self.currentX  = 0
    }

    mutating func next() -> ContenuCase?{
        guard(self.currentX < 24) else {return nil}
        self.currentX += 1
        return self.collection[self.currentX-1]
    }
}
