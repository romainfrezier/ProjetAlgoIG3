// Pré-partie

var jeu : quartoType = quartoType()



  // On commence par créer 2 joueur
print("Veuillez entrer le nom du premier joueur") 
var joueur1 : joueurType = joueurType(nomJoueur: readLine())
print("Veuillez entrer le nom du second joueur")
var joueur2 : joueurType = joueurType(nomJoueur: readLine())

  // On choisi le mode de jeu : Classique ou Avertis
  //let mode : String = "Classique" // ou "Avertis"
print("veuillez tapper 1 si vous voulez jouer en mode avancé et 0 pour le mode classique")
let mode : String = readLine()
let choixMode : Bool
jeu.estModeDifficile = mode == "1"


  // Tirage au sort du joueur qui va jouer le premier
let tirage : Int = Int.random(in: 1..<2)



// Partie : Tant que le match n'est pas terminé (égalité ou victoire d'un des joueur)

while !finVictoire(estModeDifficile : choixMode) && nombrePieceRestante != 0 {
  // Le joueur tiré au sort choisi une pièce

  // Le joueur suivant place la pièce puis en choisi une autre

  // Le premier joueur place la pièce tiré par le joueur précédent

}


// Post-partie

  // Le joueur qui remplie une des conditions de victoire à gagner sinon c'est une égalité