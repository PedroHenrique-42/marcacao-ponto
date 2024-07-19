//
//  Camera.swift
//  Alura Ponto
//
//  Created by Pedro Henrique on 18/07/24.
//

import UIKit

protocol CameraDelegate: NSObject {
    func didSelectFoto(_ image: UIImage)
}

class Camera: NSObject {
    weak var delegate: CameraDelegate?

    func abrirCamera(_ controller: UIViewController, imagePicker: UIImagePickerController) {
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .camera
        imagePicker.cameraDevice = UIImagePickerController.isCameraDeviceAvailable(.front) ? .front : .rear
        imagePicker.delegate = self

        controller.present(imagePicker, animated: true, completion: nil)
    }
    
    func abrirBibliotecaFotos(
        _ controller: UIViewController,
        _ imagePicker: UIImagePickerController
    ) {
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        
        controller.present(imagePicker, animated: true, completion: nil)
    }
}

extension Camera: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
    ) {
        picker.dismiss(animated: true)
        guard let foto = info[.editedImage] as? UIImage else { return }

        delegate?.didSelectFoto(foto)
    }
}
