//
//  DetailsAccount.swift
//  FinalWork
//
//  Created by Yannis Van Steen on 19/05/2022.
//

import SwiftUI

struct DetailsAccount: View {
    
    @StateObject var viewRouter: ViewRouter
    
    @State var verwijderWaarschuwingNavigation = false
    @ObservedObject private var vm = MainViewModel()
    
    enum Category: String, CaseIterable, Identifiable {
        case Loodgieter, Dakwerker, Geen
        var id: Self { self }
    }
    
    @State private var selectedCategory: Category = .Geen
    
    
    var body: some View {
        
        VStack{
            VStack(alignment: .leading, spacing: 20, content: {
                Text("Naam:")
                    .font(Font.custom("Ubuntu-Bold", size: 18)).padding(5)
                Text(vm.vakman?.naamVanOnderneming ?? "")
                    .font(Font.custom("Ubuntu-Regular", size: 15)).padding(5)
                Text("Onderneminsgsnummer:")
                    .font(Font.custom("Ubuntu-Bold", size: 18)).padding(5)
                Text(vm.vakman?.ondernemingsNummer ?? "")
                    .font(Font.custom("Ubuntu-Regular", size: 15)).padding(5)
                Text("Specialisatie: ")
                    .font(Font.custom("Ubuntu-Bold", size: 18)).padding(5)
                Text(vm.vakman?.specialisatie ?? "")
                    .font(Font.custom("Ubuntu-Regular", size: 15)).padding(5)
                Text("Provincie: ")
                    .font(Font.custom("Ubuntu-Bold", size: 18)).padding(5)
                Text(vm.vakman?.provincie ?? "")
                    .font(Font.custom("Ubuntu-Regular", size: 15)).padding(5)
                Text("Uurprijs: ")
                    .font(Font.custom("Ubuntu-Bold", size: 18)).padding(5)
                Text(vm.vakman?.uurprijs ?? "")
                    .font(Font.custom("Ubuntu-Regular", size: 15)).padding(5)
            })
            .frame(width: 350, alignment: .leading)
            .padding(.top, 50)
            VStack(alignment: .center, spacing: 25, content: {
                Spacer()
                Button {
                    DispatchQueue.main.async {
                        viewRouter.currentPage = .aanmelden
                        vm.handleSignOut()
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
        }
        .background(
            NavigationLink(destination: Aanmelden(viewRouter: viewRouter),
                           isActive: $verwijderWaarschuwingNavigation) {EmptyView()}
        )
        .frame(width: 800)
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Terug")
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack {
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
