import Foundation


public struct IndicatifAeroport : IndicatifAeroportProtocol{
   typealias IteratorAlphaIndicateur  = ItAlphaIndic
   typealias IteratorAlphaName = ItAlphaName
   
   fileprivate var indicatifs = [String:String]()
   
   private func fileToUrl(fileName: String) -> URL{
      let currentDir = FileManager.default.currentDirectoryPath
      let currentFile = currentDir + "/" + fileName
      return URL(fileURLWithPath: currentFile)
   }
   
   public init(){
      self.indicatifs["MPL"] = "Montpellier"
      self.indicatifs["DUB"] = "Dublin"
      self.indicatifs["CDG"] = "Paris Charles-de-Gaule"
      self.indicatifs["ORY"] = "Paris Orly"
      self.indicatifs["YYZ"] = "Toronto"
      self.indicatifs["LHR"] = "London"
      self.indicatifs["LAX"] = "Los Angeles"
   }
   
   public init?(file: String){
      let contentURL = self.fileToUrl(fileName: file)
      do{
         let contentFile = try String(contentsOf: contentURL, encoding: .utf8)
         let rows = contentFile.components(separatedBy: "\n")
         for row in rows{
            let values = row.components(separatedBy : ",")
            if values.count == 2 {
               self.indicatifs[values[0]] = values[1]
            }
         }
      }
      catch{
         return nil
      }
   }
   
   public func save(toFileName fileName: String) throws {
      let currentURL = self.fileToUrl(fileName: fileName)
      var line : String = ""
      for (key,aeroport) in self.indicatifs{
         line = line + key + "," + aeroport + "\n"
      }
      try line.write(to: currentURL, atomically: false, encoding: .utf8)
   }
   
   public func aeroport(indicatif: String) -> String?{
      return self.indicatifs[indicatif]
   }
   
   public mutating func changeName(indicatif: String, name: String){
      let _ = self.indicatifs.updateValue(name, forKey: indicatif)
   }
   
   public mutating func add(indicatif: String, name: String){
      guard indicatif.count > 0 else { return }
      guard name.count > 0 else { return }
      guard self.indicatifs[indicatif] == nil else { return }
      self.indicatifs[indicatif] = name
   }
   
   @discardableResult
   public mutating func remove(indicatif: String) -> IndicatifAeroport{
      guard indicatif.count > 0 else { return self }
      self.indicatifs.removeValue(forKey: indicatif)
      return self
   }
   
   @discardableResult
   public mutating func remove(name: String) -> IndicatifAeroport{
      guard name.count > 0 else { return self }
      guard let indic = searchIndicatif(name: name) else { return self }
      return self.remove(indicatif: indic)
   }
   
   public func searchIndicatif(name: String) -> String?{
      var ret : String? = nil
      for (indic, aeroport) in self.indicatifs{
         if aeroport == name{
            ret = indic
         }
      }
      return ret
   }
   
   public func makeItAlphaIndic() -> ItAlphaIndic{
      return ItAlphaIndic(self)
   }

   public func makeIterator() -> ItAlphaIndic{
      return ItAlphaIndic(self)// makeItAlphaIndic()
   }

   public func makeItAlphaName() -> ItAlphaName{
      return ItAlphaName(self)
   }
   
}

public struct ItAlphaIndic : IteratorProtocol{
   private let aeroports : IndicatifAeroport
   private var courant : Int = 0
   private let keys : [String]
   
   fileprivate init(_ a: IndicatifAeroport){
      self.aeroports = a
      self.keys = a.indicatifs.keys.sorted { $0 < $1 }
   }
   public mutating func next() -> String?{
      guard self.courant < self.keys.count else { return nil }
      let idval = self.courant
      self.courant = self.courant + 1
      return self.keys[idval]
   }
}

public struct ItAlphaName : IteratorProtocol{
   private let aeroports : IndicatifAeroport
   private var courant : Int = 0
   private let names : [String]
   fileprivate init(_ a: IndicatifAeroport){
      self.aeroports = a
      self.names = a.indicatifs.values.sorted { $0 < $1 }
   }
   public mutating func next() -> String?{
      guard self.courant < self.names.count else { return nil }
      let idval = self.courant
      self.courant = self.courant + 1
      return self.names[idval]
   }
}

