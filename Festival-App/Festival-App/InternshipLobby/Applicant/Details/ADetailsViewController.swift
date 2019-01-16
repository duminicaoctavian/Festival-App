//
//  ADetailsViewController.swift
//  Festival-App
//
//  Created by Octavian Duminica on 16/01/2019.
//  Copyright © 2019 Duminica Octavian. All rights reserved.
//

import UIKit
import MobileCoreServices

class ADetailsViewController: UIViewController {
    
    @IBOutlet weak var workTextView: UITextView!
    @IBOutlet weak var detailsImageView: UIImageView!
    
    @IBOutlet weak var offerTitle: UILabel!
    @IBOutlet weak var offerDescriptionTextView: UITextView!
    
    lazy var visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return blurEffectView
    }()
    
    lazy var presenter: ADetailsPresenter = {
        return ADetailsPresenter(view: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        presenter.loadOffer()
    }
    
    @IBAction func onUploadResumeTapped(_ sender: Any) {
        presenter.uploadResume()
    }
    
    @IBAction func onCallTapped(_ sender: Any) {
        presenter.call()
        
    }
    
    @IBAction func onApplyTapped(_ sender: Any) {
        presenter.setApplication(projects: workTextView.text, phone: "0745047302")
        presenter.apply()
    }
}

extension ADetailsViewController: ADetailsView {
    func displayAlert(title: String, message: String) {
        alert(title: title, message: message)
    }
    
    func callNumber(_ text: String) {
        if let URL = URL(string: "tel://\(text)") {
            UIApplication.shared.open(URL, options: [:], completionHandler: nil)
        }
    }
    
    func openFilePicker() {
        let types: [String] = [kUTTypePDF as String]
        let documentPicker = UIDocumentPickerViewController(documentTypes: types, in: .import)
        documentPicker.delegate = self
        documentPicker.modalPresentationStyle = .formSheet
        present(documentPicker, animated: true, completion: nil)
    }
    
    func displayCompanyImage(_ URLString: String) {
        detailsImageView.loadImageUsingCache(withURLString: URLString)
    }
    
    func displayOfferTitle(_ text: String) {
        offerTitle.text = text
    }
    
    func displayOfferDescription(_ text: String) {
        offerDescriptionTextView.text = text
    }
    
    func startActivityIndicator() {
        view.addSubview(visualEffectView)
        LoadingView.startLoading()
    }
    
    func stopActivityIndicator() {
        visualEffectView.removeFromSuperview()
        LoadingView.stopLoading()
    }
}

extension ADetailsViewController: UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        do {
            let data = try Data(contentsOf: urls.first!)
            print(data)
            presenter.setResumeData(data)
        } catch {
            print(error)
        }
        
    }
}
