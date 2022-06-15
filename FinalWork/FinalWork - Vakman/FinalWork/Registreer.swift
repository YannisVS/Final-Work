//
//  Registreer.swift
//  FinalWork
//
//  Created by Yannis Van Steen on 30/05/2022.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct MultipleSelectionRow: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void
    
    var body: some View {
        Button(action: self.action) {
            HStack {
                Text(self.title)
                if self.isSelected {
                    Spacer()
                    Image(systemName: "checkmark")
                }
            }
        }
    }
}

struct Registreer: View {
    
    @State private var email: String = ""
    @State private var wachtwoord: String = ""
    @State private var ondernemingsNummer: String = ""
    @State private var naamVanOnderneming: String = ""
    @State private var uurprijs: String = ""
    
    var specialisaties: [String] = ["Specialisatie","Tuinier", "Dakwerker", "Glazenwasser", "Loodgieter", "Elektricien", "Schrijnwerken", "Schilder"]
    var provincies: [String] = ["Provincie", "Oost-Vlaanderen", "Vlaams-Brabant", "West-Vlaanderen", "Antwerpen", "Limburg", "Brussel"]
    @State private var selectedSpecialisaties = ""
    @State private var selectedProvincie = ""
    @State private var reviews: Array<Int> = []
    @StateObject var viewRouter: ViewRouter
    @State var errorMessageOnderneming = " "
    @State var errorMessageSelections = " "
    
    var body: some View {
        
        VStack{
            
            Spacer()
            Text("Manus").font(Font.custom("BebasNeue-Regular", size: 24))
            Image("Logo").padding(0)
            ScrollView {
            VStack(alignment: .center, spacing: 0) {
                TextField("Email adress", text: $email)
                    .padding([.bottom,.leading,.trailing])
                    .frame(width: 300.0)
                    .textFieldStyle(.roundedBorder)
                
                SecureField("Password",text: $wachtwoord)
                    .padding()
                    .frame(width: 300.0)
                    .textFieldStyle(.roundedBorder)
                
                VStack{
                    TextField("Ondernemings nummer", text: $ondernemingsNummer)
                        .padding()
                        .frame(width: 300.0)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.numberPad)
                }
                VStack{
                    TextField("Naam van uw Onderneming", text: $naamVanOnderneming)
                        .padding()
                        .frame(width: 300.0)
                        .textFieldStyle(.roundedBorder)
                    Text(errorMessageOnderneming)
                        .foregroundColor(Color.red)
                        .font(Font.custom("Ubuntu-Regular", size: 12)).padding(5)
                }
                VStack{
                    Text("Regio van tewerkstelling:")
                    Picker("Kies een provincie", selection: $selectedProvincie) {
                        ForEach(provincies, id: \.self) {
                            Text($0)
                        }
                    }
                    Text(errorMessageSelections)
                        .foregroundColor(Color.red)
                        .font(Font.custom("Ubuntu-Regular", size: 12)).padding(0)
                }.padding(0)
                HStack(spacing: 50) {
                    VStack(alignment: .leading) {
                        Text("Specialisatie:")
                        Picker("Kies een specialisatie", selection: $selectedSpecialisaties) {
                            ForEach(specialisaties, id: \.self) {
                                Text($0)
                            }
                        }
                    }.padding([.bottom])
                    VStack(alignment: .leading) {
                        Text("Prijs per uur?:")
                        TextField("Uurprijs", text: $uurprijs)
                            .keyboardType(.numberPad)
                            .frame(width: 100.0)
                            .textFieldStyle(.roundedBorder)
                    }.padding()
                }
            }
            }
            Button {
                if ondernemingsNummer == "" {
                    errorMessageOnderneming = "Gelieve een ondernemingsnummer in te vullen"
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        errorMessageOnderneming = " "
                    }
                } else if naamVanOnderneming == "" {
                    errorMessageOnderneming = "Gelieve de naam van de onderneming in te vullen"
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        errorMessageOnderneming = " "
                    }
                } else if selectedProvincie == "" || selectedProvincie == "Provincie" {
                    errorMessageSelections = "Gelieve een provincie aan te duiden"
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        errorMessageSelections = " "
                    }
                } else if selectedSpecialisaties == "" || selectedProvincie == "Specialisatie"  {
                    errorMessageSelections = "Gelieve een specialisatie aan te duiden"
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        errorMessageSelections = " "
                    }
                }  else if uurprijs == "" {
                    errorMessageSelections = "Gelieve een uurprijs in te vullen"
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        errorMessageSelections = " "
                    }
                } else {
                    maakAccount()
                }
            } label: {
                Text("Registreer")
                    .padding(15)
                    .frame(maxWidth: 260)
                    .overlay( RoundedRectangle(cornerRadius: 16)
                        .stroke(Color(red: 1, green: 0.49411764705882355, blue: 0.4392156862745098), lineWidth: 2))
                    .foregroundColor(Color(red: 0.44313725490196076, green: 0.38823529411764707, blue: 1.0))
            }
            Text(self.registreerStatusMessage)
                .foregroundColor(Color.red)
                .padding(3)
       
            HStack{
                VStack{Divider().padding(EdgeInsets(top: 0, leading: 85, bottom: 0, trailing: 0))}
                Text("OF").font(Font.custom("Ubuntu-Regular", size: 18)).padding(5)
                VStack{Divider().padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 85))}
            }
            
            Button {
                viewRouter.currentPage = .aanmelden
            } label: {
                Text("Reeds een gebruiker?")
                    .padding(15)
                    .frame(maxWidth: 260)
                    .foregroundColor(Color(red: 1, green: 0.49411764705882355, blue: 0.4392156862745098))
            }
            
        }
    }
    @State var registreerStatusMessage = ""
    private func maakAccount(){
        FirebaseManager.shared.auth.createUser(withEmail: email, password: wachtwoord){
            result, err in
            if let err = err {
                print("Mislukt: \(err)")
                self.registreerStatusMessage = "Failed to create user: \(err.localizedDescription)"
                return
            }
            print("Succesfully created user: \(result?.user.uid ?? "")")
            self.registreerStatusMessage = "Succesfully created user: \(result?.user.uid ?? "")"
            storeVakmanInformation()
        }
    }
    private func storeVakmanInformation(){
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        let userData = ["email": self.email, "uid": uid, "ondernemingsNummer": self.ondernemingsNummer, "provincie": self.selectedProvincie, "specialisaties": self.selectedSpecialisaties, "uurprijs": self.uurprijs,"naamVanOnderneming": self.naamVanOnderneming, "reviews": self.reviews] as [String : Any]
        FirebaseManager.shared.firestore.collection("vakmanen").document(uid).setData(userData) { err in
            if let err = err {
                print(err)
                self.registreerStatusMessage = "\(err)"
                return
            }
            viewRouter.currentPage = .home
        }
    }
}

struct Registreer_Previews: PreviewProvider {
    static var previews: some View {
        Registreer(viewRouter: ViewRouter())
    }
}

