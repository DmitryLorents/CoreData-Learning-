//
//  RowOfOrderViewController.swift
//  CoreData(Learning)
//
//  Created by Mac on 08.02.2023.
//

import UIKit

class RowOfOrderViewController: UIViewController {

    @IBOutlet weak var serviceTF: UITextField!
    @IBOutlet weak var sumTF: UITextField!
    
    var rowOfOrder: RowOfOrder?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let rowOfOrder = rowOfOrder {
            serviceTF.text = rowOfOrder.service?.name
            sumTF.text = String(rowOfOrder.sum)
        } else {
            rowOfOrder = RowOfOrder()
        }

        
    }
    
    func saveRow() {
        if let rowOfOrder = rowOfOrder {
            sumTF.text = String(rowOfOrder.sum)
            CoreDataManager.instance.saveContext()
        }
    }
    
    @IBAction func saveButtonAction(_ sender: Any) {
        saveRow()
        dismiss(animated: true)
    }
    
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func getServiceAction(_ sender: Any) {
    }
}
