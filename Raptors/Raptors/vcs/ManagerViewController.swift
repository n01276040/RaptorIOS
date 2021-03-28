//
//  TicketHistoryViewController.swift
//  Raptors
//
//  Created by Adnan on 2021-02-23.
//  Copyright © 2021 ca.Humber. All rights reserved.
//

import UIKit

class ManagerViewController: UIViewController {
    //variable Declaration
    var myModel=Raptor()
    var name:String=""
    //load the page
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    //This Function send the model data to the next view controller(History or reset depend on the User's choice
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "HistoryTableViewController"{
            if  let ticketsHistoryvc=segue.destination as? HistoryTableViewController{
                ticketsHistoryvc.mymodel=self.myModel
            }
        }else if segue.identifier == "ResetViewController" {
            if let resetvc=segue.destination as? ResetViewController{
                resetvc.mymodel=self.myModel
            }
        }
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
