//
//  ButtonViewModel.swift
//  FinalWork
//
//  Created by Yannis Van Steen on 03/06/2022.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI
import FirebaseFirestore

struct FirebaseConstants {
    static let fromid = "userUid"
    static let vakmanid = "vakmanUid"
    static let titel = "titel"
    static let beschrijving = "beschrijving"
    static let gemeente = "gemeente"
    static let postcode = "postcode"
    static let straatnaam = "straatnaam"
    static let huisnummer = "huisnummer"
    static let datum = "uitvoerdatum"
    static let prioriteit = "prioriteit"
    static let goedgekeurd = "goedgekeurd"
    static let image1 = "image1"
    static let image2 = "image2"
    static let image3 = "image3"
    static let trackAndTrace = "trackAndTrace"
    static let vakmanArray = "vakmanArray"
    static let gekozenVakman = "gekozenVakman"
    static let provincie = "provincie"
    static let specialisatie = "specialisatie"
}

struct WerkButton: Identifiable {
    
    var id: String { documentId }
    
    let documentId: String
    let fromid, titel, beschrijving, gemeente, postcode, straatnaam, huisnummer, provincie, specialisatie: String
    let datum: String
    let prioriteit, goedgekeurd: Bool
    let trackAndTrace: String
    let image1, image2, image3: String
    let vakmanArray: Array<String>
    let gekozenVakman: String
    
    init(documentId: String, data: [String: Any]) {
  
        
        self.documentId = documentId
        self.fromid = data[FirebaseConstants.fromid] as? String ?? ""
        self.titel = data[FirebaseConstants.titel] as? String ?? ""
        self.beschrijving = data[FirebaseConstants.beschrijving] as? String ?? ""
        self.gemeente = data[FirebaseConstants.gemeente] as? String ?? ""
        self.postcode = data[FirebaseConstants.postcode] as? String ?? ""
        self.straatnaam = data[FirebaseConstants.straatnaam] as? String ?? ""
        self.huisnummer = data[FirebaseConstants.huisnummer] as? String ?? ""
        self.prioriteit = data[FirebaseConstants.prioriteit] as? Bool ?? false
        self.goedgekeurd = data[FirebaseConstants.goedgekeurd] as? Bool ?? false
        self.trackAndTrace = data[FirebaseConstants.trackAndTrace] as? String ?? ""
        self.image1 = data[FirebaseConstants.image1] as? String ?? ""
        self.image2 = data[FirebaseConstants.image2] as? String ?? ""
        self.image3 = data[FirebaseConstants.image3] as? String ?? ""
        self.vakmanArray = data[FirebaseConstants.vakmanArray] as? Array ?? []
        self.gekozenVakman = data[FirebaseConstants.gekozenVakman] as? String ?? ""
        self.provincie = data[FirebaseConstants.provincie] as? String ?? ""
        self.specialisatie = data[FirebaseConstants.specialisatie] as? String ?? ""
        
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
      
        let timestampRecieved = data[FirebaseConstants.datum] as? Timestamp ?? Timestamp.init(date: Date.now)
        let gekregenDatum = timestampRecieved.dateValue()
        self.datum = formatter.string(from: gekregenDatum)
    }
}


class ButtonListViewModel: ObservableObject {
    
    @Published var werkButtons = [WerkButton]()
    @Published var werkButtonDetail: WerkButton?
    @Published var vakmanDetail = [String : Any]()
    @Published var image1url = ""
    @Published var image2url = ""
    @Published var image3url = ""
    @State private var fetchErrorMessage = ""
    @State var maakWerkStatusMessage = ""
    
    init() {
        verkrijgAlleWerkenInformation()
    }
    
    init(ReviecedDocumentId: String, RecievedFromid: String) {
        verkrijgSpecefiekeWerkInformation(fromid: RecievedFromid, documentId: ReviecedDocumentId)
    }
    
    func verkrijgAlleWerkenInformation(){
        guard let fromuid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        FirebaseManager.shared.firestore
            .collection("klanten")
            .getDocuments { querySnapshot, error in
                if let error = error {
                    self.fetchErrorMessage = "Failed to listen for message: \(error)"
                    print(error)
                    return
                } else {
                    querySnapshot?.documents.forEach({item in
                        print(item["uid"])
                        FirebaseManager.shared.firestore
                            .collection("Werken")
                            .document(item["uid"] as! String)
                            .collection("WerkenOpId")
                            .addSnapshotListener { querySnapshot, error in
                                if let error = error {
                                    self.fetchErrorMessage = "Failed to listen for message: \(error)"
                                    print(error)
                                    return
                                }

                                querySnapshot?.documentChanges.forEach({change in
                                    if change.type == .added {
                                        let data = change.document.data()
                                        self.werkButtons.append(.init(documentId: change.document.documentID, data: data))
                                    } else if change.type == .modified {
                                        let data = change.document.data()
                                        var index = 0
                                        var correctIndex = 0
                                        for werk in self.werkButtons {
                                            if werk.documentId == change.document.documentID{
                                                correctIndex = index
                                            }
                                            index += 1
                                        }
                                        self.werkButtons[correctIndex] = WerkButton(documentId: change.document.documentID, data: change.document.data())
                                    } else if change.type == .removed {
                                        let data = change.document.data()
                                        var index = 0
                                        var correctIndex = 0
                                        for werk in self.werkButtons {
                                            if werk.documentId == change.document.documentID{
                                                correctIndex = index
                                            }
                                            index += 1
                                        }
                                        self.werkButtons.remove(at: correctIndex)
                                    }
                                })
                            }
                    })
                }
                
            }
        
    }
    
    func verkrijgSpecefiekeWerkInformation(fromid: String, documentId: String){
        let recievedFromid = fromid
        FirebaseManager.shared.firestore
            .collection("Werken")
            .document(recievedFromid)
            .collection("WerkenOpId")
            .document(documentId).getDocument { snapshot, error in
                if let error = error {
                    self.fetchErrorMessage = "Failed to listen for message: \(error)"
                    print(error)
                    return
                }
                guard let data = snapshot?.data() else { return }
                self.werkButtonDetail = .init(documentId: snapshot?.documentID ?? "", data: data)
            }
    }
}
