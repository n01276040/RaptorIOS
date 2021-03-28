//
//  HistoryTableViewController.swift
//  Raptors
//
//  Created by Adnan on 2021-02-23.
//  Copyright © 2021 ca.Humber. All rights reserved.
//

import UIKit

class HistoryTableViewController: UITableViewController {
    //Variables Declartion
    var mymodel:Raptor=Raptor()
    //load
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Table view data source
    /*
     override func numberOfSections(in tableView: UITableView) -> Int {
     // #warning Incomplete implementation, return the number of sections
     return 0
     }*/
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count:Int=0
        if !mymodel.ticketshistory.isEmpty  {
            count=mymodel.ticketshistory.count
        }
        return count
    }
    
    //This code to fill the table cells
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if !mymodel.ticketshistory.isEmpty {
            let ticketHistory1:TicketHistory=mymodel.ticketshistory[indexPath.row]
            cell.textLabel?.text=ticketHistory1.name
            cell.detailTextLabel?.text=String(ticketHistory1.quantity)
            //  self.tableView.reloadData()
        }else{
            cell.textLabel?.text=""
            cell.detailTextLabel?.text=""
        }
        return cell
    }
    //This code to send The data to the History Details ViewContolor(another way instead of prepare seque
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "TicketHistoryDetailesViewController") as? TicketHistoryDetailesViewController{
            self.navigationController?.pushViewController(vc, animated: false)
            vc.mymodel=self.mymodel
            vc.row=indexPath.row
            //This code for animation
            UIView.transition(from: self.view, to: vc.view, duration: 0.85, options: [.transitionFlipFromLeft])
        }
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
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
