//
//  ViewController.swift
//  ImagePicker
//
//  Created by R93 on 01/01/24.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    // MARK: - IBOutlets
    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var profilePicture: UIButton!
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - Initializeview
    private func setup() {
        [profilePicture, profilePicture].forEach {
            setCornerRadious(view: $0, cornerRadious: 10)
        }
    }
    
    func setCornerRadious(view: UIView?, cornerRadious: CGFloat) {
        view?.layer.cornerRadius = cornerRadious
        view?.layer.masksToBounds = true
    }
    private func displayActionSheet() {
        
        let alert: UIAlertController = UIAlertController(title: "Profile Picture", message: "Please select photo from following options", preferredStyle: .alert)
        let cameraButton: UIAlertAction = UIAlertAction(title: "Camera", style: .default) { button in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                //self.openCamera()
                self.openImagePicker(sourceType: .camera)
            } else {
                self.displayAlert(message: "Camera is not available")
            }
            
        }
        let galleryButton: UIAlertAction = UIAlertAction(title: "Photos", style: .default) { button in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                //self.openPhotos()
                self.openImagePicker(sourceType: .photoLibrary)
            } else {
                
                self.displayAlert(message: "gallery is not available")
            }
            
        }
       
        let cancelButton: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cameraButton)
        alert.addAction(galleryButton)
        alert.addAction(cancelButton)
        present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func profilePictureButtonTapped(_ sender: UIButton) {
        displayActionSheet()
    }
    
    private func openPhotos() {
        let imagePicker: UIImagePickerController = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    
    private func openCamera() {
        let imagePicker: UIImagePickerController = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    private func openImagePicker(sourceType: UIImagePickerController.SourceType) {
        let imagePicker: UIImagePickerController = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true, completion: nil)
        //profilePictureImageView.image = info[.originalImage] as? UIImage
        profilePictureImageView.image = info[.editedImage] as? UIImage
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
        print("Cancel button clicked")
    }
    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//
//    }
//
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//
//    }
    private func displayAlert(message: String) {
        
        let alert: UIAlertController = UIAlertController(title: "Error", message: message, preferredStyle: .actionSheet)
        let okButton: UIAlertAction = UIAlertAction(title: "Okay", style: .default) { button in
            print("OKay button tapped")
        }
        
        alert.addAction(okButton)
        
        present(alert, animated: true, completion: nil)
        
    }
}

