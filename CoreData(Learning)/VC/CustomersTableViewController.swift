//
//  MyTableViewController.swift
//  CoreData(Learning)
//
//  Created by Mac on 05.02.2023.
//

import UIKit
import CoreData

class CustomersTableViewController: UITableViewController {
    
    typealias Select = (Customer?) -> ()
    var didSelect: Select?

    var  fetchedResultController = CoreDataManager.instance.fetchedResultController(entityName: EntityNames.customer, keyForSort: "name")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchedResultController.delegate = self
        do {
            try  fetchedResultController.performFetch()
        } catch {
            print(error)
        }

        
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchedResultController.sections {
            return sections[section].numberOfObjects
        } else {return 0}
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let customer = fetchedResultController.object(at: indexPath) as! Customer
        let cell = UITableViewCell()
        cell.textLabel?.text = customer.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let customer = fetchedResultController.object(at: indexPath) as? Customer
        if let dSelect = self.didSelect {
            dSelect(customer)
            dismiss(animated: true)
        } else {
            performSegue(withIdentifier: "customersToCustomer", sender: customer)
        }
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let managedObject = fetchedResultController.object(at: indexPath) as!  NSManagedObject
            CoreDataManager.instance.viewContext.delete(managedObject)
            CoreDataManager.instance.saveContext()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "customersToCustomer" else {return}
        let controller = segue.destination as? CustomerViewController
        controller?.customer = sender as? Customer
    }
    
    @IBAction func addCustomer(_ sender: Any) {
        performSegue(withIdentifier: "customersToCustomer", sender: nil)
    }
    

}

extension CustomersTableViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
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
                let customer = fetchedResultController.object(at: indexPath) as? Customer
                let cell = tableView.cellForRow(at: indexPath)
                cell?.textLabel!.text = customer?.name
            }
        default: break
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
}
