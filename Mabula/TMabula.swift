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

class Mabula {

    var joueurActuel : Joueur

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
        // Init des variables
        self.estMethodeCalculPlusGrandGroupe = estMethodeCalculPlusGrandGroupe

        // Initialiser le plateau

        self.grid = Plateau()

        // On impose le joueur qui commence
        self.joueurActuel = joueurActuel
        creerOrdreBilles()

    }

    // Initialise la partie de la même manière mais le joueur est choisi au hasard
    init(estMethodeCalculPlusGrandGroupe: Bool){
        // Init des variables
        self.estMethodeCalculPlusGrandGroupe = estMethodeCalculPlusGrandGroupe

        // Déterminer le joueur qui commence

        let joueur : Int = Int.random(in: 0..<2)
        if joueur == 0 {
            joueurActuel = Joueur.blanc
        }
        else {
            joueurActuel = Joueur.noir
        }

        // Initialiser le plateau

        self.grid = Plateau()

        creerOrdreBilles()

    }

    private func creerOrdreBilles(){
        var tab : [Int] = Array(repeating : 0, count : 24)

        var a : Bool
        repeat{
            // Invariant : a = true tant qu'on a pas placé toute les billes
            // condition d'arret : a
            a = placerBillesRecur(array : &tab, index : 0, serie : 0, caseSerie : -1, nbFirstAvailable : 12, nbSecondAvailable : 12)
        }
        while(!a)
        //print(tab)

        var cptFirst : Int = 0
        var cptSecond : Int = 0
        var cptThird : Int = 0
        var cptFourth : Int = 0
        for i in 0...23{
            if(i<=5){
                cptFirst += 1
                remplirCase(x:cptFirst,y:0,val:tab[i])
            }
            else if(i>5 && i <= 11){
                cptSecond += 1
                remplirCase(x:7,y:cptSecond,val:tab[i])
            }
            else if(i>11 && i<=17){
                cptThird += 1
                remplirCase(x:7-cptThird,y:7,val:tab[i])
            }
            else{
                cptFourth += 1
                remplirCase(x:0,y:7-cptFourth,val:tab[i])
            }
        }
    }

    private func remplirCase(x: Int,y: Int,val: Int){
        if let grid = self.grid.getContenuCase(x:x,y:y) {
            grid.estInoccupe = false
        }
        if(val==0){
            // alors on affecte le blanc
            if let temp = self.grid.getContenuCase(x:x,y:y){
              temp.estBlanc = true
            }
            
        }
        else{
            // alors on affecte le noir
            if let temp = self.grid.getContenuCase(x:x,y:y){
              temp.estNoir = true
            }
        }
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
            return placerBillesRecur(array : &array, index : index+1, serie : 1, caseSerie : nb, nbFirstAvailable : nb == 0 ? nbFirstAvailable-1 : nbFirstAvailable, nbSecondAvailable : nb == 1 ? nbSecondAvailable-1 : nbSecondAvailable)
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
        return placerBillesRecur(array : &array, index : index+1, serie : caseSerie == rand ? 2 : 1, caseSerie : rand, nbFirstAvailable : rand == 0 ? nbFirstAvailable-1 : nbFirstAvailable, nbSecondAvailable : rand == 1 ? nbSecondAvailable-1 : nbSecondAvailable)
    }

    // récupère le contenu de la case à la position (x, y) sur le plateau
    // ContenuCase est le type concret implémentant TContenuCase (cf. associatedtype)
    //Erreur de conception ici recupererContenuCase doit renvoyer ContenuCase?
    func recupererContenuCase(x: Int, y: Int) -> ContenuCase?{
      if let temp = self.grid.getContenuCase(x: x, y: y){
        return temp
      }
      else{
        return nil
      }
    }

    // La fonction renvoie quel joueur jouera au prochain tour (en alternance, sauf exceptions)
    // Si un joueur ne peut pas déplacer de bille, il ne peut pas jouer et perd son tour
    // Si aucun ne peut jouer, la partie est finie donc la fonction renvoie nil
    // prochainJoueur() == nil <=> !(peutJouer(joueur: Joueur.noir) || peutJouer(joueur: Joueur.blanc))
    func prochainJoueur() -> Joueur?{
        var prochainJoueur : Joueur?
        guard ( (peutJouer(joueur: Joueur.noir)) || (peutJouer(joueur: Joueur.blanc)) ) else { return nil }
        if !(peutJouer(joueur: Joueur.noir)) && (joueurActuel == Joueur.blanc) {
            prochainJoueur = Joueur.blanc
        }
        else if !(peutJouer(joueur: Joueur.blanc)) && (joueurActuel == Joueur.noir) {
            prochainJoueur = Joueur.noir
        }
        else {
            if self.joueurActuel == Joueur.blanc {
                prochainJoueur = Joueur.noir
            }
            else {
                prochainJoueur = Joueur.blanc
            }
        }
        return prochainJoueur
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
        var possedeBilleSurBord : Bool = false
        var tabContenuCaseJoueur : List = List()
        var tempContenuCase : ContenuCase?
        // Si le joueur n'a plus de billes sur le bord, renvoie directement false
        if(joueur == Joueur.blanc){
            var cptFirst : Int = 0
            var cptSecond : Int = 0
            var cptThird : Int = 0
            var cptFourth : Int = 0
            for i in 0...23{
              if(i<=5){
                  cptFirst += 1
                  if let tempContenuCase = self.grid.getContenuCase(x:cptFirst,y:0){
                    if(tempContenuCase.estBlanc){
                      possedeBilleSurBord = true
                      tabContenuCaseJoueur.ajouterContenuCase(contenuCase: tempContenuCase)
                    }
                  }        
                }
                else if(i>5 && i <= 11){
                    cptSecond += 1
                    if let tempContenuCase = self.grid.getContenuCase(x:7,y:cptSecond){
                      if(tempContenuCase.estBlanc){
                        possedeBilleSurBord = true
                        tabContenuCaseJoueur.ajouterContenuCase(contenuCase: tempContenuCase)
                    }
                  }  
                }
                else if(i>11 && i<=17){
                  cptThird += 1
                  if let tempContenuCase = self.grid.getContenuCase(x:cptThird,y:7){
                    if(tempContenuCase.estBlanc){
                      possedeBilleSurBord = true
                      tabContenuCaseJoueur.ajouterContenuCase(contenuCase: tempContenuCase)
                    }
                  }  
                }
                else{
                    cptFourth += 1
                    if let tempContenuCase = self.grid.getContenuCase(x:0,y:cptFourth){
                      if(tempContenuCase.estBlanc){
                        possedeBilleSurBord = true
                        tabContenuCaseJoueur.ajouterContenuCase(contenuCase: tempContenuCase)
                      }
                    }  
                }
            }
        }
        else{
            var cptFirst : Int = 0
            var cptSecond : Int = 0
            var cptThird : Int = 0
            var cptFourth : Int = 0
            for i in 0...23{
                if(i<=5){
                    cptFirst += 1
                    if let tempContenuCase = self.grid.getContenuCase(x:cptFirst,y:0){
                      if(tempContenuCase.estNoir){
                        possedeBilleSurBord = true
                        tabContenuCaseJoueur.ajouterContenuCase(contenuCase: tempContenuCase)
                      }
                    }
                }
                else if(i>5 && i <= 11){
                    cptSecond += 1
                    if let tempContenuCase = self.grid.getContenuCase(x:7,y:cptSecond){
                      if(tempContenuCase.estNoir){
                        possedeBilleSurBord = true
                        tabContenuCaseJoueur.ajouterContenuCase(contenuCase: tempContenuCase)
                      }
                    }
                    
                }
                else if(i>11 && i<=17){
                    cptThird += 1
                    if let tempContenuCase = self.grid.getContenuCase(x:cptThird,y:7){
                      if(tempContenuCase.estNoir){
                        possedeBilleSurBord = true
                        tabContenuCaseJoueur.ajouterContenuCase(contenuCase: tempContenuCase)
                      }
                    }
                }
                else{
                    cptFourth += 1
                    if let tempContenuCase = self.grid.getContenuCase(x:0,y:cptFourth){
                      if(tempContenuCase.estNoir){
                        possedeBilleSurBord = true
                        tabContenuCaseJoueur.ajouterContenuCase(contenuCase: tempContenuCase)
                      }
                    }    
                }
            }
        }
        if(!possedeBilleSurBord){
            return false
        }
        //On verifie si le joueur a des billes sur le bord mais qu'elle ne peuvent pas être déplacés d'une case
        var it = tabContenuCaseJoueur.makeIterator1D()
        repeat{
            // condition d'arret : tempContenuCase == nil
            if let temp = it.next(){
              if(deplacementPossible(xDebut: temp.x,yDebut: temp.y, nbCasesDeplacement:1)){
                return true
              }
              tempContenuCase = temp
            }
            else{
              tempContenuCase = nil
            }
        }
        while(tempContenuCase != nil)
        return false
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
        // cas ou les déplacement ne sont pas possibles :
        // La ligne ou la bille doit avancer est pleine
        // une bille est sur le bord et doit etre poussé lors du déplacement vers le bord (ce qui ne doit jamais arriver)
        var collectionCases : List = List()
        var tempContenuCase : ContenuCase
        if(yDebut==0 || yDebut==7){
            for i in 0...5{
                tempContenuCase = self.grid.getContenuCase(x:xDebut,y:i+1)!
                if(tempContenuCase.estInoccupe){
                    collectionCases.ajouterContenuCase(contenuCase: tempContenuCase)
                }
            }
        }
        else if(xDebut==0 || xDebut==7){
            for i in 0...5{
                tempContenuCase = self.grid.getContenuCase(x:i+1,y:yDebut)!
                if(tempContenuCase.estInoccupe){
                    collectionCases.ajouterContenuCase(contenuCase: tempContenuCase)
                }
            }
        }
        if(nbCasesDeplacement>collectionCases.count){
            return false
        }
        else{
            return true
        }
    }

    // si deplacementPossible(xDebut: xDebut, yDebut: yDebut, nbcasesDeplacement: nbCasesDeplacement)
    // alors la fonction déplace la bille sur le plateau (et pousse éventuellement d’autres billes sur la même ligne)
    // sinon, ne fait rien
    func deplacerBille(xDebut: Int, yDebut: Int, nbCasesDeplacement: Int){
        guard(deplacementPossible(xDebut:xDebut,yDebut:yDebut,nbCasesDeplacement:nbCasesDeplacement)) else {return}
        var currentItem : Int
        if(joueurActuel == Joueur.blanc){
            currentItem = 0
        }
        else{
            currentItem = 1
        }
        if(joueurActuelPeutJouer(x:xDebut,y:yDebut)){
            deplacerBilleRecur(xDebut : xDebut, yDebut: yDebut, nbCasesDeplacement : nbCasesDeplacement, currentItem: currentItem)
        }
    }

    private func joueurActuelPeutJouer(x:Int,y:Int) -> Bool{
        if(self.grid.getContenuCase(x:x,y:y)!.estBlanc){
            return self.grid.getContenuCase(x:x,y:y)!.estBlanc == (joueurActuel == Joueur.blanc)
        }
        else if(!(self.grid.getContenuCase(x:x,y:y)!.estBlanc)){
            return self.grid.getContenuCase(x:x,y:y)!.estNoir == (joueurActuel == Joueur.noir)
        }
        return false
    }


    //CurrentItem = 0 si blanc, 1 si noir
    private func deplacerBilleRecur(xDebut: Int, yDebut: Int, nbCasesDeplacement: Int, direction : String = "init", currentItem : Int?){
        //print(xDebut, yDebut, nbCasesDeplacement,direction,currentItem)
        var directionRecur : String = ""
        if(direction == "init"){
            if(xDebut == 0){
                directionRecur = "droite"
            }
            else if(xDebut == 7){
                directionRecur = "gauche"
            }
            else if(yDebut == 0){
                directionRecur = "bas"
            }
            else if(yDebut == 7){
                directionRecur = "haut"
            }
        }
        else{
            directionRecur = direction
        }
        //print(directionRecur)

        if(nbCasesDeplacement > 0){
            if(directionRecur == "droite"){
                let temp = self.grid.getContenuCase(x:xDebut+1,y:yDebut)
                let bool : Bool = currentItem == 0 ? true : false
                if(temp!.estInoccupe){
                
                    self.grid.getContenuCase(x:xDebut,y:yDebut)!.estInoccupe = true
                    self.grid.getContenuCase(x:xDebut,y:yDebut)!.estBlanc = false
                    self.grid.getContenuCase(x:xDebut,y:yDebut)!.estNoir = false
                
                    temp!.estInoccupe = false
                    if(bool){
                        temp!.estBlanc = true
                    }
                    else{
                        temp!.estNoir = true
                    }
                }
                else{
                    self.grid.getContenuCase(x:xDebut,y:yDebut)!.estInoccupe = true
                    self.grid.getContenuCase(x:xDebut,y:yDebut)!.estBlanc = false
                    self.grid.getContenuCase(x:xDebut,y:yDebut)!.estNoir = false
                    var currentItem : Int
                    if(temp!.estBlanc){
                        currentItem = 0
                    }else{
                        currentItem = 1
                    }

                    temp!.estInoccupe = false
                    if(bool){
                        temp!.estBlanc = true
                    }
                    else{
                        temp!.estNoir = true
                    }
                    deplacerBilleRecur(xDebut: xDebut+1, yDebut: yDebut, nbCasesDeplacement: 1, direction : directionRecur, currentItem : currentItem)
                }

                deplacerBilleRecur(xDebut: xDebut+1, yDebut: yDebut, nbCasesDeplacement: nbCasesDeplacement-1, direction : directionRecur, currentItem : currentItem)
            }

            if(directionRecur == "gauche"){
                let temp = self.grid.getContenuCase(x:xDebut-1,y:yDebut)
                let bool : Bool = currentItem == 0 ? true : false
                if(temp!.estInoccupe){
                    self.grid.getContenuCase(x:xDebut,y:yDebut)!.estInoccupe = true
                    self.grid.getContenuCase(x:xDebut,y:yDebut)!.estBlanc = false
                    self.grid.getContenuCase(x:xDebut,y:yDebut)!.estNoir = false
                    temp!.estInoccupe = false
                    if(bool){
                        temp!.estBlanc = true
                    }
                    else{
                        temp!.estNoir = true
                    }
                }
                else{
                    
                    self.grid.getContenuCase(x:xDebut,y:yDebut)!.estInoccupe = true
                    self.grid.getContenuCase(x:xDebut,y:yDebut)!.estBlanc = false
                    self.grid.getContenuCase(x:xDebut,y:yDebut)!.estNoir = false
                    
                    var currentItem : Int
                    if(temp!.estBlanc){
                        currentItem = 0
                    }else{
                        currentItem = 1
                    }

                    temp!.estInoccupe = false
                    if(bool){
                        temp!.estBlanc = true
                    }
                    else{
                        temp!.estNoir = true
                    }
                    deplacerBilleRecur(xDebut: xDebut-1, yDebut: yDebut, nbCasesDeplacement: 1, direction : directionRecur, currentItem : currentItem)
                }

                deplacerBilleRecur(xDebut: xDebut-1, yDebut: yDebut, nbCasesDeplacement: nbCasesDeplacement-1, direction : directionRecur, currentItem : currentItem)
            }

            if(directionRecur == "bas"){
                let temp = self.grid.getContenuCase(x:xDebut,y:yDebut+1)
                let bool : Bool = currentItem == 0 ? true : false
                if(temp!.estInoccupe){
                    self.grid.getContenuCase(x:xDebut,y:yDebut)!.estInoccupe = true
                    self.grid.getContenuCase(x:xDebut,y:yDebut)!.estBlanc = false
                    self.grid.getContenuCase(x:xDebut,y:yDebut)!.estNoir = false
                    temp!.estInoccupe = false
                    if(bool){
                        temp!.estBlanc = true
                    }
                    else{
                        temp!.estNoir = true
                    }
                }
                else{
                    
                    self.grid.getContenuCase(x:xDebut,y:yDebut)!.estInoccupe = true
                    self.grid.getContenuCase(x:xDebut,y:yDebut)!.estBlanc = false
                    self.grid.getContenuCase(x:xDebut,y:yDebut)!.estNoir = false
                    
                    var currentItem : Int
                    if(temp!.estBlanc){
                        currentItem = 0
                    }else{
                        currentItem = 1
                    }

                    temp!.estInoccupe = false
                    if(bool){
                        temp!.estBlanc = true
                    }
                    else{
                        temp!.estNoir = true
                    }
                    deplacerBilleRecur(xDebut: xDebut, yDebut: yDebut+1, nbCasesDeplacement: 1, direction : directionRecur, currentItem : currentItem)
                }

                deplacerBilleRecur(xDebut: xDebut, yDebut: yDebut+1, nbCasesDeplacement: nbCasesDeplacement-1, direction : directionRecur, currentItem : currentItem)
            }

            if(directionRecur == "haut"){
                let temp = self.grid.getContenuCase(x:xDebut,y:yDebut-1)
                let bool : Bool = currentItem == 0 ? true : false
                if(temp!.estInoccupe){
                    self.grid.getContenuCase(x:xDebut,y:yDebut)!.estInoccupe = true
                    self.grid.getContenuCase(x:xDebut,y:yDebut)!.estBlanc = false
                    self.grid.getContenuCase(x:xDebut,y:yDebut)!.estNoir = false
                    temp!.estInoccupe = false
                    if(bool){
                        temp!.estBlanc = true
                    }
                    else{
                        temp!.estNoir = true
                    }
                }
                else{
                    self.grid.getContenuCase(x:xDebut,y:yDebut)!.estInoccupe = true
                    self.grid.getContenuCase(x:xDebut,y:yDebut)!.estBlanc = false
                    self.grid.getContenuCase(x:xDebut,y:yDebut)!.estNoir = false
                    
                    var currentItem : Int
                    if(temp!.estBlanc){
                        currentItem = 0
                    }else{
                        currentItem = 1
                    }

                    temp!.estInoccupe = false
                    if(bool){
                        temp!.estBlanc = true
                    }
                    else{
                        temp!.estNoir = true
                    }
                    deplacerBilleRecur(xDebut: xDebut, yDebut: yDebut-1, nbCasesDeplacement: 1, direction : directionRecur, currentItem : currentItem)
                }

                deplacerBilleRecur(xDebut: xDebut, yDebut: yDebut-1, nbCasesDeplacement: nbCasesDeplacement-1, direction : directionRecur, currentItem : currentItem)
            }
        }
        else{
          let tmp = self.grid.getContenuCase(x:xDebut,y:yDebut)
          tmp!.estInoccupe = false

          if(currentItem==0){
            tmp!.estBlanc = true
          }else{
            tmp!.estNoir = true
          }
        }
    }

    // comment calculer les scores :
    // un groupe = suite de billes qui se touchent horizontalement ou verticalement consécutivement

    // méthode plusGrandGroupe : le score d’un joueur est la taille du plus grand groupe de bille de sa couleur
    // méthode multiplicationGroupes : le score d’un joueur est la multiplication de la taille de tous les groupes de billes de sa couleur
    func recupererGroupesBilles(joueur: Joueur) -> [List]{

        var alreadyChecked : [[Bool]] = [[Bool]](repeating: [Bool](repeating: false, count: 8), count: 8)

        var groupes : [List] = []

        var tabReturn : List = List()

        var couleur : Bool = false

        if(joueur == Joueur.blanc){
          couleur = true
        }


        for i in 0...7{
            for j in 0...7{
                let current = self.grid.getContenuCase(x:i,y:j)
                if let current = current{
                  if(!(current.estInoccupe) && current.estBlanc==couleur && alreadyChecked[i][j] == false){
                    groupes.append(getGroupesAux(alreadyChecked : &alreadyChecked,x:j,y:i,val:couleur, tabReturn : &tabReturn))
                    tabReturn = List()
                  }
                }
                
            }
        }
        return groupes
    }

    @discardableResult func getGroupesAux(alreadyChecked : inout [[Bool]],x:Int,y:Int,val:Bool, tabReturn : inout List) -> List {
        //current
        if(alreadyChecked[y][x] == false){
            alreadyChecked[y][x] = true
            if(!(self.grid.getContenuCase(x:x,y:y)!.estInoccupe) && self.grid.getContenuCase(x:x,y:y)!.estBlanc == val){
                tabReturn.ajouterContenuCase(contenuCase: self.grid.getContenuCase(x:x,y:y)!)
                getGroupesAux(alreadyChecked : &alreadyChecked,x:x,y:y,val:val, tabReturn : &tabReturn)
            }
        }
        //y-1 = au dessus
        if(y-1>=0 && alreadyChecked[y-1][x] == false){
            alreadyChecked[y-1][x] = true
            if(!(self.grid.getContenuCase(x:x,y:y-1)!.estInoccupe) && self.grid.getContenuCase(x:x,y:y-1)!.estBlanc == val){
                tabReturn.ajouterContenuCase(contenuCase: self.grid.getContenuCase(x:x,y:y-1)!)
                getGroupesAux(alreadyChecked : &alreadyChecked,x:x,y:y-1,val:val, tabReturn : &tabReturn)
            }
        }
        //y+1 en dessous
        if(y+1<8 && alreadyChecked[y+1][x] == false){
            alreadyChecked[y+1][x] = true
            if(!(self.grid.getContenuCase(x:x,y:y+1)!.estInoccupe) && self.grid.getContenuCase(x:x, y: y+1)!.estBlanc == val){
                tabReturn.ajouterContenuCase(contenuCase: self.grid.getContenuCase(x:x,y:y+1)!)
                getGroupesAux(alreadyChecked : &alreadyChecked,x:x,y:y+1,val:val, tabReturn : &tabReturn)
            }
        }
        //x-1 a gauche
        if(x-1>=0 && alreadyChecked[y][x-1] == false){
            alreadyChecked[y][x-1] = true
            if(!(self.grid.getContenuCase(x:x-1,y:y)!.estInoccupe) && self.grid.getContenuCase(x:x-1,y:y)!.estBlanc == val){
                tabReturn.ajouterContenuCase(contenuCase: self.grid.getContenuCase(x:x-1,y:y)!)
                getGroupesAux(alreadyChecked : &alreadyChecked,x:x-1,y:y,val:val, tabReturn : &tabReturn)
            }
        }
        //x+1 a droite
        if(x+1<8 && alreadyChecked[y][x+1] == false){
            alreadyChecked[y][x+1] = true
            if(!(self.grid.getContenuCase(x:x+1,y:y)!.estInoccupe) && self.grid.getContenuCase(x:x+1,y:y)!.estBlanc == val){
                tabReturn.ajouterContenuCase(contenuCase: self.grid.getContenuCase(x:x+1,y:y)!)
                getGroupesAux(alreadyChecked : &alreadyChecked,x:x+1,y:y,val:val, tabReturn : &tabReturn)
            }
        }
        return tabReturn
    }

    // récupère le plus grand groupe de billes appartenant au joueur passé en paramètre
    func recupererPlusGrandGroupeBilles(joueur: Joueur) -> List{
        let tabGroupesBilles : [List] = recupererGroupesBilles(joueur : joueur)
        var max : List = List()
        for element in tabGroupesBilles {
            if element.count > max.count {
                max = element
            }
        }
        return max
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
            return calculScorePlusGrandGroupe()
        }
        else{
            return calculScoreMultGroupes()
        }
    }

    private func calculScorePlusGrandGroupe() -> [Joueur:Int]{
        let score : [Joueur:Int] = [Joueur.blanc : recupererPlusGrandGroupeBilles(joueur: Joueur.blanc).count, Joueur.noir : recupererPlusGrandGroupeBilles(joueur: Joueur.noir).count]
        return score
    }

    private func calculScoreMultGroupes() -> [Joueur:Int]{
        // Calcul du score du joueur blanc
        var scoreBlanc : Int = 1
        let collectionBlanc : [List] = recupererGroupesBilles(joueur: Joueur.blanc)
        var itBlanc = collectionBlanc.makeIterator()
        //var temp : List
        repeat{
          // condition d'arret : itBlanc.next() == nil
          if let temp = itBlanc.next(){
            if temp.count != 0{
              scoreBlanc *= temp.count
            //itBlanc = itBlanc.next()
            }  
          }   
        }
        while (itBlanc.next() != nil)

        // Calcul du score du joueur noir
        var scoreNoir : Int = 1
        let collectionNoir : [List] = recupererGroupesBilles(joueur: Joueur.noir)
        var itNoir = collectionNoir.makeIterator()
        repeat{
          // condition d'arret : itBlanc.next() == nil
          if let temp = itNoir.next(){
            if temp.count != 0{
              scoreNoir *= temp.count
              //itNoir = itNoir.next()
            }
          }
        }
        while (itNoir.next() != nil)

        // attribution des scores respectifs à chaque joueur
        let score : [Joueur:Int] = [Joueur.blanc : scoreBlanc, Joueur.noir :scoreNoir]
        return score
    }

}