// mainutils.swift
// permet de gérer plus facilement les interactions avec l’utilisateur

// récupère une valeur du clavier
// retourne la valeur si elle est de type Int
// nil sinon
func readInt() -> Int? {
    if let read = readLine() {
        if let int = Int(read) {
            return int
        }
    }
    return nil
}

// récupère le mode de calcul **valide**, choisi par l’utilisateur
// redemande à l’utilisateur sinon
// true -> méthode du plus grand groupe
// false -> méthode de la multiplication des groupes
func choixModeCalcul() -> Bool {
    print("Veuillez choisir le mode de calcul (1 ou 2) :")
    print("1 : méthode du plus grand groupe")
    print("2 : méthode de la multiplication des groupes")
    if let modeCalcul = readInt() {
        if modeCalcul == 1 {
            return true
        } else if modeCalcul == 2 {
            return false
        }
    }
    // on recommence jusqu’à ce que l’utilisateur rentre les bonnes valeurs
    return choixModeCalcul()
}

// récupère les coordonnées saisies par l’utilisateur
// retourne un tableau avec les coordonnées de début et le nombre de déplacements :
// [xDebut, yDebut, nbCasesDeplacement]
// debut correspond la bille à déplacer (x, y sont les axes du plateau)
// fin corresponds à l’emplacement où l’utilisateur veut la déplacer
// vérifie seulement si les coordonnées saisis sont bien des entiers
// sinon, redemande à l’utilisateur de saisir des coordonnées
// -> ne vérifie pas que les coordonnées appartiennent bien au plateau
func choixCoordonneesDeplacement() -> [Int] {
    print("Quelle case voulez-vous déplacer ? (veuillez saisir la valeur de x, appuyez sur Entrée puis saisissez la valeur de y)")
    if let xDebut = readInt(), let yDebut = readInt() {
        print("De combien de cases voulez-vous avancez ?")
        if let nbCasesDeplacement = readInt() {
            return [xDebut, yDebut, nbCasesDeplacement]
        }
    }
    // l’utilisateur n’a pas saisi de bonnes valeurs
    // il a saisi autre chose qu’uniquement des entiers
    return choixCoordonneesDeplacement()
}


// Affiche le plateau :
// les cases occupées par les billes noires doivent être marquées par un x
// les cases occupées par les billes blanches doivent être marquées par un o
// les cases inoccupées doivent être vide (espace)
// les valeurs des axes x et y doivent être affichés pour que l'utilisateur puisse faire son choix de déplacement
//
// Exemple d’affichage :
//
//                   y:
//     |x|o|x|x|o|o|   0
//   |x| | | | | | |x| 1
//   |o| | | | | | |o| 2
//   |o| | | | | | |x| 3
//   |x| | | | | | |o| 4
//   |x| | | | | | |x| 5
//   |o| | | | | | |o| 6
//     |o|x|x|o|x|o|   7
// x: 0 1 2 3 4 5 6 7
// si le type concret implémentant TMabula ne s'appelle pas Mabula, il faut changer
func afficherPlateau(jeu: Mabula) {
    print("                   y")
    for i in 0..<8 {
        for j in 0..<8 {
            let contenuCase = jeu.recupererContenuCase(x: j, y: i)
            if(j==0){
              print(" |", terminator: "")
            }
            else{
              print("|", terminator: "")
            }
            
            if let temp = contenuCase{
              if temp.estNoir {
                print("x", terminator: "")
              } else if temp.estBlanc {
                print("o", terminator: "")
              } else if temp.estInoccupe {
                print(" ", terminator: "")
              }
            }
            //print()   
        }
        print("| ", terminator: "")
        print(i)
    }
    print("x 0 1 2 3 4 5 6 7")
}
