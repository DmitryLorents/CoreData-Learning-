//
//  ServiceViewController.swift
//  CoreData(Learning)
//
//  Created by Mac on 06.02.2023.
//

import UIKit

class ServiceViewController: UIViewController {
    
    var service: Services?
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var infoTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let service = service {
            nameTF.text = service.name
            infoTF.text = service.info
        }
        
    }
    
    func saveService() -> Bool {
        
        if nameTF.text?.isEmpty ?? true {
            let alert = UIAlertController(title: "Validation error", message: "Please enter name of service", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            present(alert, animated: true)
            return false
        }
        
        if service == nil {
            service = Services()
            service?.name = nameTF.text
            service?.info = infoTF.text
            CoreDataManager.instance.saveContext()
        }
        return true
    }
    
    @IBAction func saveButtonAction(_ sender: Any) {
        if saveService() {
        dismiss(animated: true)
        }
    }
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
}
