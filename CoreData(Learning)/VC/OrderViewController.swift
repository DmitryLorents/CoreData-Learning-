//
//  OrderViewController.swift
//  CoreData(Learning)
//
//  Created by Mac on 07.02.2023.
//

import UIKit

class OrderViewController: UIViewController {
    
    var order: Order?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func  saveOrder() -> Bool {
        return false
    }
    
    @IBAction func saveButtonAction(_ sender: Any) {
        if saveOrder() {
            dismiss(animated: true)
        }
    }
    

    @IBAction func cancelButtonaction(_ sender: Any) {
        dismiss(animated: true)
    }
    
}
