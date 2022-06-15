//
//  ButtonViewModel.swift
//  FinalWork
//
//  Created by Yannis Van Steen on 03/06/2022.
//

import Foundation
import SwiftUI
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
    static let vakmanuid = "uid"
    static let email = "email"
    static let ondernemingsnummer = "ondernemingsnummer"
    static let provincie = "provincie"
    static let specialisatie = "specialisatie"
    static let uurprijs = "uurprijs"
    static let reviews = "reviews"
    static let naamVanOnderneming = "naamVanOnderneming"
}

struct Vakman: Identifiable {
    var id: String { self.vakmanuid }
    
    let vakmanuid, email, ondernemingsnummer, provincie, specialisatie, naamVanonderneming, uurprijs: String
    let reviews: Array<Int>
    var gemiddeldeVanReviews: String
    
    init(gemiddeldeVanReviews: String, data: [String: Any]) {
        self.gemiddeldeVanReviews = gemiddeldeVanReviews
        self.vakmanuid = data[FirebaseConstants.vakmanuid] as? String ?? ""
        self.email = data[FirebaseConstants.email] as? String ?? ""
        self.ondernemingsnummer = data[FirebaseConstants.ondernemingsnummer] as? String ?? ""
        self.uurprijs = data[FirebaseConstants.uurprijs] as? String ?? ""
        self.reviews = data[FirebaseConstants.reviews] as? Array ?? []
        self.naamVanonderneming = data[FirebaseConstants.naamVanOnderneming] as? String ?? ""
        self.specialisatie = data[FirebaseConstants.specialisatie] as? String ?? ""
        self.provincie = data[FirebaseConstants.provincie] as? String ?? ""
}
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
    @Published var vakmanenDetails = [Vakman]()
    @Published var image1url = ""
    @Published var image2url = ""
    @Published var image3url = ""
    @State private var fetchErrorMessage = ""
    @State var maakWerkStatusMessage = ""
    
    init() {
        verkrijgAlleWerkenInformation()
    }
    
    init(RecievedVakmanId: Array<String>) {
        verkrijgVakmanInformation(recievedVakmanId: RecievedVakmanId)
    }
    
    init(ReviecedDocumentId: String, RecievedFromid: String) {
        verkrijgSpecefiekeWerkInformation(fromid: RecievedFromid, documentId: ReviecedDocumentId)
    }
    
    func verkrijgVakmanInformation(recievedVakmanId: Array<String>) {
        guard let fromuid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        let vakmanid = recievedVakmanId
        recievedVakmanId.forEach {
            FirebaseManager.shared.firestore
                .collection("vakmanen")
                .document($0).getDocument { snapshot, error in
                    if let error = error {
                        self.fetchErrorMessage = "Failed to listen for message: \(error)"
                        print(error)
                        return
                    }
                    else {
                        guard let data = snapshot?.data() else { return }
                        self.vakmanenDetails.append(.init(gemiddeldeVanReviews: "", data: data))
                    }
                    var totaalIndex = 0
                    self.vakmanenDetails.forEach{vakmanData in
                        var index = 0
                        var optellingVanReviews = 0
                        var gemiddelde: Double = 0.0
                        vakmanData.reviews.forEach{vakmanReview in
                            optellingVanReviews += vakmanReview
                            index += 1
                        }
                        gemiddelde = Double(optellingVanReviews)/Double(index)
                        self.vakmanenDetails[totaalIndex].gemiddeldeVanReviews = String(round(gemiddelde))
                        totaalIndex += 1
                    }
                }
        }
    }
    
    func verkrijgAlleWerkenInformation(){
        guard let fromuid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        
        FirebaseManager.shared.firestore
            .collection("Werken")
            .document(fromuid)
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

    func updateWerkInformation(fromuid: String, documentId : String,titel: String, beschrijving: String, gemeente: String, postcode: String, straatnaam: String, huisnummer: String, prioriteit: Bool, provincie: String, specialisatie: String){
        print("Sheeeesh")
        FirebaseManager.shared.firestore.collection("Werken").document(fromuid).collection("WerkenOpId").document(documentId).updateData([
            "titel" : titel,
            "beschrijving" : beschrijving,
            "gemeente" : gemeente,
            "postcode" : postcode,
            "straatnaam" : straatnaam,
            "huisnummer" : huisnummer
        ])
    }
    
    func deleteWerkInformation(fromuid: String, documentId : String){
        print("Sheeeesh")
        FirebaseManager.shared.firestore.collection("Werken").document(fromuid).collection("WerkenOpId").document(documentId).delete()
    }
    
    func slaWerkInformationOp(fromuid: String, titel: String, beschrijving: String, gemeente: String, postcode: String, straatnaam: String, huisnummer: String, trackAndTrace: String, datum: Date, prioriteit: Bool, goedgekeurd: Bool, image1: UIImage, image2: UIImage, image3: UIImage, provincie: String, specialisatie: String){
        
        guard let fromuid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        let filenameImage1 = UUID().uuidString
        let filenameImage2 = UUID().uuidString
        let filenameImage3 = UUID().uuidString

        let ref1 = FirebaseManager.shared.storage.reference(withPath: filenameImage1)
        let ref2 = FirebaseManager.shared.storage.reference(withPath: filenameImage2)
        let ref3 = FirebaseManager.shared.storage.reference(withPath: filenameImage3)
       
        guard let imageData1 = image1.jpegData(compressionQuality: 0.5) else { return }
        guard let imageData2 = image2.jpegData(compressionQuality: 0.5) else { return }
        guard let imageData3 = image3.jpegData(compressionQuality: 0.5) else { return }
        
        ref1.putData(imageData1, metadata: nil) { [self] metadata, err in
            if let err = err {
                print(err)
            }
            ref1.downloadURL { url, err in
                if let err = err {
                    print("Error with downloading url: ", err)
                    return
                }
                self.image1url = url?.absoluteString ?? ""
                print("Image url from Image 1: ", self.image1url)
                ref2.putData(imageData2, metadata: nil) { metadata, err in
                    if let err = err {
                        print(err)
                    }
                    ref2.downloadURL { url, err in
                        if let err = err {
                            print("Error with downloading url: ", err)
                            return
                        }
                        self.image2url = url?.absoluteString ?? ""
                        print("Image url from Image 2: ", self.image2url)
                        
                         ref3.putData(imageData3, metadata: nil) { metadata, err in
                             if let err = err {
                                 print(err)
                             }
                             ref3.downloadURL { url, err in
                                 if let err = err {
                                     print("Error with downloading url: ", err)
                                     return
                                 }
                                 self.image3url = url?.absoluteString ?? ""
                                 print("Image url from Image 3: ", self.image3url)
                        
                                 let werkData = [
                                     FirebaseConstants.fromid: fromuid,
                                     FirebaseConstants.titel: titel,
                                     FirebaseConstants.beschrijving: beschrijving,
                                     FirebaseConstants.gemeente: gemeente,
                                     FirebaseConstants.postcode: postcode,
                                     FirebaseConstants.straatnaam: straatnaam,
                                     FirebaseConstants.huisnummer: huisnummer,
                                     FirebaseConstants.datum: datum,
                                     FirebaseConstants.prioriteit: prioriteit,
                                     FirebaseConstants.goedgekeurd: goedgekeurd,
                                     FirebaseConstants.trackAndTrace: trackAndTrace,
                                     FirebaseConstants.image1: self.image1url,
                                     FirebaseConstants.image2: self.image2url,
                                     FirebaseConstants.image3: self.image3url,
                                     FirebaseConstants.vakmanArray: [],
                                     FirebaseConstants.gekozenVakman: "",
                                     FirebaseConstants.provincie: provincie,
                                     FirebaseConstants.specialisatie: specialisatie
                                 ] as [String : Any]
                                 print("fromuid: ",fromuid)
                                 FirebaseManager.shared.firestore.collection("Werken").document(fromuid).collection("WerkenOpId").document().setData(werkData) { err in
                                     if let err = err {
                                         print(err)
                                         self.maakWerkStatusMessage = "\(err)"
                                         return
                                     }
                                 }
                             }
                         }
                    }
                }
            }
        }
    }
}
