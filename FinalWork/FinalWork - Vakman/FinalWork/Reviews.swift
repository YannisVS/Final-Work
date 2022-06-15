//
//  Reviews.swift
//  FinalWork
//
//  Created by Yannis Van Steen on 19/05/2022.
//

import SwiftUI

struct Reviews: View {
    
    @ObservedObject private var vm = MainViewModel()
    
    var body: some View {
        ScrollView{
            ForEach(vm.vakman?.reviewArray as! [Int], id: \.self) { review in
                if review == 0{
                    HStack{
                        VStack(alignment: .leading, spacing: 5, content: {
                            HStack(alignment: .firstTextBaseline, spacing: 2, content: {
                                Image(systemName: "star")
                                Image(systemName: "star")
                                Image(systemName: "star")
                                Image(systemName: "star")
                                Image(systemName: "star")
                            })
                        }).padding()
                    }.padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                } else if review == 1{
                    HStack{
                        VStack(alignment: .leading, spacing: 5, content: {
                            HStack(alignment: .firstTextBaseline, spacing: 2, content: {
                                Image(systemName: "star").foregroundColor(Color.yellow)
                                Image(systemName: "star")
                                Image(systemName: "star")
                                Image(systemName: "star")
                                Image(systemName: "star")
                            })
                        }).padding()
                    }.padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                } else if review == 2 {
                    HStack{
                        VStack(alignment: .leading, spacing: 5, content: {
                            HStack(alignment: .firstTextBaseline, spacing: 2, content: {
                                Image(systemName: "star").foregroundColor(Color.yellow)
                                Image(systemName: "star").foregroundColor(Color.yellow)
                                Image(systemName: "star")
                                Image(systemName: "star")
                                Image(systemName: "star")
                            })
                        }).padding()
                    }.padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                } else if review == 3 {
                    HStack{
                        VStack(alignment: .leading, spacing: 5, content: {
                            HStack(alignment: .firstTextBaseline, spacing: 2, content: {
                                Image(systemName: "star").foregroundColor(Color.yellow)
                                Image(systemName: "star").foregroundColor(Color.yellow)
                                Image(systemName: "star").foregroundColor(Color.yellow)
                                Image(systemName: "star")
                                Image(systemName: "star")
                            })
                        }).padding()
                    }.padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                } else if review == 4 {
                    HStack{
                        VStack(alignment: .leading, spacing: 5, content: {
                            HStack(alignment: .firstTextBaseline, spacing: 2, content: {
                                Image(systemName: "star").foregroundColor(Color.yellow)
                                Image(systemName: "star").foregroundColor(Color.yellow)
                                Image(systemName: "star").foregroundColor(Color.yellow)
                                Image(systemName: "star").foregroundColor(Color.yellow)
                                Image(systemName: "star")
                            })
                        }).padding()
                    }.padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                } else if review == 5 {
                    HStack{
                        VStack(alignment: .leading, spacing: 5, content: {
                            HStack(alignment: .firstTextBaseline, spacing: 2, content: {
                                Image(systemName: "star").foregroundColor(Color.yellow)
                                Image(systemName: "star").foregroundColor(Color.yellow)
                                Image(systemName: "star").foregroundColor(Color.yellow)
                                Image(systemName: "star").foregroundColor(Color.yellow)
                                Image(systemName: "star").foregroundColor(Color.yellow)
                            })
                        }).padding()
                    }.padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                }
                Divider().padding()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Terug")
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Text("Reviews").font(Font.custom("BebasNeue-Regular", size: 24))
                    }
                }
            }.padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0)).background(Color(.systemGray6))
    }
}

struct Reviews_Previews: PreviewProvider {
    static var previews: some View {
        Reviews()
    }
}
