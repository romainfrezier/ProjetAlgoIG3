import aeroport

print("----- création d'une collection d'aéroports -------")

let ida = IndicatifAeroport()
do{
  try ida.save(toFileName: "aeroports.csv")
}
catch{
   print("ERREUR")
}

print("----- création d'une liste d'après un fichier -------")

guard var idb = IndicatifAeroport(file: "aeroports.csv") else { fatalError("loading csv failed") }
print("MPL : \(idb.aeroport(indicatif: "MPL") ?? "none")")
print("MPT : \(idb.aeroport(indicatif: "MPT") ?? "none")")

print("----- changement d'un nom -------")

print("LHR : \(idb.aeroport(indicatif: "LHR") ?? "none")")
idb.changeName(indicatif: "LHR", name: "London Heathrow")
print("LHR : \(idb.aeroport(indicatif: "LHR") ?? "none")")

print("----- recherche par indicatif -------")

idb.add(indicatif: "LCY", name: "London City")
print("LCY : \(idb.aeroport(indicatif: "LCY") ?? "none")")

print("----- recherche par nom -------")

print("Montpellier -> \(idb.searchIndicatif(name: "Montpellier") ?? "none")")
print("Nimes -> \(idb.searchIndicatif(name: "Nimes") ?? "none")")

print("----- itérateur sur les indicateurs -------")

for indic in idb{
   print("\(indic) -> \(idb.aeroport(indicatif:indic) ?? "")")
}

print("----- itérateur sur les noms -------")

var itNames = idb.makeItAlphaName()
while let name = itNames.next(){
   print("\(name) -> \(idb.searchIndicatif(name:name) ?? "")")   
}

print("----- suppression à partir d'un indicatif -------")

idb.remove(indicatif: "DUB")
for indic in idb{
   print("\(indic) -> \(idb.aeroport(indicatif:indic) ?? "")")
}


print("----- suppression à partir d'un nom -------")

idb.add(indicatif: "DUB", name: "Dublin")
idb.remove(name: "Dublin")
for indic in idb{
   print("\(indic) -> \(idb.aeroport(indicatif:indic) ?? "")")
}

print("hello, give me your name:")
let cfname = readLine()
print("name : \(cfname ?? "not a name")")
