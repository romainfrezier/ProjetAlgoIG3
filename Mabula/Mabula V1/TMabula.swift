protocol TMabula {
    // le type concret doit s'appeler Mabula
    
    // Initialise la partie avec la méthode de calcul et le joueur actuel
    //
    // post :
    // - les billes sont placées sur le plateau aux coordonnées x et y telles que :
    //    si x ∈ {0, 7}
    //     y ∈ [1,6]
    //    sinon si x ∈ [1,6]
    //     y ∈ {0, 7}
    //    <=> les billes ne peuvent êtes placées que sur les bords du plateaux ; les quatre coins aux extrémités ne peuvent pas être occupées
    // - Il ne peut pas y avoir plus de deux billes de la même couleur consécutives (même à travers les coins)
    init(methodeCalcul: MethodeCalcul, joueurActuel: Joueur)
    
    // Initialise la partie de la même manière mais le joueur est choisi au hasard
    init(methodeCalcul: MethodeCalcul)

    // récupère le contenu de la case à la position (x, y) sur le plateau
    // ContenuCase est le type concret implémentant TContenuCase
    func recupererContenuCase(x: Int, y: Int) -> ContenuCase

    var joueurActuel : Joueur { get set }

    // La fonction renvoie quel joueur jouera au prochain tour (en alternance, sauf exceptions)
    // Si un joueur ne peut pas déplacer de bille, il ne peut pas jouer et perd son tour
    // Si aucun ne peut jouer, la partie est finie donc la fonction renvoie nil
    func prochainJoueur() -> Joueur?
    
    // Calcule si la partie est terminée ou non
    // la partie est finie lorsque aucun joueur ne peut jouer
    func partieFinie() -> Bool
    

    // xDebut, yDebut sont les coordonnées de la case où est là bille que l'on veut déplacer
    // xFin, yFin sont les coordonnées de la case où l'on veut déplacer la bille
    // Pre: 
    // - xFin, yFin ∈ [1, 6] // <=> les billes ne peuvent pas être déplacées sur les bords du plateau
    // - si xDebut ∈ {0, 7}
    //     yDebut ∈ [1,6]
    //   sinon si x ∈ [1,6]
    //     yDebut ∈ {0, 7}
    // <=> les billes ne peuvent êtes déplacées que si elles sont sur les bords du plateaux
    // - les déplacements s’effectuent en ligne droite vers le centre
    // - il est possible de pousser des billes sur la même ligne droite à condition que le déplacement de ces billes soit possible
    func deplacementPossible(xDebut: Int, yDebut: Int, xFin: Int, yFin: Int) -> Bool

    // si deplacementPossible(xDebut: xDebut, yDebut: yDebut, xFin: xFin, yFin: yFin)
    // alors la fonction déplace la bille sur le plateau (et pousse éventuellement d’autres billes sur la même ligne)
    // sinon, ne fait rien
    mutating func deplacerBille(xDebut: Int, yDebut: Int, xFin: Int, yFin: Int)
    
    // comment calculer les scores :
    // un groupe = suite de billes qui se touchent horizontalement ou verticalement consécutivement
    
    // méthode plusGrandGroupe : le score d’un joueur est la taille du plus grand groupe de bille de sa couleur
    // méthode multiplicationGroupes : le score d’un joueur est la multiplication de la taille de tous les groupes de billes de sa couleur
    
    // Pour une bille donnée, retourne le nombre de billes dans son groupe
    func nombreBillesGroupe(x: Int, y: Int) -> Int
    
    // calcule les scores de chaque joueurs en utilisant la méthode par défault
    // c’est-à-dire la méthode passé en paramètre dans la fonction init()
    func calculScore() -> [Joueur:Int]
    
    // calcule les scores en utilisant la méthode passée en paramètre
    func calculScore(methodeCalcul: MethodeCalcul) -> [Joueur:Int]

}
