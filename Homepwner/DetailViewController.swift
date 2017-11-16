//
//  DetailViewController.swift
//  Homepwner
//
//  Created by TuyenVX on 11/13/17.
//  Copyright © 2017 TuyenVX. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @IBOutlet var nameField: UITextField!
    @IBOutlet var serialNumberField: UITextField!
    @IBOutlet var valueField: UITextField!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    @IBAction func takePicture(_ sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
        } else {
            imagePicker.sourceType = .photoLibrary
        }
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.cameraOverlayView = {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
            view.backgroundColor = UIColor.red
            return view
        }()
        present(imagePicker, animated: true, completion: nil)
    }
    @IBAction func removePicture(_ sender: UIBarButtonItem) {
        imageView.image = nil
        imageStore.deleteImage(forKey: item.itemKey)
        
    }
    var item: Item! {
        didSet{
            navigationItem.title = item.name
        }
    }
    var imageStore: ImageStore!
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
        
    }()
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nameField.text = item.name
        serialNumberField.text = item.serialNumber
//        valueField.text = "\(item.valueInDollars)"
//        dateLabel.text = "\(item.dateCreated)"
        valueField.text = numberFormatter.string(from: NSNumber(value: item.valueInDollars))
        dateLabel.text = dateFormatter.string(from: item.dateCreated)
        // get the item key
        let key = item.itemKey
        let imagetoDisplay = imageStore.image(forKey: key)
        imageView.image = imagetoDisplay
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        item.name = nameField.text ?? ""
    }
    //MARK:- Image piker view delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerEditedImage] as! UIImage
        imageStore.setImage(image, forKey: item.itemKey)
        imageView.image = image
        dismiss(animated: true) {
            
        }
    }
}
