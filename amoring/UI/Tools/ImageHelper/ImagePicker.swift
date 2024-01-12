//
//  ImagePicker.swift
//  amoring
//
//  Created by 이준녕 on 11/21/23.
//

import PhotosUI
import SwiftUI
import UniformTypeIdentifiers

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var pictures: [PictureModel]
    var photoIndex: Int? = nil
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
//        config.selectionLimit = limit
        config.selectionLimit = 1
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {

    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            results.forEach { result in
                let provider = result.itemProvider
                
                if provider.canLoadObject(ofClass: UIImage.self) {
                    provider.loadObject(ofClass: UIImage.self) { image, _ in
                        provider.loadFileRepresentation(forTypeIdentifier: UTType.image.identifier) { (url, error) in
                            if let img = image as? UIImage, let url {
                                if let index = self.parent.photoIndex {
                                    self.parent.pictures[index] = PictureModel.newPicture(img, url.absoluteString)
                                } else {
                                    self.parent.pictures.append(PictureModel.newPicture(img, url.absoluteString))
                                }
                            }
//                            print("URL: \(url)")
                        }
                    }
                }
            }
            
            picker.dismiss(animated: true)
        }
    }
}



//struct ImagePicker: UIViewControllerRepresentable {
//    @Environment(\.presentationMode) private var presentationMode
//    var sourceType: UIImagePickerController.SourceType = .photoLibrary
//    @Binding var pictures: [PictureModel]
//    var photoIndex: Int? = nil
//
//    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
//        let imagePicker = UIImagePickerController()
//        imagePicker.allowsEditing = false
//        imagePicker.sourceType = sourceType
//        imagePicker.delegate = context.coordinator
//        
//        return imagePicker
//    }
//
//    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
//
//    }
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//
//    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//
//        var parent: ImagePicker
//
//        init(_ parent: ImagePicker) {
//            self.parent = parent
//        }
//
//        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//            if let img = info[UIImagePickerController.InfoKey.originalImage] as? UIImage, let imageURL = info[UIImagePickerController.InfoKey.referenceURL] as? NSURL {
//                let urlString = imageURL.absoluteString!
//                print(urlString)
//                
//                if let index = self.parent.photoIndex {
//                    self.parent.pictures[index] = PictureModel.newPicture(img, urlString)
//                } else {
//                    self.parent.pictures.append(PictureModel.newPicture(img, urlString))
//                }
//            }
//            
//            parent.presentationMode.wrappedValue.dismiss()
//        }
//    }
//}
