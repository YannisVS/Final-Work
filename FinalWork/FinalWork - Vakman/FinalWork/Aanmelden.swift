//
//  ContentView.swift
//  FinalWork
//
//  Created by Yannis Van Steen on 10/05/2022.
//

import SwiftUI
import FirebaseAuth

struct Aanmelden: View {
    @State private var email: String = ""
    @State private var wachtwoord: String = ""
    @State private var isLoggedIn: Bool = false
    
    @StateObject var viewRouter: ViewRouter
    
    
    var body: some View {
        
        VStack{
            Spacer()
            Text("Manus").font(Font.custom("BebasNeue-Regular", size: 24))
            Image("Logo")
            TextField("Email adress", text: $email)
                .padding()
                .frame(width: 300.0)
                .textFieldStyle(.roundedBorder)
            
            SecureField("Password",text: $wachtwoord)
                .padding()
                .frame(width: 300.0)
                .textFieldStyle(.roundedBorder)
            Button {
                loginAccount()
            } label: {
                Text("Aanmelden")
                    .padding(15)
                    .frame(maxWidth: 260)
                    .overlay( RoundedRectangle(cornerRadius: 16)
                        .stroke(Color(red: 1, green: 0.49411764705882355, blue: 0.4392156862745098), lineWidth: 2))
                    .foregroundColor(Color(red: 0.44313725490196076, green: 0.38823529411764707, blue: 1.0))
            }
            Text(self.loginStatusMessage)
                .foregroundColor(Color.red)
                .padding()
            Spacer()
            HStack{
                VStack{Divider().padding(EdgeInsets(top: 0, leading: 85, bottom: 0, trailing: 0))}
                Text("OF").font(Font.custom("Ubuntu-Regular", size: 18)).padding(5)
                VStack{Divider().padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 85))}
            }
            
            Button {
                viewRouter.currentPage = .registreer
            } label: {
                Text("Nog geen account?")
                    .padding(15)
                    .frame(maxWidth: 260)
                    .overlay( RoundedRectangle(cornerRadius: 16)
                        .stroke(Color(red: 1, green: 0.49411764705882355, blue: 0.4392156862745098), lineWidth: 2))
                    .foregroundColor(Color(red: 0.44313725490196076, green: 0.38823529411764707, blue: 1.0))
            }            
        }.onAppear(perform: {
            guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
                return }
            viewRouter.currentPage = .aanmelden

        })
    }
    @State var loginStatusMessage = ""
    private func loginAccount(){
        Auth.auth().signIn(withEmail : email, password: wachtwoord){
            result, err in
            if let err = err {
                print("Mislukt: \(err)")
                self.loginStatusMessage = "Failed to login user: \(err.localizedDescription)"
                return
            }
            print("Succesfully logged in as user: \(result?.user.uid ?? "")")
            self.loginStatusMessage = "Succesfully logged in as user: \(result?.user.uid ?? "")"
            viewRouter.currentPage = .home
        }
        
    }
}


struct Aanmelden_Previews: PreviewProvider {
    static var previews: some View {
        Aanmelden(viewRouter: ViewRouter())
            .previewInterfaceOrientation(.portrait)
    }
}
