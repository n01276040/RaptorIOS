//
//  TicketHistoryDetailesViewController.swift
//  Raptors
//
//  Created by user182545 on 2/25/21.
//  Copyright © 2021 ca.Humber. All rights reserved.
//

import UIKit

class TicketHistoryDetailesViewController: UIViewController {
    //Variabls Declaration
    @IBOutlet weak var lblItem: UILabel!
    
    @IBOutlet weak var lblQuantity: UILabel!
    
    @IBOutlet weak var lblTotalPrice: UILabel!
    
    @IBOutlet weak var lblDate: UILabel!
    //Variables Initialisation to receive data from HistoryTable ViewController
    var mymodel=Raptor()
    var row:Int=0
    override func viewDidLoad() {
        //This code for date and time output
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateStyle = .long
        formatter.locale = Locale(identifier: "en_US")
        formatter.timeZone=TimeZone.current
        // get the date time String from the date object
        let itemName:String=mymodel.ticketshistory[row].name
        let quantity:Int=mymodel.ticketshistory[row].quantity
        let totalPrice:Double=mymodel.ticketshistory[row].totalPrice
        mymodel.fillTexts(label1: lblItem, label2: lblQuantity, label3: lblTotalPrice, name1: itemName, quantity:quantity, price: totalPrice)
        lblDate.text="\(formatter.string(from: mymodel.ticketshistory[row].purchaseDate))"
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
