//
//  Artiekel.swift
//  FinalWork
//
//  Created by Yannis Van Steen on 16/05/2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct UpdateWerkView: View {

    
    @ObservedObject var buttonvm : ButtonListViewModel
    @Binding var popoverWordWeergegeven: Bool
    @Binding var detailsWordWeergegevenUpdate: Bool
    
    @State private var toonToevoegBevestiging = false
    @State var image1 : String
    @State var image2 : String
    @State var image3 : String
    @State var beschrijving : String
    @State var titel : String
    @State var gemeente : String
    @State var postcode : String
    @State var straatnaam : String
    @State var huisnummer : String
    @State var datum : String
    @State var prioriteit : Bool
    @State private var errorMessage = " "
    @State private var errorMessageImage = " "
    @State private var errorMessageTitel = " "
    @State private var errorMessageBeschrijving = " "
    @State private var errorMessageLocatie = " "
    @State private var errorMessageProvincieEnSpecialisatie = " "

    @State var geselecteerdeProvincie : String
    @State var geselecteerdeSpecialisatie : String
    
    var specialisaties: [String] = ["Specialisatie","Tuinier", "Dakwerker", "Glazenwasser", "Loodgieter", "Elektricien", "Schrijnwerken", "Schilder"]
    var provincies: [String] = [ "Provincie", "Oost-Vlaanderen", "Vlaams-Brabant", "West-Vlaanderen", "Antwerpen", "Limburg", "Brussel"]
    
    var body: some View {
        
        VStack {
            HStack{
                Button("Annuleer") {
                    popoverWordWeergegeven = false
                }.padding(25)
                Spacer()
                Button("Bijwerken") {
                    if titel == "" {
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
                        WebImage(url: URL(string: image1))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 75)
                        WebImage(url: URL(string: image2))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 75)
                        WebImage(url: URL(string: image3))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 75)
                    })
                    Text("Foto's zijn niet meer aanpasbaar")
                        .frame(width: 325).font(Font.custom("Ubuntu-italic", size: 12)).padding(5)
                        .foregroundColor(Color(.systemGray))
                        .padding(.top, 15)
                        .padding(.trailing, 70)
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
                            .foregroundColor(Color(red: 0.44313725490196076, green: 0.38823529411764707, blue: 1))
                        
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
                            Spacer()
                            Text("Huisnummer").font(Font.custom("Ubuntu-Bold", size: 16)).padding(5)
                            TextField("Vul uw huisnummer in", text: $huisnummer)
                                .multilineTextAlignment(.leading)
                                .frame(width: 175, height: 30)
                                .font(Font.custom("Ubuntu-Regular", size: 16)).padding(5)
                                .foregroundColor(Color(red: 0.44313725490196076, green: 0.38823529411764707, blue: 1))
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
                                HStack{
                                    Text("Uitvoerdatum").font(Font.custom("Ubuntu-Bold", size: 16)).padding(5)
                                    Text(datum)
                                        .font(Font.custom("Ubuntu-Regular", size: 16)).padding(5)
                                        .foregroundColor(Color(red: 0.44313725490196076, green: 0.38823529411764707, blue: 1))
                                    Text("datum is niet meer aanpasbaar")
                                        .font(Font.custom("Ubuntu-italic", size: 12)).padding(5)
                                        .foregroundColor(Color(.systemGray))
                                }
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
                title: Text("Zeker dat je dit werk wil bijwerken?"),
                message: Text("Lees zeker nog eens extra door!"),
                primaryButton: .default(Text("Bijwerken")){
                    popoverWordWeergegeven = false
                    detailsWordWeergegevenUpdate = false
                    print("fromid")
                    print(buttonvm.werkButtonDetail?.fromid ?? "")
                    buttonvm.updateWerkInformation(fromuid: buttonvm.werkButtonDetail?.fromid ?? "",documentId: buttonvm.werkButtonDetail?.documentId ?? "" ,titel: titel, beschrijving: beschrijving, gemeente: gemeente, postcode: postcode, straatnaam: straatnaam, huisnummer: huisnummer, prioriteit: prioriteit, provincie: geselecteerdeProvincie, specialisatie: geselecteerdeSpecialisatie)
                },
                secondaryButton: .cancel()
            )
        }
        
    }
}

struct DetailsWerk: View {
    
    @ObservedObject var buttonvm : ButtonListViewModel
    @ObservedObject var vakmanvm : ButtonListViewModel
    @Binding var detailsWordWeergegeven: Bool
    
    @State private var toonVerwijderBevestiging = false
    @State private var toonAccepteerBevestiging = false
    @State private var toonWeigerBevestiging = false
    @State private var imageArray : Array<String> = [""]
    @State private var documentId : String = ""
    @State private var fromid : String = ""
    @State private var selectedVakman : String = ""
    @State private var errorReview : String = "Eens u een review geeft aan de vakman zal dit werk worden gearchiveerd"
    @State private var reviewScore: Int = 3
    

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var showingAlert : Bool = false
    @State private var popoverWeergeven: Bool = false
    
    
//    init(recievedButtonview: ButtonListViewModel, recievedVakmanArray: ButtonListViewModel, detailsWordWeergegevenBool: Bool){
//        buttonvm = recievedButtonview
//        vakmanvm = recievedVakmanArray
//        detailsWordWeergegeven = detailsWordWeergegevenBool
//    }
//    
    var body: some View {
        VStack{
            ScrollView{
                VStack{
                    Text(buttonvm.werkButtonDetail?.titel ?? "").font(Font.custom("Ubuntu-Bold", size: 18))
                    GeometryReader {
                        proxy in
                        TabView{
                            ForEach([buttonvm.werkButtonDetail?.image1 ?? "",buttonvm.werkButtonDetail?.image2 ?? "",buttonvm.werkButtonDetail?.image3 ?? "" ], id: \.self){ image in
                                WebImage(url: URL(string: image))
                                    .resizable()
                                    .scaledToFit()
                                    .tag(image)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                        }
                        .tabViewStyle(PageTabViewStyle())
                        .frame(width: proxy.size.width, height: proxy.size.height)
                    }.frame(width: 400,height: 250)
                }
                Divider().padding()
                Text(buttonvm.werkButtonDetail?.beschrijving ?? "").padding()
                Divider().padding()
                HStack(alignment: .firstTextBaseline, spacing: 0, content: {
                    VStack(alignment: .leading, spacing: 0, content: {
                        Text("Gemeente").font(Font.custom("Ubuntu-Bold", size: 16)).padding(5)
                        Text(buttonvm.werkButtonDetail?.gemeente ?? "").font(Font.custom("Ubuntu-Regular", size: 16)).padding(5)
                        Spacer()
                        Text("Straatnaam").font(Font.custom("Ubuntu-Bold", size: 16)).padding(5)
                        Text(buttonvm.werkButtonDetail?.straatnaam ?? "").font(Font.custom("Ubuntu-Regular", size: 16)).padding(5)
                    })
                    Spacer()
                    VStack(alignment: .leading, spacing: 0, content:{
                        Text("Postcode").font(Font.custom("Ubuntu-Bold", size: 16)).padding(5)
                        Text(buttonvm.werkButtonDetail?.postcode ?? "").font(Font.custom("Ubuntu-Regular", size: 16)).padding(5)
                        Spacer()
                        Text("Huisnummer").font(Font.custom("Ubuntu-Bold", size: 16)).padding(5)
                        Text(buttonvm.werkButtonDetail?.huisnummer ?? "").font(Font.custom("Ubuntu-Regular", size: 16)).padding(5)
                    })
                    Spacer()
                }).padding()
                Divider().padding()
                VStack(alignment: .leading, spacing: 0, content: {
                    HStack{
                        VStack(alignment: .leading, spacing: 0, content: {
                            Text("Uitvoerdatum").font(Font.custom("Ubuntu-Bold", size: 16)).padding(5)
                            Text(buttonvm.werkButtonDetail?.datum ?? "").font(Font.custom("Ubuntu-Regular", size: 16)).padding(5)
                        }).padding()
                        Spacer()
                    }
                })
                Divider().padding()
                
                if (buttonvm.werkButtonDetail?.goedgekeurd ?? false){
                VStack{
                    HStack{
                        Text("Track & Trace").font(Font.custom("Ubuntu-Bold", size: 16)).padding()
                        Spacer()
                    }
                    HStack(alignment: .firstTextBaseline, spacing: 15, content: {
                        if buttonvm.werkButtonDetail?.trackAndTrace == "In Voorbereiding" {
                            VStack{
                                Text("")
                                    .frame(width: 110, height: 15, alignment: .center)
                                    .background(Color(red: 0.44313725490196076, green: 0.38823529411764707, blue: 1))
                                    .cornerRadius(50)
                                Text(buttonvm.werkButtonDetail?.trackAndTrace ?? "").font(Font.custom("Ubuntu-Regular", size: 12)).padding(5)
                            }
                            VStack{
                                Text("")
                                    .frame(width: 110, height: 15, alignment: .center)
                                    .background(Color.gray)
                                    .cornerRadius(50)
                            }
                            VStack{
                                Text("")
                                    .frame(width: 110, height: 15, alignment: .center)
                                    .background(Color.gray)
                                    .cornerRadius(50)
                            }
                        }
                        else if buttonvm.werkButtonDetail?.trackAndTrace == "Onderweg" {
                            VStack{
                                Text("")
                                    .frame(width: 110, height: 15, alignment: .center)
                                    .background(Color.gray)
                                    .cornerRadius(50)
                            }
                            VStack{
                                Text("")
                                    .frame(width: 110, height: 15, alignment: .center)
                                    .background(Color(red: 0.44313725490196076, green: 0.38823529411764707, blue: 1))
                                    .cornerRadius(50)
                                Text(buttonvm.werkButtonDetail?.trackAndTrace ?? "").font(Font.custom("Ubuntu-Regular", size: 12)).padding(5)
                            }
                            VStack{
                                Text("")
                                    .frame(width: 110, height: 15, alignment: .center)
                                    .background(Color.gray)
                                    .cornerRadius(50)
                            }
                        }
                        else {
                            VStack{
                                Text("")
                                    .frame(width: 110, height: 15, alignment: .center)
                                    .background(Color.gray)
                                    .cornerRadius(50)
                            }
                            VStack{
                                Text("")
                                    .frame(width: 110, height: 15, alignment: .center)
                                    .background(Color.gray)
                                    .cornerRadius(50)
                            }
                            VStack{
                                Text("")
                                    .frame(width: 110, height: 15, alignment: .center)
                                    .background(Color(red: 0.44313725490196076, green: 0.38823529411764707, blue: 1))
                                    .cornerRadius(50)
                                Text(buttonvm.werkButtonDetail?.trackAndTrace ?? "").font(Font.custom("Ubuntu-Regular", size: 12)).padding(5)
                            }
                        }
                    })
                    Divider().padding()
                }.padding(EdgeInsets(top: 0, leading: 0, bottom: 25, trailing: 0))
            }
                if buttonvm.werkButtonDetail?.goedgekeurd == false {
                ScrollView{
                    HStack{
                        Text("Biedingen van vakmannen").font(Font.custom("Ubuntu-Bold", size: 16)).padding()
                        Spacer()
                    }
                    ForEach(vakmanvm.vakmanenDetails) { vakman in
                    HStack(alignment: .center, spacing: 30, content:{
                        Spacer()
                        VStack{
                            Spacer()
                            Text(vakman.naamVanonderneming)
                            Spacer()
                            Spacer()
                            Spacer()
                            if vakman.gemiddeldeVanReviews == "0.0" {
                                HStack(alignment: .firstTextBaseline, spacing: 2, content: {
                                    Image(systemName: "star")
                                    Image(systemName: "star")
                                    Image(systemName: "star")
                                    Image(systemName: "star")
                                    Image(systemName: "star")
                                })
                            } else if vakman.gemiddeldeVanReviews == "1.0" {
                                HStack(alignment: .firstTextBaseline, spacing: 2, content: {
                                    Image(systemName: "star").foregroundColor(Color.yellow)
                                    Image(systemName: "star")
                                    Image(systemName: "star")
                                    Image(systemName: "star")
                                    Image(systemName: "star")
                                })
                            } else if vakman.gemiddeldeVanReviews == "2.0" {
                                HStack(alignment: .firstTextBaseline, spacing: 2, content: {
                                    Image(systemName: "star").foregroundColor(Color.yellow)
                                    Image(systemName: "star").foregroundColor(Color.yellow)
                                    Image(systemName: "star")
                                    Image(systemName: "star")
                                    Image(systemName: "star")
                                })
                            } else if vakman.gemiddeldeVanReviews == "3.0" {
                                HStack(alignment: .firstTextBaseline, spacing: 2, content: {
                                    Image(systemName: "star").foregroundColor(Color.yellow)
                                    Image(systemName: "star").foregroundColor(Color.yellow)
                                    Image(systemName: "star").foregroundColor(Color.yellow)
                                    Image(systemName: "star")
                                    Image(systemName: "star")
                                })
                            } else if vakman.gemiddeldeVanReviews == "4.0" {
                                HStack(alignment: .firstTextBaseline, spacing: 2, content: {
                                    Image(systemName: "star").foregroundColor(Color.yellow)
                                    Image(systemName: "star").foregroundColor(Color.yellow)
                                    Image(systemName: "star").foregroundColor(Color.yellow)
                                    Image(systemName: "star").foregroundColor(Color.yellow)
                                    Image(systemName: "star")
                                })
                            } else if vakman.gemiddeldeVanReviews == "5.0" {
                                HStack(alignment: .firstTextBaseline, spacing: 2, content: {
                                    Image(systemName: "star").foregroundColor(Color.yellow)
                                    Image(systemName: "star").foregroundColor(Color.yellow)
                                    Image(systemName: "star").foregroundColor(Color.yellow)
                                    Image(systemName: "star").foregroundColor(Color.yellow)
                                    Image(systemName: "star").foregroundColor(Color.yellow)
                                })
                            }
                            Spacer()
                        }
                        VStack{
                            HStack{
                                Text("Uurprijs")
                                Text("€ \(vakman.uurprijs) per uur")
                            }
                            HStack{
                                Spacer()
                                Button(action: {
                                    toonAccepteerBevestiging = true
                                    selectedVakman = vakman.vakmanuid
                                }, label: {
                                    Image(systemName: "checkmark.circle")
                                        .resizable()
                                        .frame(width: 35, height: 35)
                                        .foregroundColor(Color.green)
                                })
                                .alert(isPresented:$toonAccepteerBevestiging){
                                    Alert(
                                        title: Text("Zeker dat je deze vakman wil aannemen?"),
                                        message: Text("Er is geen mogelijkheid meer een andere vakman te selecteren!"),
                                        primaryButton: .default(Text("Accepteer")){
                                            FirebaseManager.shared.firestore
                                                .collection("Werken")
                                                .document(buttonvm.werkButtonDetail?.fromid ?? "")
                                                .collection("WerkenOpId")
                                                .document(buttonvm.werkButtonDetail?.documentId ?? "")
                                                .updateData([
                                                    "gekozenVakman" : selectedVakman,
                                                    "goedgekeurd" : true
                                                ])
                                            buttonvm.verkrijgAlleWerkenInformation()
                                            self.presentationMode.wrappedValue.dismiss()
                                        },
                                        secondaryButton: .cancel()
                                    )
                                }
                                Spacer()
                            }
                        }
                        Spacer()
                    })
                    Divider().padding()
                    }
                }
                } else {
                    
                    ForEach(vakmanvm.vakmanenDetails) { vakman in
                        if vakman.vakmanuid == buttonvm.werkButtonDetail?.gekozenVakman {
                            HStack{
                                Text("Gekozen vakman").font(Font.custom("Ubuntu-Bold", size: 16)).padding()
                                Spacer()
                            }
                    HStack(alignment: .center, spacing: 30, content:{
                        Spacer()
                        VStack{
                            Spacer()
                            Text(vakman.naamVanonderneming)
                            Spacer()
                            Spacer()
                            Spacer()
                            if vakman.gemiddeldeVanReviews == "0.0" {
                                HStack(alignment: .firstTextBaseline, spacing: 2, content: {
                                    Image(systemName: "star")
                                    Image(systemName: "star")
                                    Image(systemName: "star")
                                    Image(systemName: "star")
                                    Image(systemName: "star")
                                })
                            } else if vakman.gemiddeldeVanReviews == "1.0" {
                                HStack(alignment: .firstTextBaseline, spacing: 2, content: {
                                    Image(systemName: "star").foregroundColor(Color.yellow)
                                    Image(systemName: "star")
                                    Image(systemName: "star")
                                    Image(systemName: "star")
                                    Image(systemName: "star")
                                })
                            } else if vakman.gemiddeldeVanReviews == "2.0" {
                                HStack(alignment: .firstTextBaseline, spacing: 2, content: {
                                    Image(systemName: "star").foregroundColor(Color.yellow)
                                    Image(systemName: "star").foregroundColor(Color.yellow)
                                    Image(systemName: "star")
                                    Image(systemName: "star")
                                    Image(systemName: "star")
                                })
                            } else if vakman.gemiddeldeVanReviews == "3.0" {
                                HStack(alignment: .firstTextBaseline, spacing: 2, content: {
                                    Image(systemName: "star").foregroundColor(Color.yellow)
                                    Image(systemName: "star").foregroundColor(Color.yellow)
                                    Image(systemName: "star").foregroundColor(Color.yellow)
                                    Image(systemName: "star")
                                    Image(systemName: "star")
                                })
                            } else if vakman.gemiddeldeVanReviews == "4.0" {
                                HStack(alignment: .firstTextBaseline, spacing: 2, content: {
                                    Image(systemName: "star").foregroundColor(Color.yellow)
                                    Image(systemName: "star").foregroundColor(Color.yellow)
                                    Image(systemName: "star").foregroundColor(Color.yellow)
                                    Image(systemName: "star").foregroundColor(Color.yellow)
                                    Image(systemName: "star")
                                })
                            } else if vakman.gemiddeldeVanReviews == "5.0" {
                                HStack(alignment: .firstTextBaseline, spacing: 2, content: {
                                    Image(systemName: "star").foregroundColor(Color.yellow)
                                    Image(systemName: "star").foregroundColor(Color.yellow)
                                    Image(systemName: "star").foregroundColor(Color.yellow)
                                    Image(systemName: "star").foregroundColor(Color.yellow)
                                    Image(systemName: "star").foregroundColor(Color.yellow)
                                })
                            }
                            Spacer()
                        }
                        VStack{
                            HStack{
                                Text("Uurprijs")
                                Text("€ \(vakman.uurprijs) per uur")
                            }
                        }
                        Spacer()
                    })
                            VStack{
                                if buttonvm.werkButtonDetail?.trackAndTrace ?? "" == "Afgerond" {
                                    Divider().padding()
                                    HStack{
                                        Text("Review").font(Font.custom("Ubuntu-Bold", size: 16)).padding()
                                        Spacer()
                                    }.padding(0)
                                    HStack{
                                        Picker("Your review", selection: $reviewScore) {
                                            ForEach(1...5, id: \.self) { number in
                                                if number == 1 {
                                                    Text("\(number) ster")
                                                } else {
                                                    Text("\(number) sterren")
                                                }
                                            }
                                        }
                                        .padding(EdgeInsets(top: -50, leading: 0, bottom: 0, trailing: 0))
                                        .pickerStyle(WheelPickerStyle())
                                        .textFieldStyle(.roundedBorder)
                                    }
                                Button() {
                                    if reviewScore != 0 {
                                    var UpdatedArray = vakman.reviews as? Array<Int> ?? []
                                    UpdatedArray.append(reviewScore)

                                    FirebaseManager.shared.firestore
                                        .collection("vakmanen")
                                        .document(vakman.vakmanuid)
                                        .updateData([
                                            "reviews" : UpdatedArray
                                        ])

                                    FirebaseManager.shared.firestore
                                        .collection("Werken")
                                        .document(buttonvm.werkButtonDetail?.fromid ?? "")
                                        .collection("WerkenOpId")
                                        .document(buttonvm.werkButtonDetail?.documentId ?? "")
                                        .delete()

                                    self.presentationMode.wrappedValue.dismiss()
                                    showingAlert = true
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                        showingAlert = false
                                    }
                                    } else {
                                        errorReview = "Gelieve het review veld in te vullen"
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                            errorReview = "Eens u een review geeft aan de vakman zal dit werk worden gearchiveerd"
                                        }
                                    }
                                } label: {
                                    VStack{
                                    HStack{
                                        Image(systemName: "checkmark")
                                            .font(.system(size: 22.0, weight: .bold))
                                            .foregroundColor(Color(red: 0.44313725490196076, green: 0.38823529411764707, blue: 1))
                                        Text("Review plaatsen")
                                    }
                                    .frame(width: 250, height: 40, alignment: .center)
                                    .overlay( RoundedRectangle(cornerRadius: 25)
                                        .stroke(Color(red: 0.44313725490196076, green: 0.38823529411764707, blue: 1), lineWidth: 2))
                                    .foregroundColor(Color.black)
                                    Text(errorReview)
                                        .font(Font.custom("Ubuntu-Regular", size: 12)).padding(5)
                                        .foregroundColor(Color.red)
                                        .padding(.bottom, 100)
                                        .frame(width: 250)
                                    }
                                }

                            }
                       }
                        }
                    }
                }
            }
        }
        .popover(isPresented: $popoverWeergeven) {
            UpdateWerkView(buttonvm: buttonvm, popoverWordWeergegeven: $popoverWeergeven, detailsWordWeergegevenUpdate: $detailsWordWeergegeven, image1: buttonvm.werkButtonDetail?.image1 ?? "", image2: buttonvm.werkButtonDetail?.image2 ?? "", image3: buttonvm.werkButtonDetail?.image3 ?? "", beschrijving: buttonvm.werkButtonDetail?.beschrijving ?? "", titel: buttonvm.werkButtonDetail?.titel ?? "", gemeente: buttonvm.werkButtonDetail?.gemeente ?? "", postcode: buttonvm.werkButtonDetail?.postcode ?? "", straatnaam: buttonvm.werkButtonDetail?.straatnaam ?? "", huisnummer: buttonvm.werkButtonDetail?.huisnummer ?? "", datum: buttonvm.werkButtonDetail?.datum ?? "", prioriteit: buttonvm.werkButtonDetail?.prioriteit ?? false, geselecteerdeProvincie: buttonvm.werkButtonDetail?.provincie ?? "", geselecteerdeSpecialisatie: buttonvm.werkButtonDetail?.specialisatie ?? "")
        }
        .alert("Review geplaatst en werk gearchiveerd", isPresented: $showingAlert) {
               }
        .alert(isPresented: $toonVerwijderBevestiging){
            Alert(
                title: Text("Zeker dat je dit werk wil verwijderen?"),
                message: Text("Er is geen mogelijkheid meer om dit ongedaan te maken!"),
                primaryButton: .default(Text("Verwijderen")){
                    buttonvm.deleteWerkInformation(fromuid: buttonvm.werkButtonDetail?.fromid ?? "", documentId: buttonvm.werkButtonDetail?.documentId ?? "")
                    toonVerwijderBevestiging = false
                    self.presentationMode.wrappedValue.dismiss()
                },
                secondaryButton: .cancel()
            )
        }

        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Terug")
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Details")
                    .font(Font.custom("BebasNeue-Regular", size: 24))
                    .frame(width: 70)
                
            }
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                if !(buttonvm.werkButtonDetail?.goedgekeurd ?? true) && buttonvm.werkButtonDetail?.vakmanArray == [] {
                Button{
                    popoverWeergeven = true
                }label: {
                    Image(systemName: "pencil.tip")
                        .resizable()
                        .frame(width: 20.0, height: 20.0)
                        .foregroundColor(Color(red: 0.44313725490196076, green: 0.38823529411764707, blue: 1.0))
                }
                } else if buttonvm.werkButtonDetail?.vakmanArray == [] && !(buttonvm.werkButtonDetail?.goedgekeurd ?? true) {
                    Button{
                        toonVerwijderBevestiging = true
                    }label: {
                        Image(systemName: "pencil.tip")
                            .resizable()
                            .frame(width: 20.0, height: 20.0)
                            .foregroundColor(Color(red: 0.44313725490196076, green: 0.38823529411764707, blue: 1.0))
                    }
            }
            }
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                
                if buttonvm.werkButtonDetail?.vakmanArray != [] && !(buttonvm.werkButtonDetail?.goedgekeurd ?? true) {
                    Button{
                        toonVerwijderBevestiging = true
                    }label: {
                        Image(systemName: "trash")
                            .resizable()
                            .frame(width: 20.0, height: 20.0)
                            .foregroundColor(Color(red: 0.44313725490196076, green: 0.38823529411764707, blue: 1.0))
                    }
                } else if buttonvm.werkButtonDetail?.vakmanArray == [] && !(buttonvm.werkButtonDetail?.goedgekeurd ?? true) {
                        Button{
                            toonVerwijderBevestiging = true
                        }label: {
                            Image(systemName: "trash")
                                .resizable()
                                .frame(width: 20.0, height: 20.0)
                                .foregroundColor(Color(red: 0.44313725490196076, green: 0.38823529411764707, blue: 1.0))
                        }
                }
            }
        }
    }
}

struct DetailsWerk_Previews: PreviewProvider {
    static var previews: some View {
        DetailsWerk(buttonvm: ButtonListViewModel(), vakmanvm: ButtonListViewModel(), detailsWordWeergegeven: .constant(true))
            .previewInterfaceOrientation(.portrait)
    }
}
