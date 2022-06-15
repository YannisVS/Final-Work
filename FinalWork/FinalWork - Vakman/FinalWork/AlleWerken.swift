//
//  AllWorks.swift
//  FinalWork
//
//  Created by Yannis Van Steen on 12/05/2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct AlleWerken: View {
    
    @State @ObservedObject var Selectedbuttonvm : ButtonListViewModel
    @ObservedObject private var buttonvm = ButtonListViewModel()
    @ObservedObject private var vm = MainViewModel()
    
    @State var isIndividueelWerkIngedrukt = false
    
    @State var selectedData: WerkButton
    
    let columns = [
            GridItem(.adaptive(minimum: 150))
        ]
    
    
    var specialisaties: [String] = ["Specialisatie","Tuinier", "Dakwerker", "Glazenwasser", "Loodgieter", "Elektricien", "Schrijnwerken", "Schilder"]
    
    var provincies: [String] = ["Provincie" ,"Oost-Vlaanderen", "Vlaams-Brabant", "West-Vlaanderen", "Antwerpen", "Limburg", "Brussel"]
    
    @State private var zoekterm: String = ""
    @State private var filterDate: Date = Date().dayBefore
    @State private var clickedWerkId: Int64 = 0
    @State private var filterDateString = ""
    
    @State private var geselecteerdeSpecialisatie = ""
    @State private var geselecteerdeProvincie = ""
    
    @State var filterByProvincie: FilterTypeByProvincie
    @State var filterBySpecialisatie: FilterTypeBySpecialisatie
    @State var filterByDate: FilterTypeByDate
    
    enum FilterTypeByProvincie {
            case none, provincieSelected
        }
        
        enum FilterTypeBySpecialisatie {
            case none, specialisatieSelected
        }
    
    enum FilterTypeByDate {
        case none, dateSelected
    }

 
    var filteredDocumentsByProvincie: [WerkButton] {
            switch filterByProvincie {
            case  .none:
                return buttonvm.werkButtons
            case .provincieSelected:
                return buttonvm.werkButtons.filter { $0.provincie == geselecteerdeProvincie }
            }
        }
    
    var filteredDocumentsBySpecialisatie: [WerkButton] {
            switch filterBySpecialisatie {
            case  .none:
                return filteredDocumentsByProvincie
            case .specialisatieSelected:
                return filteredDocumentsByProvincie.filter { $0.specialisatie == geselecteerdeSpecialisatie }
            }
        }
    
    var filteredDocumentsByDate: [WerkButton] {
            switch filterByDate {
            case  .none:
                return filteredDocumentsBySpecialisatie
            case .dateSelected:
                return filteredDocumentsBySpecialisatie.filter { $0.datum == filterDateString }
            }
        }
    
    
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
                    .textInputAutocapitalization(.never)
                
                
                Spacer()
                Spacer()
                
                DisclosureGroup("Filter") {
                    Spacer()
                    Spacer()
                    DatePicker(selection: $filterDate,displayedComponents: [.date], label: { Text("Uitvoerdatum") })
                    Spacer()
                    HStack{
                        VStack(alignment: .leading, spacing: 0){
                            Spacer()
                            Text("Specialisatie")
                        Picker("Kies een specialisatie", selection: $geselecteerdeSpecialisatie) {
                            ForEach(specialisaties, id: \.self) {
                                Text($0)
                            }
                        }.padding(.bottom)
                        }
                        Spacer()
                        VStack(alignment: .leading, spacing: 0){
                            Spacer()
                        Text("Provincie")
                        Picker("Kies een provincie", selection: $geselecteerdeProvincie) {
                            ForEach(provincies, id: \.self) {
                                Text($0)
                            }
                        }.padding(.bottom)
                        }
                    }
                    HStack{
                        Spacer()
                        Button{
                            filterDate = Date().dayBefore
                            zoekterm = ""
                            geselecteerdeProvincie = "Provincie"
                            geselecteerdeSpecialisatie = "Specialisatie"
                            filterByProvincie = .none
                            filterBySpecialisatie = .none
                            filterByDate = .none
                        } label: {
                            Text("Resetten")
                        }
                        Spacer()
                        Button{
                            let formatter = DateFormatter()
                            formatter.dateFormat = "yyyy-MM-dd"
                            let yesterday = formatter.string(from: Date().dayBefore)
                            filterDateString = formatter.string(from: filterDate)
                            
                            print(yesterday)
                            print(filterDateString)
                            
                            if geselecteerdeProvincie != "" && geselecteerdeProvincie != "Provincie" {
                                filterByProvincie = .provincieSelected
                            } else{
                                filterByProvincie = .none
                            }
                          
                            if geselecteerdeSpecialisatie != "" && geselecteerdeSpecialisatie != "Specialisatie" {
                                filterBySpecialisatie = .specialisatieSelected
                            } else {
                                filterBySpecialisatie = .none
                            }
                            
                            if filterDateString != yesterday {
                                filterByDate = .dateSelected
                            } else if filterDateString == yesterday {
                                filterByDate = .none
                            }
                        } label: {
                            Text("Toepassen")
                        }
                        Spacer()
                    }
                }
                .frame(width: 350)
                .padding(10)
                .background(Color.gray.opacity(0.10))
                .cornerRadius(10)
                Spacer()
                Spacer()
                
                ScrollView {
                    if #available(iOS 15.0, *){
                        //Text("CURRENT USER ID: \(vm.vakman?.email ?? "")")
                        LazyVGrid(columns: columns, spacing: 20) {
                                ForEach(filteredDocumentsByDate) { werk in
                                    if !werk.goedgekeurd {
                                        if zoekterm == ""{
                                        Button {
                                            Selectedbuttonvm = ButtonListViewModel(ReviecedDocumentId: werk.documentId, RecievedFromid: werk.fromid)
                                            selectedData = werk
                                            isIndividueelWerkIngedrukt=true
                                        } label: {
                                            VStack(alignment: .leading){
                                                WebImage(url: URL(string: werk.image1))
                                                        .resizable()
                                                        .cornerRadius(16, corners: [.topLeft,.topRight])
                                                        .frame(width: 175.0, height: 175.0)
                                                        .border(width: 2, edges: [.bottom], color: Color(red: 0.44313725490196076, green: 0.38823529411764707, blue: 1.0))
                                                
                                                Text(werk.titel)
                                                    .font(Font.custom("Ubunutu-Regular", size: 18))
                                                    .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                                                    .foregroundColor(.black)
                                                Text(werk.beschrijving)
                                                    .frame(width: 150.0, height: 50)
                                                    .multilineTextAlignment(.leading)
                                                    .font(Font.custom("Ubunutu-Regular", size: 12))
                                                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 5, trailing: 10))
                                                    .foregroundColor(.black)
                                            }
                                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                                            .background(Color(UIColor.systemGray6))
                                            .cornerRadius(16)
                                            .overlay(RoundedRectangle(cornerRadius: 16)
                                                .stroke(Color(red: 0.44313725490196076, green: 0.38823529411764707, blue: 1.0), lineWidth: 2))
                                        }
                                        } else if werk.titel.lowercased().contains(zoekterm) || werk.titel.uppercased().contains(zoekterm){
                                            
                                                Button {
                                                    Selectedbuttonvm = ButtonListViewModel(ReviecedDocumentId: werk.documentId, RecievedFromid: werk.fromid)
                                                    selectedData = werk
                                                    isIndividueelWerkIngedrukt=true
                                                } label: {
                                                    VStack(alignment: .leading){
                                                        WebImage(url: URL(string: werk.image1))
                                                                .resizable()
                                                                .cornerRadius(16, corners: [.topLeft,.topRight])
                                                                .frame(width: 175.0, height: 175.0)
                                                                .border(width: 2, edges: [.bottom], color: Color(red: 0.44313725490196076, green: 0.38823529411764707, blue: 1.0))
                                                        
                                                        Text(werk.titel)
                                                            .font(Font.custom("Ubunutu-Regular", size: 18))
                                                            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                                                            .foregroundColor(.black)
                                                        Text(werk.beschrijving)
                                                            .frame(width: 150.0, height: 50)
                                                            .multilineTextAlignment(.leading)
                                                            .font(Font.custom("Ubunutu-Regular", size: 12))
                                                            .padding(EdgeInsets(top: 0, leading: 10, bottom: 5, trailing: 10))
                                                            .foregroundColor(.black)
                                                    }
                                                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                                                    .background(Color(UIColor.systemGray6))
                                                    .cornerRadius(16)
                                                    .overlay(RoundedRectangle(cornerRadius: 16)
                                                        .stroke(Color(red: 0.44313725490196076, green: 0.38823529411764707, blue: 1.0), lineWidth: 2))
                                                }
                                        } else{}
                                    }
                                }
                            
                        }
                        .background(
                            NavigationLink(destination: DetailsWerk(recievedButtonview: Selectedbuttonvm),
                                           isActive: $isIndividueelWerkIngedrukt) {EmptyView()}
                        )
                        .padding(.horizontal)
                        .padding(.top)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Terug")
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Text("Manus").font(Font.custom("BebasNeue-Regular", size: 24))
                            .padding(.leading, 2)
                        Spacer()
                        Spacer()
                        Text("Alle Werken").font(Font.custom("BebasNeue-Regular", size: 24))
                        Spacer()
                        Spacer()
                        Spacer()
                    }
                }
                
            }.padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
        }
    }
}

struct AlleWerken_Previews: PreviewProvider {
    static var previews: some View {
        AlleWerken(Selectedbuttonvm: ButtonListViewModel(), selectedData: WerkButton(documentId: "", data: [:]), filterByProvincie: .none, filterBySpecialisatie: .none, filterByDate: .none )

    }
}
