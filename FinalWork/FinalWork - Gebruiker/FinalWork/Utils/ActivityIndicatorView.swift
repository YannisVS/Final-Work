//
//  ActivityIndicatorView.swift
//  FinalWork
//
//  Created by Yannis Van Steen on 10/06/2022.
//
import Foundation
import SwiftUI

struct ActivityIndicator: UIViewRepresentable {
   typealias UIViewType = UIActivityIndicatorView
    let style: UIActivityIndicatorView.Style
    
    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> ActivityIndicator.UIViewType {
        return UIActivityIndicatorView(style: style)
    }
    func updateUIView(_ uiView: ActivityIndicator.UIViewType, context: UIViewRepresentableContext<ActivityIndicator>) {
        uiView.startAnimating()
    }
}

struct ActivityIndicatorView<Content> : View where Content : View {
    
    @Binding var isDisplayed: Bool
    var content: () -> Content
    
    var body : some View {
        GeometryReader { geometry in
            ZStack(alignment: .center, content: {
                if !self.isDisplayed {
                    self.content()
                } else {
                    self.content()
                        .disabled(true)
                        .blur(radius: 3)
                    
                    VStack{
                        Text("Werk word toegevoegd")
                            .font(Font.custom("Ubuntu-Bold", size: 16)).padding(5)
                        ActivityIndicator(style: .large)
                    }
                    .frame(width: 150, height: 150)
                    .background(Color(UIColor.systemGray6))
                    .foregroundColor(Color.primary)
                    .cornerRadius(20)
                }
            })
            
        }
    }
    
}
