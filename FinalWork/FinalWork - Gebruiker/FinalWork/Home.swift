//
//  Home.swift
//  FinalWork
//
//  Created by Yannis Van Steen on 10/05/2022.
//

import SwiftUI
import FirebaseAuth

struct User {
    let uid, email: String
}

class MainViewModel: ObservableObject {
    
    @Published var errorMessage = ""
    @Published var user: User?
    
    
    init() {
        fetchCurrentUser()
    }
    
    private func fetchCurrentUser() {
        
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            self.errorMessage = "Could not find firebase uid"
            return }
        
        FirebaseManager.shared.firestore.collection("klanten").document(uid).getDocument { snapshot, error in
            if let error = error {
                self.errorMessage = "Failed to fetch current user: \(error)"
                return
            }
            
            guard let data = snapshot?.data() else {
                self.errorMessage = "No data found"
                return
            }
            
            let uid = data["uid"] as? String ?? ""
            let email = data["email"] as? String ?? ""
            self.user = User(uid: uid, email: email)
        }
    }
    
    func handleSignOut() {
        try? FirebaseManager.shared.auth.signOut()
    }
    
    func handleDeleteUser() {
        try? FirebaseManager.shared.auth.currentUser?.delete()
    }
}

struct RoundedCorner: Shape {
    
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some                 View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct Home: View {
    
    @StateObject var viewRouter: ViewRouter
    
    var body: some View {
        TabView{
            MijnWerken( selectedButtonvm: ButtonListViewModel(), selectedVakmanvm: ButtonListViewModel(), selectedData: WerkButton(documentId: "", data: [:])).tabItem{(Image(systemName: "wrench.and.screwdriver"))}
            Account(viewRouter: viewRouter, userLoggedIn: true).tabItem{(Image(systemName: "person.crop.circle"))}
        }.onAppear(perform: {
            UITabBar.appearance().backgroundColor = UIColor(white: 1, alpha: 0.98)
        
})
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home(viewRouter: ViewRouter())
    }
}
