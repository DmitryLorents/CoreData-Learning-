//
//  OrdersTableViewController.swift
//  CoreData(Learning)
//
//  Created by Mac on 07.02.2023.
//

import UIKit
import CoreData

class OrdersTableViewController: UITableViewController {
    
    var fetcheedReesultController = CoreDataManager.instance.fetchedResultController(entityName: .order, keyForSort: "date")
    var order: Order?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetcheedReesultController.delegate = self
        do {
            try fetcheedReesultController.performFetch()
        } catch {
            print(error)
        }
        
        
    }
    
    
    @IBAction func addOrderAction(_ sender: Any) {
        performSegue(withIdentifier: "OrdersToOrder", sender: nil)
    }
    
    // MARK: - Table view data source
    
    //    override func numberOfSections(in tableView: UITableView) -> Int {
    //        // #warning Incomplete implementation, return the number of sections
    //        return 0
    //    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetcheedReesultController.sections {
            return sections[section].numberOfObjects
        } else {
            return 0
        }
    }
    
   
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = UITableViewCell()
         let order = fetcheedReesultController.object(at: indexPath) as! Order
         
     
     
     return cell
     }
    
    func configCell(cell: UITableViewCell, order: Order) {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        let nameOfCustomer = (order.customer == nil) ?  "--Unknown--" : (order.customer?.name)
        cell.textLabel?.text = formatter.string(from: order.date ?? Date()) + "\t" +  nameOfCustomer!
    }
     
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    
     // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let managedObject = fetcheedReesultController.object(at: indexPath) as! NSManagedObject
            CoreDataManager.instance.viewContext.delete(managedObject)
            CoreDataManager.instance.saveContext()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let order = fetcheedReesultController.object(at: indexPath) as! Order
        performSegue(withIdentifier: "OrdersToOrder", sender: order)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "OrdersToOrder" {
            let controller  =  segue.destination as! OrderViewController
            controller.order = sender as? Order
        }
            
    }
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension OrdersTableViewController: NSFetchedResultsControllerDelegate {
    
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
                let order = fetcheedReesultController.object(at: indexPath) as! Order
                let cell = tableView.cellForRow(at: indexPath)
                configCell(cell: cell!, order: order)
            }
        default: break
        }
    
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
}
