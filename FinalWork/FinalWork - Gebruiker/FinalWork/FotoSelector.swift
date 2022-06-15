//
//  FotoSelector.swift
//  FinalWork
//
//  Created by Yannis Van Steen on 24/05/2022.
//

import SwiftUI


struct FotoSelector: UIViewControllerRepresentable {
   
    @Binding var werkImage: UIImage
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let selector = UIImagePickerController()
        selector.delegate = context.coordinator
        selector.allowsEditing = true
        return selector
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(fotoSelector: self)
    }
    
    final class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        
        let fotoSelector: FotoSelector
        
        init(fotoSelector: FotoSelector){
            self.fotoSelector = fotoSelector
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.editedImage] as? UIImage {
                fotoSelector.werkImage = image
            } else {
                // return an error
            }
            picker.dismiss(animated: true)
        }
    }
}
