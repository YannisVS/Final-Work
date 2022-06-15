//
//  Registreer.swift
//  FinalWork
//
//  Created by Yannis Van Steen on 30/05/2022.
//

import SwiftUI

struct Registreer: View {
    
    @State private var email: String = ""
    @State private var wachtwoord: String = ""
    
    enum Category: String, CaseIterable, Identifiable {
        case Loodgieter, Dakwerker, Geen
        var id: Self { self }
    }
    
    @State private var selectedCategory: Category = .Geen
    
    @StateObject var viewRouter: ViewRouter
    
    var body: some View {
        
        VStack{
            Spacer()
            Text("Manus").font(Font.custom("BebasNeue-Regular", size: 24))
            Image("Logo")
            TextField("Email adres", text: $email)
                .padding()
                .frame(width: 300.0)
                .textFieldStyle(.roundedBorder)
            
            SecureField("Wachtwoord",text: $wachtwoord)
                .padding()
                .frame(width: 300.0)
                .textFieldStyle(.roundedBorder)
            
            Button {
                maakAccount()
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
                .padding()
            
            Spacer()
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
            self.storeUserInformation()
        }
    }
    private func storeUserInformation(){
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        let userData = ["email": self.email, "uid": uid, ]
        FirebaseManager.shared.firestore.collection("klanten").document(uid).setData(userData) { err in
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

