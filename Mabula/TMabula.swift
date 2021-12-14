protocol TMabula {
    // Le type concret doit s'appeler Mabula (impossible d'utiliser des associatedType dans le main)
    associatedtype ContenuCase: TContenuCase
    associatedtype ContenuCaseCollectionAssociatedT: ContenuCaseCollection
    
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
    // - il y a 24 billes au total, 12 noires et 12 blanches
    init(estMethodeCalculPlusGrandGroupe: Bool, joueurActuel: Joueur)
    
    // Initialise la partie de la même manière mais le joueur est choisi au hasard
    init(estMethodeCalculPlusGrandGroupe: Bool)

    // récupère le contenu de la case à la position (x, y) sur le plateau
    // ContenuCase est le type concret implémentant TContenuCase (cf. associatedtype)
    func recupererContenuCase(x: Int, y: Int) -> ContenuCase

    var joueurActuel : Joueur { get set }

    // La fonction renvoie quel joueur jouera au prochain tour (en alternance, sauf exceptions)
    // Si un joueur ne peut pas déplacer de bille, il ne peut pas jouer et perd son tour
    // Si aucun ne peut jouer, la partie est finie donc la fonction renvoie nil
    // prochainJoueur() == nil <=> !(peutJouer(joueur: Joueur.noir) || peutJouer(joueur: Joueur.blanc))
    func prochainJoueur() -> Joueur?
    
    // Calcule si la partie est terminée ou non
    // la partie est finie lorsque aucun joueur ne peut jouer
    // partieFinie() == true <=> !(peutJouer(joueur: Joueur.noir) || peutJouer(joueur: Joueur.blanc))
    func partieFinie() -> Bool

    // Retourne si un joueur peut joueur
    // il peut joueur s’il des déplacements possible : si le joueur peut déplacer des billes,
    // c’est-à-dire s’il y a des billes de sa couleur au bord du plateau
    // le bord du plateau étant :
    //   si x ∈ {0, 7}
    //     y ∈ [1,6]
    //   sinon si x ∈ [1,6]
    //     y ∈ {0, 7}
    func peutJouer(joueur: Joueur) -> Bool
    

    // xDebut, yDebut sont les coordonnées de la case où est là bille que l'on veut déplacer
    // la bille est déplacée de nbCasesDeplacement cases
    // Pre: 
    // - les billes ne peuvent pas être déplacées sur les bords du plateau
    // - si xDebut ∈ {0, 7}
    //     yDebut ∈ [1,6]
    //   sinon si x ∈ [1,6]
    //     yDebut ∈ {0, 7}
    // <=> les billes ne peuvent êtes déplacées que si elles sont sur les bords du plateaux
    // - les déplacements s’effectuent en ligne droite vers le centre
    // - il est possible de pousser des billes sur la même ligne droite à condition que le déplacement de ces billes soit possible
    // - il est uniquement pour un joueur possible de déplacer des billes de sa propre couleur (à moins de pousser les billes de l'autre joueur)
    //
    // post : renvoie true si les pré-conditions sont respéctées, false sinon
    func deplacementPossible(xDebut: Int, yDebut: Int, nbCasesDeplacement: Int) -> Bool

    // si deplacementPossible(xDebut: xDebut, yDebut: yDebut, nbcasesDeplacement: nbCasesDeplacement)
    // alors la fonction déplace la bille sur le plateau (et pousse éventuellement d’autres billes sur la même ligne)
    // sinon, ne fait rien
    mutating func deplacerBille(xDebut: Int, yDebut: Int, nbCasesDeplacement: Int)
    
    // comment calculer les scores :
    // un groupe = suite de billes qui se touchent horizontalement ou verticalement consécutivement
    
    // méthode plusGrandGroupe : le score d’un joueur est la taille du plus grand groupe de bille de sa couleur
    // méthode multiplicationGroupes : le score d’un joueur est la multiplication de la taille de tous les groupes de billes de sa couleur

    // retourne l’ensemble des groupes de billes appartenant au joueur passé en paramètre
    func recupererGroupesBilles(joueur: Joueur) -> [ContenuCaseCollectionAssociatedT]

    // récupère le plus grand groupe de billes appartenant au joueur passé en paramètre
    func recupererPlusGrandGroupeBilles(joueur: Joueur) -> ContenuCaseCollectionAssociatedT

    // calcule les scores de chaque joueurs en utilisant la méthode par défault
    // c’est-à-dire la méthode passé en paramètre dans la fonction init()
    func calculScore() -> [Joueur:Int]
    
    // calcule les scores en utilisant la méthode passée en paramètre
    func calculScore(estMethodeCalculPlusGrandGroupe: Bool) -> [Joueur:Int]

}

// ######################### Struct Mabula ##########################

struct Mabula : TMabula {    

  private var joueurActuel : Joueur

  private var estMethodeCalculPlusGrandGroupe : Bool

  private var grid : Plateau

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
    // - il y a 24 billes au total, 12 noires et 12 blanches
    init(estMethodeCalculPlusGrandGroupe: Bool, joueurActuel: Joueur){
      // On initialise selon la fonction init basique
      init(estMethodeCalculPlusGrandGroupe : estMethodeCalculPlusGrandGroupe)
      // On impose le joueur qui commence
      self.joueurActuel = joueurActuel
    }
    
    // Initialise la partie de la même manière mais le joueur est choisi au hasard
    init(estMethodeCalculPlusGrandGroupe: Bool){
      // Init des variables
      self.estMethodeCalculPlusGrandGroupe = estMethodeCalculPlusGrandGroupe

      // Déterminer le joueur qui commence

      var joueur : Int = Int.random(in: 0..<2)
      joueur == 0? joueurActuel = Joueur.blanc : joueurActuel = Joueur.noir
      
      // Initialiser le plateau

      self.grid = Plateau()

      //TODO
      // PLACER LES BILLES ALEATOIREMENT

    }

    private func creerOrdreBilles(){
      var tab : [Int] = Array(repeating : 0, count : 24)

      var a : Bool
      repeat{
        a = fillTab(array : &tab, index : 0, serie : 0, caseSerie : -1, nbFirstAvailable : 12, nbSecondAvailable : 12)
      }
      while(!a)

      //TODO
      // Remplir le plateau grace au tableau d'ordre
    }

    @discardableResult private func placerBillesRecur(array : inout [Int], index : Int, serie : Int, caseSerie : Int, nbFirstAvailable : Int, nbSecondAvailable : Int) -> Bool{
      if(index == array.count){
        if(array[0] == array[array.count-1]){
          if(array[0] == array[1] || array[array.count-1] == array[array.count-2]){
            return false
          }
        }
      return true
      }
      if(serie == 2){
        let nb = caseSerie == 0 ? 1 : 0
        if(nb==0 && nbFirstAvailable==0){
          return false
        }
      array[index] = nb 
      return fillTab(array : &array, index : index+1, serie : 1, caseSerie : nb, nbFirstAvailable : nb == 0 ? nbFirstAvailable-1 : nbFirstAvailable, nbSecondAvailable : nb == 1 ? nbSecondAvailable-1 : nbSecondAvailable)
      }
      var rand : Int
      if(nbFirstAvailable == 0 && nbSecondAvailable != 0){
        rand = 1
      }
      else if(nbFirstAvailable != 0 && nbSecondAvailable == 0){
        rand = 0
      }
      else{
        rand = Int.random(in: 0..<2)
      }
      array[index] = rand
      return fillTab(array : &array, index : index+1, serie : caseSerie == rand ? 2 : 1, caseSerie : rand, nbFirstAvailable : rand == 0 ? nbFirstAvailable-1 : nbFirstAvailable, nbSecondAvailable : rand == 1 ? nbSecondAvailable-1 : nbSecondAvailable)
    }

    // récupère le contenu de la case à la position (x, y) sur le plateau
    // ContenuCase est le type concret implémentant TContenuCase (cf. associatedtype)
    func recupererContenuCase(x: Int, y: Int) -> ContenuCase{
      self.grid.getContenuCase(x: x, y: y)
    }

    // La fonction renvoie quel joueur jouera au prochain tour (en alternance, sauf exceptions)
    // Si un joueur ne peut pas déplacer de bille, il ne peut pas jouer et perd son tour
    // Si aucun ne peut jouer, la partie est finie donc la fonction renvoie nil
    // prochainJoueur() == nil <=> !(peutJouer(joueur: Joueur.noir) || peutJouer(joueur: Joueur.blanc))
    func prochainJoueur() -> Joueur?{
      // A CORRIGER
      self.joueurActuel == Joueur.blanc ? joueurActuel = Joueur.noir : joueurActuel = Joueur.blanc
      (!(peutJouer(joueur: Joueur.noir)) || peutJouer(joueur: Joueur.blanc))? return nil : return self.joueurActuel
    }
    
    // Calcule si la partie est terminée ou non
    // la partie est finie lorsque aucun joueur ne peut jouer
    // partieFinie() == true <=> !(peutJouer(joueur: Joueur.noir) || peutJouer(joueur: Joueur.blanc))
    func partieFinie() -> Bool{
      return (!(peutJouer(joueur: Joueur.blanc)) && !(peutJouer(joueur: Joueur.noir)))
    }

    // Retourne si un joueur peut joueur
    // il peut joueur s’il des déplacements possible : si le joueur peut déplacer des billes,
    // c’est-à-dire s’il y a des billes de sa couleur au bord du plateau
    // le bord du plateau étant :
    //   si x ∈ {0, 7}
    //     y ∈ [1,6]
    //   sinon si x ∈ [1,6]
    //     y ∈ {0, 7}
    func peutJouer(joueur: Joueur) -> Bool{
      // Si le joueur n'a plus de billes sur le bord, renvoie directement false

      //On verifie si le joueur a des billes sur le bord mais qu'elle ne peuvent pas être déplacés
    }
    

    // xDebut, yDebut sont les coordonnées de la case où est là bille que l'on veut déplacer
    // la bille est déplacée de nbCasesDeplacement cases
    // Pre: 
    // - les billes ne peuvent pas être déplacées sur les bords du plateau
    // - si xDebut ∈ {0, 7}
    //     yDebut ∈ [1,6]
    //   sinon si x ∈ [1,6]
    //     yDebut ∈ {0, 7}
    // <=> les billes ne peuvent êtes déplacées que si elles sont sur les bords du plateaux
    // - les déplacements s’effectuent en ligne droite vers le centre
    // - il est possible de pousser des billes sur la même ligne droite à condition que le déplacement de ces billes soit possible
    // - il est uniquement pour un joueur possible de déplacer des billes de sa propre couleur (à moins de pousser les billes de l'autre joueur)
    //
    // post : renvoie true si les pré-conditions sont respéctées, false sinon
    func deplacementPossible(xDebut: Int, yDebut: Int, nbCasesDeplacement: Int) -> Bool{

    }

    // si deplacementPossible(xDebut: xDebut, yDebut: yDebut, nbcasesDeplacement: nbCasesDeplacement)
    // alors la fonction déplace la bille sur le plateau (et pousse éventuellement d’autres billes sur la même ligne)
    // sinon, ne fait rien
    mutating func deplacerBille(xDebut: Int, yDebut: Int, nbCasesDeplacement: Int){

    }
    
    // comment calculer les scores :
    // un groupe = suite de billes qui se touchent horizontalement ou verticalement consécutivement
    
    // méthode plusGrandGroupe : le score d’un joueur est la taille du plus grand groupe de bille de sa couleur
    // méthode multiplicationGroupes : le score d’un joueur est la multiplication de la taille de tous les groupes de billes de sa couleur

    // retourne l’ensemble des groupes de billes appartenant au joueur passé en paramètre
    func recupererGroupesBilles(joueur: Joueur) -> [ContenuCaseCollectionAssociatedT]{

    }

    // récupère le plus grand groupe de billes appartenant au joueur passé en paramètre
    func recupererPlusGrandGroupeBilles(joueur: Joueur) -> ContenuCaseCollectionAssociatedT{
      let tabGroupesBilles : [ContenuCaseCollectionAssociatedT] = recupererGroupesBilles(joueur : joueur)

    }

    // calcule les scores de chaque joueurs en utilisant la méthode par défault
    // c’est-à-dire la méthode passé en paramètre dans la fonction init()
    func calculScore() -> [Joueur:Int]{
      if(self.estMethodeCalculPlusGrandGroupe){
        return calculScore(estMethodeCalculPlusGrandGroupe: true)
      }
      else{
        return calculScore(estMethodeCalculPlusGrandGroupe: false)
      }
    }
    
    // calcule les scores en utilisant la méthode passée en paramètre
    func calculScore(estMethodeCalculPlusGrandGroupe: Bool) -> [Joueur:Int]{
      if(estMethodeCalculPlusGrandGroupe){
        
      }
      else{

      }
    }

    private func calculScorePlusGrandGroupe() -> [Joueur:Int]{
      //TODO
      //regarder comment faire un dico
    }

    private func calculScoreMultGroupes() -> [Joueur:Int]{
      //TODO
    }

}