// main.swift

let modeCalcul = choixModeCalcul()

var jeu = Mabula(modeCalcul: modeCalcul)

let deplacementPossible : Bool

var xDebut = 0
var yDebut = 0
var xFin = 0
var yFin = 0

while !jeu.partieFinie() {
    print("C’est au tour du joueur ", jeu.joueurActuel, ".", separator: "")
    afficherPlateau(jeu: jeu)

    deplacementPossible = false
    while !deplacementPossible {
        let coords = choixCoordonneesDeplacement()
        xDebut = coords[0]
        yDebut = coords[1]
        xFin = coords[2]
        yFin = coords[3]

        deplacementPossible = jeu.deplacementPossible(xDebut: xDebut, yDebut: yDebut, xFin: xFin, yFin: yFin)
    }

    jeu.deplacerBille(xDebut: xDebut, yDebut: yDebut, xFin: xFin, yFin: yFin)

    // on récupère le joueur actuel
    // si c'est nil on ne fait rien car la partie est finie
    if jeu.joueurActuel = jeu.prochainJoueur() {}
}

let scores = jeu.calculScore()
// on force avec ! mais il n’y a jamais nil :
// la spécification indique de renvoyer les scores sous la forme d’un dictionnaire [Joueur:Int]
// donc il y aura Joueur.blanc et Joueur.noir dans ce dictionnaire
if scores[Joueur.blanc]! > scores[Joueur.noir]! {
    print("Le joueur ", Joueur.blanc, " a gagné avec ", scores[Joueur.blanc]!, " points. Félicitations !!!", separator: "")
    print("Le joueur ", Joueur.noir, " a obtenu ", scores[Joueur.noir]!, " points.", separator: "")
} else {
    print("Le joueur ", Joueur.noir, " a gagné avec ", scores[Joueur.noir]!, " points. Félicitations !!!", separator: "")
    print("Le joueur ", Joueur.blanc, " a obtenu ", scores[Joueur.blanc]!, " points.", separator: "")
}

// fin du jeu
