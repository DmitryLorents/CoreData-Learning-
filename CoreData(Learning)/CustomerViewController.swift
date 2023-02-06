//
//  CustomerViewController.swift
//  CoreData(Learning)
//
//  Created by Mac on 06.02.2023.
//

import UIKit

class CustomerViewController: UIViewController {
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var infoTF: UITextField!
    var customer: Customer?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // reading object
        if let customer = customer {
            nameTF.text = customer.name
            infoTF.text = customer.info
        }
       
    }
    
    func saveCustomer() -> Bool {
        //validation of required field
        if (nameTF.text?.isEmpty) ?? true {
            let alert = UIAlertController(title: "Validation error", message: "Input the name of customer", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            present(alert, animated: true)
            return false
        }
        //creating object
        if customer == nil {
            customer = Customer()
        }
        //saving object
        if let customer = customer {
            customer.name = nameTF.text
            customer.info = infoTF.text
            CoreDataManager.instance.saveContext()
        }
        return true
    }
    
    @IBAction func saveButtonaction(_ sender: Any) {
        if saveCustomer() {
            dismiss(animated: true)
        }
    }
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        dismiss(animated: true)
    }
    

}
