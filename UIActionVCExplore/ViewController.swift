//
//  ViewController.swift
//  UIActionVCExplore
//
//  Created by Afir Thes on 13.01.2023.
//

import UIKit

class ViewController: UIViewController {
    
    let image = UIImage(named: "photo")!
    var imageToShare: UIImageView!
    var shareImageButton: UIButton!
    var textField: UITextField!
    var shareTextButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        
        configureImageView()
        configureShareImageButton()
        configureTextField()
        configureButton()
    }
    
    func configureImageView() {
        imageToShare = UIImageView()
        imageToShare.image = image
        imageToShare.contentMode = .scaleAspectFit
        
        view.addSubview(imageToShare)
        
        imageToShare.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageToShare.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageToShare.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageToShare.widthAnchor.constraint(equalToConstant: 300),
            imageToShare.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    func configureShareImageButton() {
        shareImageButton = UIButton()
        shareImageButton.setTitle("Share image", for: .normal)
        shareImageButton.setTitleColor(.systemBlue, for: .normal)
        
        view.addSubview(shareImageButton)
        
        shareImageButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            shareImageButton.topAnchor.constraint(equalTo: imageToShare.bottomAnchor, constant: 12),
            shareImageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        shareImageButton.addTarget(self, action: #selector(shareImageAction), for: .touchUpInside)
    }
    
    func configureTextField() {
        textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Text to share"
        textField.font = UIFont(name: "Avenir", size: 22)
        textField.clearButtonMode = .whileEditing
        
        view.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: shareImageButton.bottomAnchor, constant: 24),
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    func configureButton() {
        shareTextButton = UIButton()
        shareTextButton.setTitle("Share text", for: .normal)
        shareTextButton.setTitleColor(.systemBlue, for: .normal)
        
        view.addSubview(shareTextButton)
        
        shareTextButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            shareTextButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 12),
            shareTextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        shareTextButton.addTarget(self, action: #selector(shareTextAction), for: .touchUpInside)
    }

    @objc func shareImageAction() {
        let ac = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        present(ac, animated: true)
    }
    
    @objc func shareTextAction() {
        guard let text = textField.text, !text.isEmpty else {
            showAlert(with: "Text field is empty.", and: "Please enter some text to share.")
            return
        }
        let ac = UIActivityViewController(activityItems: [self], applicationActivities: nil)
        present(ac, animated: true)
    }
    
    func showAlert(with title: String, and message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertCancel = UIAlertAction(title: "Ok", style: .cancel)
        alertVC.addAction(alertCancel)
        present(alertVC, animated: true)
    }
    

}

//Mark: - UIActivityItemSource
extension ViewController: UIActivityItemSource {
    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return textField.text ?? "<empty>"
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
        return textField.text ?? "<empty>"
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, subjectForActivityType activityType: UIActivity.ActivityType?) -> String {
        return "Shared message topic (for email)"
    }
}

