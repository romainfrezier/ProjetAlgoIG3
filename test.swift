import Foundation

/*
print("Voulez-vous relancer une partie ? (répondez oui ou non")
  var rep : String = readLine()!
  while(rep != "oui" && rep != "non"){
    print("Voulez-vous relancer une partie ? (répondez oui ou non")
    rep = readLine()!
  }
  if(rep == "oui"){
    print("ok")
  }
  else{
    exit(0)
  }
*/

/*var nomJoueur1 : String = ""
repeat{
  print("Veuillez entrer le nom du premier joueur") 
  nomJoueur1 = readLine()!
}
while(nomJoueur1 == "")
*/

//print(Int.random(in: 0..<2))

var tab : [Int] = Array(repeating : 0, count : 24)

//Premiere iteration
/*
@discardableResult func fillTab(array : inout [Int], index : Int, serie : Int, caseSerie : Int) -> Bool{
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
    array[index] = nb 
    return fillTab(array : &array, index : index+1, serie : 1, caseSerie : nb)
  }
  let rand = Int.random(in: 0..<2)
  array[index] = rand
  return fillTab(array : &array, index : index+1, serie : caseSerie == rand ? 2 : 1, caseSerie : rand)
}

var a : Bool
repeat{
  a = fillTab(array : &tab, index : 0, serie : 0, caseSerie : -1)
  print(a)
}
while(!a)
*/

@discardableResult func fillTab(array : inout [Int], index : Int, serie : Int, caseSerie : Int, nbFirstAvailable : Int, nbSecondAvailable : Int) -> Bool{
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

var a : Bool
repeat{
  a = fillTab(array : &tab, index : 0, serie : 0, caseSerie : -1, nbFirstAvailable : 12, nbSecondAvailable : 12)
  print(a)
}
while(!a)

print(tab)