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
jeu.estModeDifficile = mode == "1"
let choixMode : Bool = jeu.estModeDifficile

  // Tirage au sort du joueur qui va jouer le premier
jeu.tirageSort(joueur1 : joueur1, joueur2 : joueur2)


// Partie : Tant que le match n'est pas terminé (égalité ou victoire d'un des joueur)

while !jeu.finVictoire(estModeDifficile : choixMode) && !jeu.finEgalite() {

  // Le joueur tiré au sort choisi une pièce
  jeu.currentPlayer.choisirPiece(piece: )
  jeu.currentPlayer.next()

  // Le joueur suivant place la pièce puis en choisi une autre
  jeu.currentPlayer.placerPiece(pos: )
  jeu.currentPlayer.choisirPiece(piece: )
  jeu.currentPlayer.next()

  // Le premier joueur place la pièce tiré par le joueur précédent
  jeu.currentPlayer.placerPiece(pos: )

}


// Post-partie

  // Le joueur qui remplie une des conditions de victoire à gagner sinon c'est une égalité

jeu.finPartie(estVictoire : Bool)