//
//  MyWorks.swift
//  FinalWork
//
//  Created by Yannis Van Steen on 12/05/2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct AddWerkView: View {
    
    
    @ObservedObject var buttonvm = ButtonListViewModel()
    
    @Binding var popoverWordWeergegeven: Bool
    @Binding var ladenWordWeergegeven: Bool
    
    @State var toonToevoegBevestiging = false
    @State private var toontFotoSelecteer1 = false
    @State private var toontFotoSelecteer2 = false
    @State private var toontFotoSelecteer3 = false
    @State var image1 = UIImage(named: "ToevoegenAfbeelding")!
    @State var image2 = UIImage(named: "ToevoegenAfbeelding")!
    @State var image3 = UIImage(named: "ToevoegenAfbeelding")!
    @State private var beschrijving = "Vul hier uw beschijving in"
    @State private var beschrijvingIngedrukt = false
    @State private var titel = ""
    @State private var gemeente = ""
    @State private var postcode = ""
    @State private var straatnaam = ""
    @State private var huisnummer = ""
    @State private var trackAndTrace = "In Voorbereiding"
    @State private var datum: Date = Date()
    @State private var prioriteit = false
    @State private var goedgekeurd = false
    @State var errorMessage = " "
    @State var errorMessageImage = " "
    @State var errorMessageTitel = " "
    @State var errorMessageBeschrijving = " "
    @State var errorMessageLocatie = " "
    @State var errorMessageProvincieEnSpecialisatie = " "
    
    @State private var geselecteerdeProvincie = ""
    @State private var geselecteerdeSpecialisatie = ""
    
    var specialisaties: [String] = ["Specialisatie","Tuinier", "Dakwerker", "Glazenwasser", "Loodgieter", "Elektricien", "Schrijnwerken", "Schilder"]
    var provincies: [String] = [ "Provincie", "Oost-Vlaanderen", "Vlaams-Brabant", "West-Vlaanderen", "Antwerpen", "Limburg", "Brussel"]
    
    var body: some View {
        
        VStack {
            HStack{
                Button("Annuleer") {
                    popoverWordWeergegeven = false
                }.padding(25)
                Spacer()
                Button("Toevoegen") {
                    if image1 == UIImage(named: "ToevoegenAfbeelding") || image2 == UIImage(named: "ToevoegenAfbeelding") || image3 == UIImage(named: "ToevoegenAfbeelding")  {
                        errorMessageImage = "Niet alle 3 de afbeeldingen zijn selecteren"
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            errorMessageImage = " "
                        }
                    } else if titel == "" {
                        errorMessageTitel = "Gelieve een titel in te vullen"
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            errorMessageTitel = " "
                        }
                    } else if beschrijving == "" || beschrijving == "Vul hier uw beschijving in" {
                        errorMessageBeschrijving = "Gelieve een beschrijving in te vullen"
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            errorMessageBeschrijving = " "
                        }
                    } else if geselecteerdeProvincie == "" || geselecteerdeProvincie == "Provincie"  || geselecteerdeSpecialisatie == "" || geselecteerdeSpecialisatie == "Specialisatie" {
                        errorMessageProvincieEnSpecialisatie = "Gelieve een provincie en of specialisatie in te vullen"
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            errorMessageProvincieEnSpecialisatie = " "
                        }
                    }  else if gemeente == "" || postcode == "" || straatnaam == "" || huisnummer == "" {
                        errorMessageLocatie = "Gelieve alle velden van locatie in te vullen"
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            errorMessageLocatie = " "
                        }
                    }
                    else {
                        toonToevoegBevestiging = true
                    }
                    
                }.padding(25)
            }
            ScrollView {
                VStack(alignment: .center, spacing: 10, content:{
                    HStack(alignment: .center, spacing: 20, content: {
                        VStack {
                            Button {
                                toontFotoSelecteer1 = true
                            } label: {
                                VStack{
                                    Image(uiImage: image1)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 100, height: 75)
                                    Text("Voeg foto toe").padding(.top)
                                }
                            }.padding(.top,5)
                        }.sheet(isPresented: $toontFotoSelecteer1, content:{
                            FotoSelector(werkImage: $image1)
                        })
                        
                        
                        VStack {
                            Button {
                                toontFotoSelecteer2 = true
                            } label: {
                                VStack{
                                    Image(uiImage: image2)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 100, height: 75)
                                    Text("Voeg foto toe").padding(.top)
                                }
                            }.padding(.top,5)
                        }.sheet(isPresented: $toontFotoSelecteer2, content:{
                            FotoSelector(werkImage: $image2)
                        })
                        
                        VStack {
                            Button {
                                toontFotoSelecteer3 = true
                            } label: {
                                VStack {
                                    Image(uiImage: image3)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 100, height: 75)
                                    Text("Voeg foto toe").padding(.top)
                                }
                            }.padding(.top,5)
                        }.sheet(isPresented: $toontFotoSelecteer3, content:{
                            FotoSelector(werkImage: $image3)
                        })
                    })
                    Text("Gelieve 3 foto's toe te voegen voor een duidelijke representatie van het probleem")
                        .frame(width: 325).font(Font.custom("Ubuntu-italic", size: 12)).padding(5)
                        .foregroundColor(Color(.systemGray))
                        .padding(.trailing, 40)
                    Text(errorMessageImage)
                        .foregroundColor(Color.red)
                        .font(Font.custom("Ubuntu-Regular", size: 12)).padding(5)
                })
                VStack {
                    Divider().padding([.bottom, .leading, .trailing])
                    VStack(alignment: .leading, spacing: 0, content: {
                        HStack(alignment: .center, spacing: 10, content:{
                            Text("Titel").font(Font.custom("Ubuntu-Bold", size: 16)).padding(5)
                            Text(errorMessageTitel)
                                .foregroundColor(Color.red)
                                .font(Font.custom("Ubuntu-Regular", size: 12)).padding(5)
                        })
                        TextField("Vul hier uw titel in", text: $titel)
                            .multilineTextAlignment(.leading)
                            .frame(width: 375, height: 30)
                            .font(Font.custom("Ubuntu-Regular", size: 16)).padding(5)
                            .foregroundColor(Color(red: 0.44313725490196076, green: 0.38823529411764707, blue: 1))
                    }).padding(.leading, 10)
                    
                    Divider().padding()
                    VStack(alignment: .leading, spacing: 0, content: {
                        HStack(alignment: .center, spacing: 10, content:{
                            Text("Beschrijving").font(Font.custom("Ubuntu-Bold", size: 16)).padding(5)
                            Text(errorMessageBeschrijving)
                                .foregroundColor(Color.red)
                                .font(Font.custom("Ubuntu-Regular", size: 12)).padding(5)
                        })
                        
                        TextEditor(text: $beschrijving)
                            .multilineTextAlignment(.leading)
                            .frame(width: 375, height: 100)
                            .font(Font.custom("Ubuntu-Regular", size: 16))
                            .foregroundColor(beschrijvingIngedrukt ? Color(red: 0.44313725490196076, green: 0.38823529411764707, blue: 1) : Color(.systemGray3))
                            .onTapGesture {
                                if beschrijvingIngedrukt == false {
                                    beschrijving = ""
                                    beschrijvingIngedrukt = true
                                }
                            }
                        
                    })
                    Divider().padding()
                    VStack{
                        HStack{
                            VStack(alignment: .leading) {
                                Text("Specialisatie").font(Font.custom("Ubuntu-Bold", size: 16))
                                Spacer()
                                Picker("Kies een specialisatie", selection: $geselecteerdeSpecialisatie) {
                                    ForEach(specialisaties, id: \.self) {
                                        Text($0)
                                    }
                                }
                            }.padding()
                            Spacer()
                            VStack(alignment: .leading) {
                                Text("Provincie").font(Font.custom("Ubuntu-Bold", size: 16))
                                Spacer()
                                Picker("Kies een provincie", selection: $geselecteerdeProvincie) {
                                    ForEach(provincies, id: \.self) {
                                        Text($0)
                                    }
                                }
                            }.padding()
                            Spacer()
                        }.padding(.leading, 5)
                        VStack{
                            Text(errorMessageProvincieEnSpecialisatie)
                                .foregroundColor(Color.red)
                                .font(Font.custom("Ubuntu-Regular", size: 12))
                            Divider().padding()
                        }
                        HStack(alignment: .firstTextBaseline, spacing: 0, content: {
                            VStack(alignment: .leading, spacing: 0, content: {
                                Text("Gemeente").font(Font.custom("Ubuntu-Bold", size: 16)).padding(5)
                                HStack(alignment: .center, spacing: 10, content:{
                                    TextField("Vul uw gemeente in", text: $gemeente)
                                        .multilineTextAlignment(.leading)
                                        .frame(width: 175, height: 30)
                                        .font(Font.custom("Ubuntu-Regular", size: 16)).padding(5)
                                        .foregroundColor(Color(red: 0.44313725490196076, green: 0.38823529411764707, blue: 1))
                                })
                                
                                Spacer()
                                Text("Straatnaam").font(Font.custom("Ubuntu-Bold", size: 16)).padding(5)
                                TextField("Vul uw straatnaam in", text: $straatnaam)
                                    .multilineTextAlignment(.leading)
                                    .frame(width: 175, height: 30)
                                    .font(Font.custom("Ubuntu-Regular", size: 16)).padding(5)
                                    .foregroundColor(Color(red: 0.44313725490196076, green: 0.38823529411764707, blue: 1))
                                
                            }).padding(.leading, 15)
                            Spacer()
                            VStack(alignment: .leading, spacing: 0, content:{
                                Text("Postcode").font(Font.custom("Ubuntu-Bold", size: 16)).padding(5)
                                TextField("Vul uw postcode in", text: $postcode)
                                    .multilineTextAlignment(.leading)
                                    .frame(width: 175, height: 30)
                                    .font(Font.custom("Ubuntu-Regular", size: 16)).padding(5)
                                    .foregroundColor(Color(red: 0.44313725490196076, green: 0.38823529411764707, blue: 1))
                                    .keyboardType(.numberPad)
                                Spacer()
                                Text("Huisnummer").font(Font.custom("Ubuntu-Bold", size: 16)).padding(5)
                                TextField("Vul uw huisnummer in", text: $huisnummer)
                                    .multilineTextAlignment(.leading)
                                    .frame(width: 175, height: 30)
                                    .font(Font.custom("Ubuntu-Regular", size: 16)).padding(5)
                                    .foregroundColor(Color(red: 0.44313725490196076, green: 0.38823529411764707, blue: 1))
                                    .keyboardType(.numberPad)
                            })
                            Spacer()
                        })
                    }
                    VStack {
                        Text(errorMessageLocatie)
                            .foregroundColor(Color.red)
                            .font(Font.custom("Ubuntu-Regular", size: 12)).padding(5)
                        Divider().padding()
                    }
                    
                    VStack(alignment: .leading, spacing: 0, content: {
                        HStack{
                            VStack(alignment: .leading, spacing: 0, content: {
                                DatePicker(selection: $datum,displayedComponents: [.date], label: {
                                    Text("Uitvoerdatum").font(Font.custom("Ubuntu-Bold", size: 16)).padding(5)
                                })
                                
                            }).padding([.leading,.trailing])
                            Spacer()
                        }
                    })
                    Divider().padding()
                    VStack{
                        Toggle(isOn: $prioriteit) {
                            Text("Hoge prioriteit")
                                .font(Font.custom("Ubuntu-Bold", size: 16)).padding(5)
                        }.padding(.bottom)
                        Text("Hoge prioriteit wil zeggen dat alle vakmannen in de buurt een melding zullen krijgen van jouw werk. Dit resulteert in een hogere zichtbaarheid van jouw werk. \n\nHet aanduiden van deze optie zal bij betallling voor een meerprijs van 5 euro zorgen") .font(Font.custom("Ubuntu-italic", size: 12)).padding(5)
                            .foregroundColor(Color(.systemGray))
                    }.padding()
                }
            }
        }
        .alert(isPresented: $toonToevoegBevestiging){
            Alert(
                title: Text("Zeker dat je dit werk wil toevoeggen?"),
                message: Text("je kan niet alle data later nog bewerken!"),
                primaryButton: .default(Text("Toevoegen")){
                    ladenWordWeergegeven = true
                    buttonvm.slaWerkInformationOp(fromuid: FirebaseManager.shared.auth.currentUser?.uid ?? "", titel: titel, beschrijving: beschrijving, gemeente: gemeente, postcode: postcode, straatnaam: straatnaam, huisnummer: huisnummer, trackAndTrace: trackAndTrace, datum: datum, prioriteit: prioriteit, goedgekeurd: goedgekeurd, image1: image1, image2: image2, image3: image3, provincie: geselecteerdeProvincie, specialisatie: geselecteerdeSpecialisatie)
                    popoverWordWeergegeven = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                        ladenWordWeergegeven = false
                    }
                },
                secondaryButton: .cancel()
            )
        }
        
    }
}



struct MijnWerken: View {
    
    @State var laadschermWeergegeven = false
    @State var isIndividueelWerkIngedrukt = false
    @State private var popoverWeergeven: Bool = false
    @State var isGoedgekeurdWeergegeven = true
    
    @ObservedObject private var buttonvm = ButtonListViewModel()
    @State @ObservedObject var selectedButtonvm : ButtonListViewModel
    @State @ObservedObject var selectedVakmanvm : ButtonListViewModel
    
    @ObservedObject private var vm = MainViewModel()
    
    @State var selectedData: WerkButton
    
    let columns = [
        GridItem(.adaptive(minimum: 140))
    ]
    
    var body: some View {

        NavigationView{
            ZStack{
            
                VStack {
                    
                    HStack(alignment: .center, spacing: 30, content:{
                        Picker(selection: $isGoedgekeurdWeergegeven, label: Text("Picker here")){
                            Text("Goedgekeurd")
                                .tag(true)
                            Text("In afwachting")
                                .tag(false)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding()
                    })
                    ScrollView {
                        //Text("CURRENT USER ID: \(vm.user?.email ?? "")")
                        if #available(iOS 15.0, *){
                            LazyVGrid(columns: columns, spacing: 20) {
                                if isGoedgekeurdWeergegeven {
                                    ForEach(buttonvm.werkButtons) { werk in
                                        if werk.goedgekeurd {
                                            Button {
                                                selectedButtonvm = ButtonListViewModel(ReviecedDocumentId: werk.documentId, RecievedFromid: werk.fromid)
                                                selectedData = werk
                                                selectedVakmanvm = ButtonListViewModel(RecievedVakmanId: werk.vakmanArray)
                                                isIndividueelWerkIngedrukt=true
                                                
                                            } label: {
                                                VStack(alignment: .leading){
                                                    ZStack(alignment: .topLeading ,content: {
                                                        WebImage(url: URL(string: werk.image1))
                                                            .resizable()
                                                            .frame(width: 175.0, height: 175.0)
                                                            .scaledToFit()
                                                            .cornerRadius(16, corners: [.topLeft,.topRight])
                                                            .border(width: 2, edges: [.bottom], color: Color(red: 0.44313725490196076, green: 0.38823529411764707, blue: 1.0))
                                                        
                                                        Text(werk.trackAndTrace)
                                                            .foregroundColor(Color.white)
                                                            .padding(7)
                                                            .background(Color(red: 1, green: 0.49411764705882355, blue: 0.4392156862745098))
                                                            .cornerRadius(50)
                                                            .font(Font.custom("Ubunutu-Regular", size: 12))
                                                            .padding(10)
                                                    })
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
                                        }
                                    }
                                }
                                else {
                                    ForEach(buttonvm.werkButtons) { werk in
                                        if !werk.goedgekeurd {
                                            Button {
                                                selectedButtonvm = ButtonListViewModel(ReviecedDocumentId: werk.documentId, RecievedFromid: werk.fromid)
                                                selectedData = werk
                                                selectedVakmanvm = ButtonListViewModel(RecievedVakmanId: werk.vakmanArray)
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
                                            
                                        }
                                    }
                                }
                            }
                            .padding(.top)
                            .background(
                                NavigationLink(destination: DetailsWerk(buttonvm: selectedButtonvm, vakmanvm: selectedVakmanvm, detailsWordWeergegeven: $isIndividueelWerkIngedrukt),
                                               isActive: $isIndividueelWerkIngedrukt) {EmptyView()}
                            )
                            .padding(.horizontal)
                            .padding(.bottom)
                        }
                    }
                }
                VStack{
                    Spacer()
                    HStack{
                        Spacer()
                        ActivityIndicatorView(isDisplayed: $laadschermWeergegeven, content: {
                            Text("")
                        }).frame(width: 150, height: 150)
                        Spacer()
                    }
                    Spacer()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Terug")
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Text("Manus").font(Font.custom("BebasNeue-Regular", size: 24))
                            .padding(.leading, 8)
                        Spacer()
                        Spacer()
                        Text("Mijn Werken").font(Font.custom("BebasNeue-Regular", size: 24))
                        Spacer()
                        Spacer()
                    }
                }
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    
                    Button{
                        popoverWeergeven = true
                    }label: {
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: 20.0, height: 20.0)
                            .foregroundColor(Color(red: 0.44313725490196076, green: 0.38823529411764707, blue: 1.0))
                    }
                }
            }.padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
        }
        .popover(isPresented: $popoverWeergeven) {
            AddWerkView(popoverWordWeergegeven: $popoverWeergeven, ladenWordWeergegeven: $laadschermWeergegeven)
        }
    }
    
}

struct MijnWerken_Previews: PreviewProvider {
    static var previews: some View {
        MijnWerken(selectedButtonvm: ButtonListViewModel(), selectedVakmanvm: ButtonListViewModel(), selectedData: WerkButton(documentId: "", data: [:]))
    }
}
