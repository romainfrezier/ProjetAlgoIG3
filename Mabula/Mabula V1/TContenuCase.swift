protocol TContenuCase {
    // le type concret implémentant ce type abstrait doit s'appeler ContenuCase

    // indique si la case est inoccupée
    var estInoccupe : Bool { get set }

    // indique si la case est occupée par une bille de couleur blanche
    var estBlanc : Bool { get set }

    // indique si la case est occupée par une bille de couleur noire
    var estNoir : Bool { get set }
}
