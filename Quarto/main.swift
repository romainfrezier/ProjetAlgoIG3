import Foundation

/*########################## Pré-partie ##########################*/

// On commence par créer 2 joueur
var nomJoueur1 : String = ""
//Tant que l'utilisateur ne rentre pas de nom pour le joueur1 ou qu'il rentre un nom vide, on lui demande un nom pour ce joueur
repeat{
  print("Veuillez entrer le nom du premier joueur") 
  nomJoueur1 = readLine()!
}
while(nomJoueur1 == "")
//On crée le joueur1 avec le nom donné par l'utilisateur en parametre
var joueur1 : joueurType = joueurType(nomJoueur: nomJoueur1)

var nomJoueur2 : String = ""
//Tant que l'utilisateur ne rentre pas de nom pour le joueur2 ou qu'il rentre un nom vide, on lui demande un nom pour ce joueur
repeat{
  print("Veuillez entrer le nom du second joueur")
  nomJoueur2 = readLine()!
}
while(nomJoueur2 == "")
//On crée le joueur2 avec le nom donné par l'utilisateur en parametre
var joueur2 : joueurType = joueurType(nomJoueur: nomJoueur2)

// On choisi le mode de jeu : Classique ou Avancé
let mode : String = ""
// On demande a l'utilisateur le mode de jeu qu'il veut
// Tant qu'il répond autre chose que 0 ou 1, on lui redemande le mode de jeu qu'il veut
repeat{
  print("veuillez tapper 1 si vous voulez jouer en mode avancé et 0 
pour le mode classique")
  mode = readLine()!
}
while(mode == "")

// On crée une instance de quarto avec les parametres récupérés auprès de l'utilisateur
var jeu : quartoType = quartoType(j1 : joueur1, j2 : joueur2, estModeDifficile : mode == "1")

// #################### Déroulement de la Partie ####################

// Tant que le match n'est pas terminé (égalité ou victoire d'un des joueur), on déroule le jeu

while !self.finVictoire(estModeDifficile : self.estModeDifficile) && !self.finEgalite() {

  // Le joueur tiré au sort choisi une pièce (a la premiere itération, puis on change a chaque tour la personne qui joue)
  afficherJoueurActuel()
  afficherPieceDisponibles()
  var pieceChoisie : String = ""
  // On demande au joueur actuel de choisir une piece pour que son adversaire la joue, tant qu'il ne donne pas une réponse satisfaisante, on lui redemande
  repeat{
    print("Veuillez indiquer la piece que vous voulez selectionner pour votre ennemi")
    pieceChoisie = readLine()!
  }
  while(pieceChoisie == "") 
  // On selectionne la piece choisie par le joueur pour qu'elle puisse être joué par son adversere
  self.currentPlayer.choisirPiece(piece: pieceChoisie)
  // On passe au joueur suivant
  self.currentPlayer.next()
  afficherJoueurActuel()
  afficherPieceSelectionne()
  // On demande a l'utilisateur les coordonnées où il veut poser sa piece à jouer
  print("Veuillez indiquer les coordonnées où vous voulez placer votre piece")
  var x : String = ""
  repeat{
    print("x : ")
    x = readLine()!
  }
  while(x <=4)

  var y : String = ""
  repeat{
    print("y : ")
    y = readLine()!
  }
  while(y <= 4)
  // On récupère la case où le joueur veut jouer, puis on le fait jouer dans la case voulue
  self.currentPlayer.placerPiece(pos :  jeu.collectionCase.getCaseByCoord(x : x, y : y))
}

// ######################## Post-partie ########################
// Le joueur qui remplie une des conditions de victoire à gagner sinon c'est une égalité
finPartie(estVictoire : self.finVictoire(estModeDifficile : self.estModeDifficile))

// ##################### Fonctions d'affichage #####################

// Permet d'afficher une piece grâce aux caractères Unicode
func afficherPiece(piece : pieceProtocol){
  if piece.estHaute && piece.estRonde && !piece.estPleine && !piece.estClair{
    //Grand Rond Troue Noir
    print("\u{1F785} B")
  }
  else if piece.estHaute && !piece.estRonde && !piece.estPleine && !piece.estClair{
    //Grand Carre Troue Noir
    print("\u{25FB} B")
  }
  else if !piece.estHaute && !piece.estRonde && !piece.estPleine && !piece.estClair{
    //Petit Carre Troue Noir
    print("\u{25AB} B")
  }
  else if !piece.estHaute && !piece.estRonde && piece.estPleine && !piece.estClair{
    //Petit Carre Plein Noir
    print("\u{25AA} B")
  }
  else if !piece.estHaute && piece.estRonde && !piece.estPleine && !piece.estClair{
    //Petit Rond Troue Noir
    print("\u{25E6} B")
  }
  else if !piece.estHaute && piece.estRonde && piece.estPleine && !piece.estClair{
    //Petit Rond Plein Noir
    print("\u{1F784} B")
  }
  else if piece.estHaute && !piece.estRonde && piece.estPleine && !piece.estClair{
    //Grand Carre Plein Noir
    print("\u{25FC} B")
  }
  else if piece.estHaute && piece.estRonde && piece.estPleine && !piece.estClair{
    //Grand Rond Plein Noir
    print("\u{25CF} B")
  }
  else if piece.estHaute && piece.estRonde && !piece.estPleine && piece.estClair{
    //Grand Rond Troue Blanc
    print("\u{1F785} W")
  }
  else if piece.estHaute && !piece.estRonde && !piece.estPleine && piece.estClair{
    //Grand Carre Troue Blanc
    print("\u{25FB} W")
  }
  else if !piece.estHaute && !piece.estRonde && !piece.estPleine && piece.estClair{
    //Petit Carre Troue Blanc
    print("\u{25AB} W")
  }
  else if !piece.estHaute && !piece.estRonde && piece.estPleine && piece.estClair{
    //Petit Carre Plein Blanc
    print("\u{25AA} W")
  }
  else if !piece.estHaute && piece.estRonde && !piece.estPleine && piece.estClair{
    //Petit Rond Troue Blanc
    print("\u{25E6} W")
  }
  else if !piece.estHaute && piece.estRonde && piece.estPleine && piece.estClair{
    //Petit Rond Plein Blanc
    print("\u{1F784} W")
  }
  else if piece.estHaute && !piece.estRonde && piece.estPleine && piece.estClair{
    //Grand Carre Plein Blanc
    print("\u{25FC} W")
  }
  else if piece.estHaute && piece.estRonde && piece.estPleine && piece.estClair{
    //Grand Rond Plein Blanc
    print("\u{25CF} W")
  }
}

// Permet d'afficher toutes les pièces disponibles pour que les joueurs puissent jouer en sachant les pieces qu'ils peuvent jouer
func afficherPieceDisponibles(){
  // pour chaque pièce restante, l'afficher
  print("Pieces disponibles : \n")
  for el in jeu.collectionPiece.getAvailablePieces(){
    afficherPiece(el)
    print("\n")
  }
}

// Affiche le joueur Actuel
func afficherJoueurActuel(){
  print("C'est a \(jeu.currentPlayer) de jouer !")
}

// Affiche le plateau avec les pieces déjà joué sur le plateau
func afficherPlateau(collection : collectionCaseProtocol){
  var i = 0
  // afficher le plateau dans l'état actuel
  for element in jeu.collectionCase{
    if i%4 == 0{
      print("\n")
    }
    if element.piece != nil{
      print(element.piece) 
    }
    else{
      print("x")
    }
    print(" ")
    i += 1
  }
  

}

// Affiche la piece qui a été selectionné
func afficherPieceSelectionne(){
  print("La piece selectionnée est : ")
  // afficher la piece choisi par l'utilisateur
  afficherPiece(piece : jeu.selectedPiece)
}

// finPartie : quartoProtocol x Bool -> quartoProtocol  
// Fonction qui met un terme a la partie, elle indique qu'il y a égalité si estVictoire est false, et indique qu'il y a Quarto et qui a gagné lorsque le paramètre estVictoire est vrai (la personne qui a gagné est obligatoirement la personne stockée dans currentPlayer)
// Post : propose de relancer une nouvelle partie en utilisant la fonction resetGame prévu a cet effet
func finPartie(estVictoire : Bool){
  // afficher le resultat de la partie
  if jeu.finVictoire(){
    print("Super ! Le vainqueur est \(jeu.currentPlayer)")
  }
  else{print("Dommage, égalité")}

  print("Voulez-vous relancer une partie ? (répondez oui ou non")
  var rep : String = readLine()!
  while(rep != "oui" && rep != "non"){
    print("Voulez-vous relancer une partie ? (répondez oui ou non")
    rep = readLine()!
  }
  if(rep == "oui"){
    jeu.resetGame()
  }
  else{
    exit(0)
  }
}