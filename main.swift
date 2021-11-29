// Pré-partie

  // On commence par créer 2 joueur
print("Veuillez entrer le nom du premier joueur") 
var joueur1 : joueurType = joueurType(nomJoueur: readLine())
print("Veuillez entrer le nom du second joueur")
var joueur2 : joueurType = joueurType(nomJoueur: readLine())

  // On choisi le mode de jeu : Classique ou Avertis
  //let mode : String = "Classique" // ou "Avertis"
print("veuillez tapper 1 si vous voulez jouer en mode avancé et 0 pour le mode classique")
let mode : String = readLine()
let choixMode : Bool = mode == "1"

var jeu : quartoType = quartoType(j1 : joueur1, j2 : joueur2, estModeDifficile : choixMode)

jeu.run()
