import Foundation


// IndicatifAeroport est une collection de couple (indicatif, nom d'aéroport)
// Cette collection peut être parcourue par 2 itérateurs.
protocol IndicatifAeroportProtocol : Sequence{
   associatedtype IteratorAlphaIndicateur : IteratorProtocol where IteratorAlphaIndicateur.Element == String
   associatedtype IteratorAlphaName : IteratorProtocol where IteratorAlphaName.Element == String
   
   //associatedtype ItAlphaIndicProtocol: IteratorProtocol
   // init : -> IndicatifAeroport
   // création d'un IndicatifAeroport, initialisé avec différents aéroports
   init()

   // init : String -> (IndicatifAeroport | Vide)
   // création d'un IndicationAeroport à partir d'un fichier csv de données
   // Pre: String représente le nom d'un fichier existant
   //      sinon la création échoue
   init?(file: String)

   // save: IndicatifAeroport x String ->
   // sauvegarde les données de IndicatifAeroport dans un fichier au format csv
   // Pre : String représente le chemin vers un fichier
   //       sinon lève une erreur d'entrée-sortie
   func save(toFileName fileName: String) throws


   // aeroport : String -> (String | Vide)
   // retourne le nom de l'aéroport correspondant à l'indicatif passé en paramètre
   // Pre : String est un nom d'indicatif
   // Post : retour Vide si cet indicatif n'existe pas, sinon retour un String contenant le de l'aéroport
   func aeroport(indicatif: String) -> String?

   // changeName : IndicatifAeroport x String x String -> IndicatifAeroport
   // change le nom de l'aéroport qui a l'indicatif passé en paramètre
   // Pre : le premier paramètre est un indicatif connu
   // Pre : le second paramètre est une chaine de caractères correspondant au nouveau nom
   // Post : le nom est changé pour l'indicatif donné en paramètre ; si cet indicatif n'existe pas
   //        rien n'est fait.
   mutating func changeName(indicatif: String, name: String)
   
   // add: IndicatifAeroport x String x String -> IndicatifAeroport
   // ajoute un nouveau couple (indicatif, nom) à la collection
   // Pre : l'indicatif ne peut pas être une chaine vide ""
   // Pre : nom ne peut pas être une chaine vide ""
   // Pre : l'indicatif ne doit pas déjà exister dans la collection
   // Post : la collection avec le nouveau couple (indicatif, nom) si les preconditions ont été respectées, sinon, rien n'est changé.
   mutating func add(indicatif: String, name: String)

   // removeIndicatif : IndicatifAeroport x String -> IndicatifAeroport
   // Pre : indicatif est une chaîne non vide ""
   // Pre : indicatif est un indicatif existant dans la collection
   // Post : la collection de laquelle on a retiré le couple (indicatif, nom) correspondant à l'indicatif passé en paramètre si les preconditions ont été respectées, sinon rien n'est changé.
   // Note: ici Self n'est pas self, c'est un type générique indiquant que le type de retour est du type IndicatifAeroportProtocol, mais celui même l'implémentant et définissant cette fonction. C'est pour éviter qu'on puisse retourner un autre type implémentant l'aéroport que le type lui-même.
   @discardableResult
   mutating func remove(indicatif: String) -> Self

   // removeName : IndicatifAeroport : String -> IndicatifAeroport
   // Pre : indicatif est une chaîne non vide ""
   // Post : si la precondition est respectée et qu'un aéroport ayant ce nom existe dans la collection, le couple (indicatif, nom) correspondant est retiré de la collection, sinon rien n'est changé
   // Note : même remarque que ci-dessus à propos de Self
   @discardableResult 
   mutating func remove(name: String) -> Self

   // searchIndicatif : IndicatifAeroport x String -> (String | Vide)
   // cherche l'indicatif de l'aéroport qui a pour nom la chaîne passée en paramètre
   // Pre : name est une chaîne de caractère correspondant à un nom d'aéroport de la collection
   // Post : l'indicatif de l'aéroport si la precondition est respectée, sinon retourne Vide
   func searchIndicatif(name: String) -> String?

   // makeItAlphaIndic : IndicatifAeroport -> ItAlphaIndic
   // crée un itérateur sur la collection dans l'ordre alphabétique des indicateurs
   func makeItAlphaIndic() -> IteratorAlphaIndicateur

   // makeIterator : IndicatifAeroport -> ItAlphaIndic
   // crée un itérateur sur le collection pour itérer avec for in. L'itération se fait dans l'ordre alphabétique des indicateurs
   func makeIterator() -> IteratorAlphaIndicateur

   // makeItAlphaName : IndicatifAeroport -> ItAlphaName
   // crée un itérateur sur la collection pour la parcourir dans l'ordre alphabétique des noms d'aéroport
   func makeItAlphaName() -> IteratorAlphaName

}
