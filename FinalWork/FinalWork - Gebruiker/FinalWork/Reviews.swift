//
//  Reviews.swift
//  FinalWork
//
//  Created by Yannis Van Steen on 19/05/2022.
//

import SwiftUI

struct Reviews: View {
    var body: some View {
        ScrollView{
            HStack{
                Image("BrokenSink")
                    .resizable()
                    .cornerRadius(50)
                    .frame(width: 50.0, height: 50.0)
                    .padding(5)
                
                VStack(alignment: .leading, spacing: 5, content: {
                    Text("Naam van klant")
                    HStack(alignment: .firstTextBaseline, spacing: 2, content: {
                        Image(systemName: "star")
                        Image(systemName: "star")
                        Image(systemName: "star")
                        Image(systemName: "star")
                        Image(systemName: "star")
                    })
                }).padding()
                VStack{
                    HStack{
                        Text("Uurprijs")
                        Text("17.85 euro")
                    }
                    
                }
            }.padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            Divider().padding()
            HStack{
                Image("BrokenSink")
                    .resizable()
                    .cornerRadius(50)
                    .frame(width: 50.0, height: 50.0)
                    .padding(5)
                
                VStack(alignment: .leading, spacing: 5, content: {
                    Text("Naam van klant")
                    HStack(alignment: .firstTextBaseline, spacing: 2, content: {
                        Image(systemName: "star")
                        Image(systemName: "star")
                        Image(systemName: "star")
                        Image(systemName: "star")
                        Image(systemName: "star")
                    })
                }).padding()
                VStack{
                    HStack{
                        Text("Uurprijs")
                        Text("17.85 euro")
                    }
                    
                }
            }.padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
        }
    }
}

struct Reviews_Previews: PreviewProvider {
    static var previews: some View {
        Reviews()
    }
}
