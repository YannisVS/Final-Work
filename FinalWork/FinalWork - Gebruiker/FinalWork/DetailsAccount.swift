//
//  DetailsAccount.swift
//  FinalWork
//
//  Created by Yannis Van Steen on 19/05/2022.
//

import SwiftUI
import FirebaseAuth

struct DetailsAccount: View {
    
    @StateObject var viewRouter: ViewRouter
    @ObservedObject private var vm = MainViewModel()
    @State var email: String = ""
    @State var password: String = ""
    @State private var showReAuthenticatie = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        
        VStack(alignment: .center, spacing: 25, content: {
            Spacer()
                VStack(alignment: .center, spacing: 5, content: {
                Text("Email adress:")
                    .font(Font.custom("Ubuntu-Bold", size: 18)).padding(5)
                    Text(FirebaseManager.shared.auth.currentUser?.email ?? "")
                    .font(Font.custom("Ubuntu-Regular", size: 15)).padding(5)
                })
            
            Spacer()
            Button {
                DispatchQueue.main.async {
                    vm.handleSignOut()
                    viewRouter.currentPage = .aanmelden
                }
            } label: {
                Text("Afmelden")
                    .frame(width: 200, height: 20)
                    .padding(15)
                    .overlay( RoundedRectangle(cornerRadius: 16)
                        .stroke(Color(red: 1, green: 0.49411764705882355, blue: 0.4392156862745098), lineWidth: 2))
            }
            
      
            Button {
                vm.handleDeleteUser()
                viewRouter.currentPage = .aanmelden
            }label: {
                Text("Account verwijderen")
                    .foregroundColor(Color.red)
                    .frame(width: 200, height: 20)
                    .padding(15)
                    .overlay( RoundedRectangle(cornerRadius: 16)
                        .stroke(Color(red: 1, green: 0.49411764705882355, blue: 0.4392156862745098), lineWidth: 2))
            }
            
          
            Spacer()
            Spacer()
            Spacer()
        })
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Terug")
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack {
                    Text("Account gegevens")
                        .font(Font.custom("BebasNeue-Regular", size: 24))
                        .frame(width: 145)
                }
            }
        }
    }
}

struct DetailsAccount_Previews: PreviewProvider {
    static var previews: some View {
        DetailsAccount(viewRouter: ViewRouter())
    }
}
