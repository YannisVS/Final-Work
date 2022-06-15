//
//  Artiekel.swift
//  FinalWork
//
//  Created by Yannis Van Steen on 16/05/2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailsWerk: View {
    
    @ObservedObject var buttonvm : ButtonListViewModel
    
    @State private var toonAccepteerBevestiging = false
    @State private var toonWeigerBevestiging = false
    @State private var imageArray : Array<String> = [""]
    @State private var documentId : String = ""
    @State private var fromid : String = ""
    @State private var changingTrackAndTrace : String = ""
    @State private var FirstTimeChange : Bool = false
    @State private var FirstTimeOffer : Bool = true
    @State private var unUpdatedArray : Array<String> = [""]
    @State private var errorUpdate : String = " "
    @State private var showingAlert : Bool = false
    
    init(recievedButtonview: ButtonListViewModel){
        buttonvm = recievedButtonview
    }
    
    let fromuid = FirebaseManager.shared.auth.currentUser?.uid
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
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
                    } .frame(width: 400,height: 250)
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
               
                if !(buttonvm.werkButtonDetail?.vakmanArray ?? []).contains(fromuid ?? ""){
                VStack{
                    Spacer()
                    HStack{
                        Text("Voorstel").font(Font.custom("Ubuntu-Bold", size: 16)).padding()
                    }
                    Text(errorUpdate)
                        .font(Font.custom("Ubuntu-Regular", size: 12))
                        .foregroundColor(Color.red)
                        .padding(EdgeInsets(top: -10, leading: 0, bottom: 10, trailing: 0))
                    Button() {
                        unUpdatedArray = buttonvm.werkButtonDetail?.vakmanArray as! Array<String>
                        guard let fromuid = FirebaseManager.shared.auth.currentUser?.uid else { return }
                        unUpdatedArray.forEach {
                            if $0 == fromuid {
                                FirstTimeOffer = false
                            }
                        }
                        
                        if FirstTimeOffer == true {
                        unUpdatedArray.append(fromuid)
                        
                        FirebaseManager.shared.firestore
                            .collection("Werken")
                            .document(buttonvm.werkButtonDetail?.fromid ?? "")
                            .collection("WerkenOpId")
                            .document(buttonvm.werkButtonDetail?.documentId ?? "")
                            .updateData([
                                "vakmanArray" : unUpdatedArray
                            ])
                        }
                        self.presentationMode.wrappedValue.dismiss()
                        showingAlert = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            showingAlert = false
                        }
                    } label: {
                        HStack{
                            Image(systemName: "checkmark")
                                .font(.system(size: 22.0, weight: .bold))
                                .foregroundColor(Color(red: 0.44313725490196076, green: 0.38823529411764707, blue: 1))
                            Text("Voorstel plaatsen")
                        }
                        .frame(width: 250, height: 40, alignment: .center)
                        .overlay( RoundedRectangle(cornerRadius: 25)
                            .stroke(Color(red: 0.44313725490196076, green: 0.38823529411764707, blue: 1), lineWidth: 2))
                        .foregroundColor(Color.black)
                    }
                    Spacer()
                }.padding(EdgeInsets(top: 0, leading: 0, bottom: 25, trailing: 0))
                }
                //------------ Track And Trace ---------------
                if (buttonvm.werkButtonDetail?.goedgekeurd ?? false){
                                VStack(alignment: .leading, spacing: 0, content: {
                                    HStack{
                                        Text("Track & Trace").font(Font.custom("Ubuntu-Bold", size: 16)).padding()
                                        Spacer()
                                    }
                                    HStack(alignment: .center, spacing: 0, content: {
                                        Spacer()
                                        VStack{
                                            Button() {
                                                FirstTimeChange = true
                                                changingTrackAndTrace = "In Voorbereiding"
                                                FirebaseManager.shared.firestore
                                                    .collection("Werken")
                                                    .document(buttonvm.werkButtonDetail?.fromid ?? "")
                                                    .collection("WerkenOpId")
                                                    .document(buttonvm.werkButtonDetail?.documentId ?? "")
                                                    .updateData([
                                                        "trackAndTrace" : "In Voorbereiding"
                                                    ])
                                            } label: {
                                                if changingTrackAndTrace == "In Voorbereiding" || buttonvm.werkButtonDetail?.trackAndTrace ?? "" == "In Voorbereiding" && FirstTimeChange == false {
                                                    Text("In Voorbereiding")
                                                        .frame(width: 350, height: 40, alignment: .center)
                                                        .background(Color(red: 0.44313725490196076, green: 0.38823529411764707, blue: 1))
                                                        .overlay( RoundedRectangle(cornerRadius: 25)
                                                        .stroke(Color(red: 0.44313725490196076, green: 0.38823529411764707, blue: 1), lineWidth: 2))
                                                        .foregroundColor(Color.white)
                                                        .cornerRadius(25)
                                                } else if changingTrackAndTrace == "In Voorbereiding" {
                                                    Text("In Voorbereiding")
                                                        .frame(width: 350, height: 40, alignment: .center)
                                                        .background(Color(red: 0.44313725490196076, green: 0.38823529411764707, blue: 1))
                                                        .overlay( RoundedRectangle(cornerRadius: 25)
                                                        .stroke(Color(red: 0.44313725490196076, green: 0.38823529411764707, blue: 1), lineWidth: 2))
                                                        .foregroundColor(Color.white)
                                                        .cornerRadius(25)
                                                }
                                                else {
                                                    Text("In Voorbereiding")
                                                        .frame(width: 350, height: 40, alignment: .center)
                                                        .overlay( RoundedRectangle(cornerRadius: 25)
                                                            .stroke(Color(red: 0.44313725490196076, green: 0.38823529411764707, blue: 1), lineWidth: 2))
                                                        .foregroundColor(Color.black)
                                                }
                
                                            }
                                            .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                                            Button() {
                                                FirstTimeChange = true
                                                changingTrackAndTrace = "Onderweg"
                                                FirebaseManager.shared.firestore
                                                    .collection("Werken")
                                                    .document(buttonvm.werkButtonDetail?.fromid ?? "")
                                                    .collection("WerkenOpId")
                                                    .document(buttonvm.werkButtonDetail?.documentId ?? "")
                                                    .updateData([
                                                        "trackAndTrace" : "Onderweg"
                                                    ])
                                            } label: {
                                                if changingTrackAndTrace == "Onderweg" || buttonvm.werkButtonDetail?.trackAndTrace ?? "" == "Onderweg" && FirstTimeChange == false {
                                                    Text("Onderweg")
                                                        .frame(width: 350, height: 40, alignment: .center)
                                                        .background(Color(red: 0.44313725490196076, green: 0.38823529411764707, blue: 1))
                                                        .overlay( RoundedRectangle(cornerRadius: 25)
                                                        .stroke(Color(red: 0.44313725490196076, green: 0.38823529411764707, blue: 1), lineWidth: 2))
                                                        .foregroundColor(Color.white)
                                                        .cornerRadius(25)
                                                } else if changingTrackAndTrace == "Onderweg" {
                                                    Text("Onderweg")
                                                        .frame(width: 350, height: 40, alignment: .center)
                                                        .background(Color(red: 0.44313725490196076, green: 0.38823529411764707, blue: 1))
                                                        .overlay( RoundedRectangle(cornerRadius: 25)
                                                        .stroke(Color(red: 0.44313725490196076, green: 0.38823529411764707, blue: 1), lineWidth: 2))
                                                        .foregroundColor(Color.white)
                                                        .cornerRadius(25)
                                                } else {
                                                    Text("Onderweg")
                                                        .frame(width: 350, height: 40, alignment: .center)
                                                        .overlay( RoundedRectangle(cornerRadius: 25)
                                                            .stroke(Color(red: 0.44313725490196076, green: 0.38823529411764707, blue: 1), lineWidth: 2))
                                                        .foregroundColor(Color.black)
                                                }
                                            }
                                            .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                                            Button() {
                                                changingTrackAndTrace = "Afgerond"
                                                FirstTimeChange = true
                                                FirebaseManager.shared.firestore
                                                    .collection("Werken")
                                                    .document(buttonvm.werkButtonDetail?.fromid ?? "")
                                                    .collection("WerkenOpId")
                                                    .document(buttonvm.werkButtonDetail?.documentId ?? "")
                                                    .updateData([
                                                        "trackAndTrace" : "Afgerond"
                                                    ])
                                            } label: {
                                                if changingTrackAndTrace == "Afgerond" || buttonvm.werkButtonDetail?.trackAndTrace ?? "" == "Afgerond" && FirstTimeChange == false{
                                                    Text("Afgerond")
                                                        .frame(width: 350, height: 40, alignment: .center)
                                                        .background(Color(red: 0.44313725490196076, green: 0.38823529411764707, blue: 1))
                                                        .overlay( RoundedRectangle(cornerRadius: 25)
                                                        .stroke(Color(red: 0.44313725490196076, green: 0.38823529411764707, blue: 1), lineWidth: 2))
                                                        .foregroundColor(Color.white)
                                                        .cornerRadius(25)
                                                } else if changingTrackAndTrace == "Afgerond" {
                                                    Text("Afgerond")
                                                        .frame(width: 350, height: 40, alignment: .center)
                                                        .background(Color(red: 0.44313725490196076, green: 0.38823529411764707, blue: 1))
                                                        .overlay( RoundedRectangle(cornerRadius: 25)
                                                        .stroke(Color(red: 0.44313725490196076, green: 0.38823529411764707, blue: 1), lineWidth: 2))
                                                        .foregroundColor(Color.white)
                                                        .cornerRadius(25)
                                                }else {
                                                    Text("Afgerond")
                                                        .frame(width: 350, height: 40, alignment: .center)
                                                        .overlay( RoundedRectangle(cornerRadius: 25)
                                                            .stroke(Color(red: 0.44313725490196076, green: 0.38823529411764707, blue: 1), lineWidth: 2))
                                                        .foregroundColor(Color.black)
                                                }
                                                
                                            }
                                            .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                                        }
                                        Spacer()
                                    })
                                }).padding()
                }
                
                //------------ Track And Trace ---------------
            }
        }
        .alert("Voorstel geplaatst", isPresented: $showingAlert) {
               }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Terug")
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack {
                    Text("Details").font(Font.custom("BebasNeue-Regular", size: 24))
                }
            }
        }
    }
}

struct DetailsWerk_Previews: PreviewProvider {
    static var previews: some View {
        DetailsWerk(recievedButtonview: ButtonListViewModel())
            .previewInterfaceOrientation(.portrait)
    }
}
