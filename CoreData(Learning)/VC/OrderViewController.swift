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
            order!.date = Date()
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
        if segue.identifier == "orderToRowOfOrder" {
            let vc = segue.destination as! RowOfOrderViewController
            vc.rowOfOrder = sender as? RowOfOrder
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
    
    @IBAction func customerChoiceAction(_ sender: Any) {
        performSegue(withIdentifier: "orderToCustomers", sender: nil)
    }
    
    
    @IBAction func addRowAction(_ sender: Any) {
        if let order = order {
            let newRowOfOrder = RowOfOrder()
            newRowOfOrder.order = order
            performSegue(withIdentifier: "orderToRowOfOrder", sender: newRowOfOrder)
        }
    }
    
    
}
extension OrderViewController: NSFetchedResultsControllerDelegate, UITableViewDelegate, UITableViewDataSource  {
    
    //MARK: - TableView DataSoudce
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = table?.sections {
            return sections[section].numberOfObjects
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rowOfOrder = table?.object(at: indexPath) as! RowOfOrder
        let cell = UITableViewCell()
        let nameOfService = (rowOfOrder.service == nil) ? "--Unknown--" : (rowOfOrder.service?.name)
        cell.textLabel?.text = nameOfService! + " - " + String(rowOfOrder.sum)
        return cell
    }
    
    //MARK: - TableVieew Delegate
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let managedObject = table?.object(at: indexPath) as! NSManagedObject
            CoreDataManager.instance.viewContext.delete(managedObject)
            CoreDataManager.instance.saveContext()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rowOfOrder = table?.object(at: indexPath) as! RowOfOrder
        performSegue(withIdentifier: "orderToRowOfOrder", sender: rowOfOrder)
    }
    
    //MARK: - FetchedResultControlleerDelegate
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .automatic)
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        case .move:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            if let newIndexPath = newIndexPath {
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        case .update:
            if let indexPath = indexPath {
                let rowOfOrder = table?.object(at: indexPath) as! RowOfOrder
                let cell = tableView.cellForRow(at: indexPath)!
                let nameOfService = (rowOfOrder.service == nil) ? "--Unknown--" : (rowOfOrder.service?.name)
                cell.textLabel?.text = nameOfService! + " - " + String(rowOfOrder.sum)
                
            }
        default: break
        }
    }
}
