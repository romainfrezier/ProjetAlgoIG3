protocol pieceProtocol{
  
  // pièce claire ou non (sombre)
  var estClair : Bool {get}

  // pièce ronde ou non (carré)
  var estRonde : Bool {get}

  // pièce haute ou non (basse)
  var estHaute : Bool {get}

  // pièce pleine ou non (creuse)
  var estPleine : Bool {get}

  // pièce placée ou non (en main)
  var estPlace : Bool {get}


  // Crée l'instance de pieceProtocol en assignant des caractéristiques à la pièce 
  init(estClair : Bool, estRonde : Bool, estHaute : Bool,estPleine : Bool)
}