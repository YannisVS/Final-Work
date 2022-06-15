//
//  MyWorks.swift
//  FinalWork
//
//  Created by Yannis Van Steen on 12/05/2022.
//

import SwiftUI
import SDWebImageSwiftUI



struct MijnWerken: View {
    
    @State var isIndividueelWerkIngedrukt = false
    @State private var popoverWeergeven: Bool = false
    @State var isGoedgekeurdWeergegeven = true
    
    @ObservedObject private var buttonvm = ButtonListViewModel()
    @State @ObservedObject var selectedButtonvm : ButtonListViewModel
    
    @ObservedObject private var vm = MainViewModel()
    
    @State var selectedData: WerkButton
    
    let fromuid = FirebaseManager.shared.auth.currentUser?.uid
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationView{
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
                                    if werk.goedgekeurd && werk.gekozenVakman == fromuid {
                                        Button {
                                            selectedButtonvm = ButtonListViewModel(ReviecedDocumentId: werk.documentId, RecievedFromid: werk.fromid)
                                            selectedData = werk
                                            isIndividueelWerkIngedrukt=true
                                            
                                        } label: {
                                            VStack(alignment: .leading){
                                                    WebImage(url: URL(string: werk.image1))
                                                        .resizable()
                                                        .frame(width: 175.0, height: 175.0)
                                                        .scaledToFit()
                                                        .cornerRadius(16, corners: [.topLeft,.topRight])
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
                            else {
                                ForEach(buttonvm.werkButtons) { werk in
                                    if !werk.goedgekeurd && werk.vakmanArray.contains(fromuid ?? "") {
                                        Button {
                                            selectedButtonvm = ButtonListViewModel(ReviecedDocumentId: werk.documentId, RecievedFromid: werk.fromid)
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
                                        
                                    }
                                }
                            }
                            
                        }
                        .background(
                            NavigationLink(destination: DetailsWerk(recievedButtonview: selectedButtonvm),
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
                        Text("Mijn Werken").font(Font.custom("BebasNeue-Regular", size: 24))
                        Spacer()
                        Spacer()
                        Spacer()
                    }
                }
            }.padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
        }
    }    
}

struct MijnWerken_Previews: PreviewProvider {
    static var previews: some View {
        MijnWerken(selectedButtonvm: ButtonListViewModel(), selectedData: WerkButton(documentId: "", data: [:]))
    }
}
