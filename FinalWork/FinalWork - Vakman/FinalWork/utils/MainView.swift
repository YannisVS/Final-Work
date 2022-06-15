//
//  MainView.swift
//  FinalWork
//
//  Created by Yannis Van Steen on 12/05/2022.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var viewRouter: ViewRouter
    
    var body: some View {
        switch viewRouter.currentPage {
        case .home:
            Home(viewRouter: viewRouter)
        case .aanmelden:
            Aanmelden(viewRouter: viewRouter)
        case .registreer:
            Registreer(viewRouter: viewRouter)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(viewRouter: ViewRouter())
    }
}
