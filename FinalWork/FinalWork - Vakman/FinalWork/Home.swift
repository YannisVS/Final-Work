//
//  Home.swift
//  FinalWork
//
//  Created by Yannis Van Steen on 10/05/2022.
//

import SwiftUI
struct Vakman {
    let uid, email, specialisatie, provincie, uurprijs, naamVanOnderneming, ondernemingsNummer: String
    let reviewArray: Array<Any>
}

class MainViewModel: ObservableObject {
    
    @Published var errorMessage = ""
    @Published var vakman: Vakman?
    
    
    init() {
        fetchCurrentVakman()
    }
    
    private func fetchCurrentVakman() {
        
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            self.errorMessage = "Could not find firebase uid"
            return }
        
        FirebaseManager.shared.firestore.collection("vakmanen").document(uid).getDocument { snapshot, error in
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
            let specialisatie = data["specialisatie"] as? String ?? ""
            let provincie = data["provincie"] as? String ?? ""
            let uurprijs = data["uurprijs"] as? String ?? ""
            let naamVanOnderneming = data["naamVanOnderneming"] as? String ?? ""
            let ondernemingsNummer = data["ondernemingsNummer"] as? String ?? ""
            let reviewArray = data["reviews"] as? Array ?? []
            
            self.vakman = Vakman(uid: uid, email: email, specialisatie: specialisatie, provincie: provincie, uurprijs: uurprijs, naamVanOnderneming: naamVanOnderneming, ondernemingsNummer: ondernemingsNummer, reviewArray: reviewArray)
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

extension Date {
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: self)!
    }

    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: self)!
    }
}

struct Home: View {
    
    @StateObject var viewRouter: ViewRouter
    
    
    
    var body: some View {
        TabView{
            AlleWerken( Selectedbuttonvm: ButtonListViewModel(), selectedData: WerkButton(documentId: "", data: [:]), filterByProvincie: .none, filterBySpecialisatie: .none, filterByDate: .none ).tabItem{(Image(systemName: "house"))}
            MijnWerken(selectedButtonvm:  ButtonListViewModel(), selectedData: WerkButton(documentId: "", data: [:])).tabItem{(Image(systemName: "wrench.and.screwdriver"))}
            Account(viewRouter: viewRouter).tabItem{(Image(systemName: "person.crop.circle"))}
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
