//
//  Account.swift
//  FinalWork
//
//  Created by Yannis Van Steen on 12/05/2022.
//

import SwiftUI

struct Account: View {
    
    @StateObject var viewRouter: ViewRouter
    @State var userLoggedIn: Bool
    
    var body: some View {
        NavigationView{
            VStack{
                List {
                    NavigationLink(destination: DetailsAccount(viewRouter: viewRouter)) {
                        Image(systemName: "person.text.rectangle").padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 15))
                        Button("Account gegevens") {
                            
                        }
                    }
                }
            }   .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Terug")
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        HStack {
                            Text("Manus").font(Font.custom("BebasNeue-Regular", size: 24))
                            Spacer()
                            Spacer()
                            Text("Account").font(Font.custom("BebasNeue-Regular", size: 24))
                            Spacer()
                            Spacer()
                            Spacer()
                        }
                    }
                }.padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0)).background(Color(.systemGray6))
        }
    }
}

struct Account_Previews: PreviewProvider {
    static var previews: some View {
        Account(viewRouter: ViewRouter(), userLoggedIn: true)
    }
}
