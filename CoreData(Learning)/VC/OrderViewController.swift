//
//  OrderViewController.swift
//  CoreData(Learning)
//
//  Created by Mac on 07.02.2023.
//

import UIKit
import CoreData

class OrderViewController: UIViewController {
    
    var order: Order?
    var table: NSFetchedResultsController<NSFetchRequestResult>?
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var customerTF: UITextField!
    @IBOutlet weak var switchMade: UISwitch!
    @IBOutlet weak var switchPade: UISwitch!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        //creating object
        if order == nil {
            order = Order()
            order?.date = Date()
        }
        
        if let order = order {
            datePicker.date = order.date ?? Date()
            switchMade.isOn = order.made
            switchPade.isOn = order.paid
            customerTF.text = order.customer?.name
            table = Order.getRowsOfOrder(order: order)
            table!.delegate = self
            do {
                
                try table!.performFetch()
            } catch {
                print(error)
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "orderToCustomers" {
            let vc = segue.destination as! CustomersTableViewController
            vc.didSelect = { [unowned self] customer in
                if let customer = customer {
                    self.order?.customer = customer
                    self.customerTF.text = customer.name
                }
            }
        }
    }
    
    func  saveOrder() -> Bool {
        if let order = order {
            order.date = datePicker.date
            order.made = switchMade.isOn
            order.paid = switchPade.isOn
            CoreDataManager.instance.saveContext()
            return true
        }
        return false
    }
    
    @IBAction func saveButtonAction(_ sender: Any) {
        if saveOrder() {
            dismiss(animated: true)
        }
    }
    
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func customerChoiceaction(_ sender: Any) {
        performSegue(withIdentifier: "orderToCustomers", sender: nil)
    }
    
    
}
extension OrderViewController: NSFetchedResultsControllerDelegate  {
    
}
