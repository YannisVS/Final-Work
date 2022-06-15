//
//  AllWorks.swift
//  FinalWork
//
//  Created by Yannis Van Steen on 12/05/2022.
//

import SwiftUI

struct AlleWerken: View {
    
    @State private var zoekterm: String = ""
    @State private var filterDate: Date = Date()
    @State var isIndividueelWerkIngedrukt = false
    @State private var clickedWerkId: Int64 = 0
    
    enum Category: String, CaseIterable, Identifiable {
        case Loodgieter, Dakwerker, Geen
        var id: Self { self }
    }
    
    @State private var selectedCategory: Category = .Geen
    
    var body: some View {
        NavigationView{
            VStack{
                
                TextField("", text: $zoekterm)
                    .placeholder(when: zoekterm.isEmpty) {
                        Text("Typ hier om te zoeken...").foregroundColor(.white)
                    }
                    .padding(10)
                    .frame(width: 370)
                    .foregroundColor(Color.white)
                    .background(Color(red: 0.44313725490196076, green: 0.38823529411764707, blue: 1.0))
                    .accentColor(Color.white)
                
                
                Spacer()
                Spacer()
                
                DisclosureGroup("Filter") {
                    Spacer()
                    Spacer()
                    DatePicker(selection: $filterDate,displayedComponents: [.date], label: { Text("Uitvoerdatum") })
                    Spacer()
                    HStack{
                        Text("Categorie")
                        Spacer()
                        Picker("Categorie", selection: $selectedCategory) {
                            Text("Geen").tag(Category.Geen)
                            Text("Loodgieter").tag(Category.Loodgieter)
                            Text("Dakwerker").tag(Category.Dakwerker)
                        }.padding(.trailing)
                    }
                    
                }
                .frame(width: 350)
                .padding(10)
                .background(Color.gray.opacity(0.10))
                .cornerRadius(10)
                Spacer()
                Spacer()
                
                ScrollView {
                    // -------- begin van 2 zoekertjes in een HStack
                    HStack{
                        Spacer()
                        
                        // ------ begin van een zoekertje
                        NavigationLink(destination: DetailsWerk(), isActive: $isIndividueelWerkIngedrukt) {
                            Button {
                                isIndividueelWerkIngedrukt=true
                                
                            } label: {
                                
                                VStack(alignment: .leading){
                                    Image("BrokenSink")
                                        .resizable()
                                        .cornerRadius(16, corners: [.topLeft,.topRight])
                                        .frame(width: 175.0, height: 175.0)
                                    
                                    Text("Wasbak lekt")
                                        .font(Font.custom("Ubunutu-Regular", size: 18))
                                        .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                                        .foregroundColor(.black)
                                    Text("beschrijving over hoe kapot de wasbak eigelijk wel is.")
                                        .frame(width: 150.0)
                                        .multilineTextAlignment(.leading)
                                        .font(Font.custom("Ubunutu-Regular", size: 12))
                                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 5, trailing: 10))
                                        .foregroundColor(.black)
                                }
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                                .overlay(RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color(red: 0.44313725490196076, green: 0.38823529411764707, blue: 1.0), lineWidth: 2))
                            }
                        }
                        // ------ einde van een zoekertje
                        
                        Spacer()
                        
                        // ------ begin van een zoekertje
                        Button {
                            print("Button was tapped")
                        } label: {
                            VStack(alignment: .leading){
                                Image("BrokenSink")
                                    .resizable()
                                    .cornerRadius(16, corners: [.topLeft,.topRight])
                                    .frame(width: 175.0, height: 175.0)
                                Text("Wasbak lekt")
                                    .font(Font.custom("Ubunutu-Regular", size: 18))
                                    .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                                    .foregroundColor(.black)
                                Text("beschrijving over hoe kapot de wasbak eigelijk wel is.")
                                    .frame(width: 150.0)
                                    .multilineTextAlignment(.leading)
                                    .font(Font.custom("Ubunutu-Regular", size: 12))
                                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 5, trailing: 10))
                                    .foregroundColor(.black)
                            }
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                            .overlay(RoundedRectangle(cornerRadius: 16)
                                .stroke(Color(red: 0.44313725490196076, green: 0.38823529411764707, blue: 1.0), lineWidth: 2))
                        }
                        // ------ einde van een zoekertje
                        
                        Spacer()
                        
                    }.padding(EdgeInsets(top: 15, leading: 0, bottom: 15, trailing: 0))
                    // -------- einde van 2 zoekertjes in een HStack
                    
                    // -------- begin van 2 zoekertjes in een HStack
                    HStack{
                        Spacer()
                        
                        // ------ begin van een zoekertje
                        Button {
                            print("Button was tapped")
                        } label: {
                            VStack(alignment: .leading){
                                Image("BrokenSink")
                                    .resizable()
                                    .cornerRadius(16, corners: [.topLeft,.topRight])
                                    .frame(width: 175.0, height: 175.0)
                                Text("Wasbak lekt")
                                    .font(Font.custom("Ubunutu-Regular", size: 18))
                                    .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                                    .foregroundColor(.black)
                                Text("beschrijving over hoe kapot de wasbak eigelijk wel is.")
                                    .frame(width: 150.0)
                                    .multilineTextAlignment(.leading)
                                    .font(Font.custom("Ubunutu-Regular", size: 12))
                                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 5, trailing: 10))
                                    .foregroundColor(.black)
                            }
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                            .overlay(RoundedRectangle(cornerRadius: 16)
                                .stroke(Color(red: 0.44313725490196076, green: 0.38823529411764707, blue: 1.0), lineWidth: 2))
                        }
                        // ------ einde van een zoekertje
                        
                        Spacer()
                        
                        // ------ begin van een zoekertje
                        Button {
                            print("Button was tapped")
                        } label: {
                            VStack(alignment: .leading){
                                Image("BrokenSink")
                                    .resizable()
                                    .cornerRadius(16, corners: [.topLeft,.topRight])
                                    .frame(width: 175.0, height: 175.0)
                                Text("Wasbak lekt")
                                    .font(Font.custom("Ubunutu-Regular", size: 18))
                                    .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                                    .foregroundColor(.black)
                                Text("beschrijving over hoe kapot de wasbak eigelijk wel is.")
                                    .frame(width: 150.0)
                                    .multilineTextAlignment(.leading)
                                    .font(Font.custom("Ubunutu-Regular", size: 12))
                                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 5, trailing: 10))
                                    .foregroundColor(.black)
                            }
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                            .overlay(RoundedRectangle(cornerRadius: 16)
                                .stroke(Color(red: 0.44313725490196076, green: 0.38823529411764707, blue: 1.0), lineWidth: 2))
                        }
                        // ------ einde van een zoekertje
                        
                        Spacer()
                        
                    }.padding(EdgeInsets(top: 0, leading: 0, bottom: 15, trailing: 0))
                    // -------- einde van 2 zoekertjes in een HStack
                    
                    // -------- begin van 2 zoekertjes in een HStack
                    HStack{
                        Spacer()
                        
                        // ------ begin van een zoekertje
                        Button {
                            print("Button was tapped")
                        } label: {
                            VStack(alignment: .leading){
                                Image("BrokenSink")
                                    .resizable()
                                    .cornerRadius(16, corners: [.topLeft,.topRight])
                                    .frame(width: 175.0, height: 175.0)
                                Text("Wasbak lekt")
                                    .font(Font.custom("Ubunutu-Regular", size: 18))
                                    .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                                    .foregroundColor(.black)
                                Text("beschrijving over hoe kapot de wasbak eigelijk wel is.")
                                    .frame(width: 150.0)
                                    .multilineTextAlignment(.leading)
                                    .font(Font.custom("Ubunutu-Regular", size: 12))
                                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 5, trailing: 10))
                                    .foregroundColor(.black)
                            }
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                            .overlay(RoundedRectangle(cornerRadius: 16)
                                .stroke(Color(red: 0.44313725490196076, green: 0.38823529411764707, blue: 1.0), lineWidth: 2))
                        }
                        // ------ einde van een zoekertje
                        
                        Spacer()
                        
                        // ------ begin van een zoekertje
                        Button {
                            print("Button was tapped")
                        } label: {
                            VStack(alignment: .leading){
                                Image("BrokenSink")
                                    .resizable()
                                    .cornerRadius(16, corners: [.topLeft,.topRight])
                                    .frame(width: 175.0, height: 175.0)
                                Text("Wasbak lekt")
                                    .font(Font.custom("Ubunutu-Regular", size: 18))
                                    .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                                    .foregroundColor(.black)
                                Text("beschrijving over hoe kapot de wasbak eigelijk wel is.")
                                    .frame(width: 150.0)
                                    .multilineTextAlignment(.leading)
                                    .font(Font.custom("Ubunutu-Regular", size: 12))
                                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 5, trailing: 10))
                                    .foregroundColor(.black)
                            }
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                            .overlay(RoundedRectangle(cornerRadius: 16)
                                .stroke(Color(red: 0.44313725490196076, green: 0.38823529411764707, blue: 1.0), lineWidth: 2))
                        }
                        // ------ einde van een zoekertje
                        
                        Spacer()
                        
                    }.padding(EdgeInsets(top: 0, leading: 0, bottom: 15, trailing: 0))
                    // -------- einde van 2 zoekertjes in een HStack
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Terug")
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("Alle Werken").font(Font.custom("BebasNeue-Regular", size: 24))
                    }
                }
                
            }.padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
        }
    }
}

struct AlleWerken_Previews: PreviewProvider {
    static var previews: some View {
        AlleWerken()
    }
}
