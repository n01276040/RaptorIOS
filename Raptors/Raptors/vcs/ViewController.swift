//
//  ViewController.swift
//  Raptors
//
//  Created by Adnan on 2021-02-21.
//  Copyright © 2021 ca.Humber. All rights reserved.
//

import UIKit
//View Controller
class ViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    //Variables Declaration
    //this variable to save the ticket price
    
    var myModel=Raptor()
    var ticketName:String=""
    var ticketPrice:Double=0.0
    var ticketQuantity:Int=0
    var totalPrice:Double=0.0
    var num:Int=0
    
    //To save Ticket name
    @IBOutlet weak var lblTicketName: UILabel!
    //Quantity Label
    @IBOutlet weak var lblTotalQuantity: UILabel!
    //To save Total price
    
    @IBOutlet weak var lblPrice: UILabel!
    
    //Purchase Quantity
    @IBOutlet weak var lblPurchaseQuantity: UILabel!
    //To save Total price
    //total price
    @IBOutlet weak var lblTotalPrice: UILabel!
    //PICKET VIEW
    @IBOutlet weak var ticketPicker: UIPickerView!
    //Instance of Tickets class
    var ticketsFromJson:Tickets=Tickets()
    //start loading
    override func viewDidLoad() {
        myModel.clearText(label1: lblPurchaseQuantity, label2: lblTotalPrice)
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //Instance of NetworkingManager
        let manager=NetworkingManager()
        //set the data in ticketsFromJson when it is ready using complitionHnadler
        manager.fetchData { (result) in
            self.ticketsFromJson = result
            //sent the result to main thread
            DispatchQueue.main.sync {
                //set the incoming result from json github in the myModel's Array,
                //so my app can resume the functionality as previous
                self.myModel.tickets=result.tickets
                //The data in picker view is empty, it needs to reload to update the data
                self.ticketPicker.reloadAllComponents()
                
            }
        }
        
        
        
    }    //This function to update pickerview after  increase quantity in Reset view controller
    override func viewWillAppear(_ animated: Bool) {
        ticketPicker.reloadAllComponents()
    }
    //This function to identify component number in picker view(columns)
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    //This function to identify number of row in each component (rows)
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var count:Int=0
        if !myModel.tickets.isEmpty{
            count=myModel.tickets.count
            
        }
        return count
        
    }
    //fill Picker view
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        
        //  lblTotalPrice.text=String(ticketPrice)
        if !myModel.tickets.isEmpty{
            ticketName=myModel.tickets[row].name
            ticketQuantity=myModel.tickets[row].quantity
            ticketPrice=myModel.tickets[row].price
            myModel.fillTexts(label1: lblTicketName, label2: lblTotalQuantity, label3: lblPrice, name1: ticketName, quantity:ticketQuantity, price:ticketPrice)
            return myModel.getDisplayStraing(name:myModel.tickets[row].name,quantity:myModel.tickets[row].quantity,price:myModel.tickets[row].price)
        }
        
        return ""
    }
    //event listner when a row is selected
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        //This line to clear the quantity and totalprice when The user select new ticket
        myModel.clearText(label1: lblPurchaseQuantity, label2: lblTotalPrice)
        //This code to fill picker view
        if !myModel.tickets.isEmpty{
            //this code to fill labels
            myModel.fillTexts(label1: lblTicketName, label2: lblTotalQuantity, label3: lblPrice, name1: ticketName, quantity:ticketQuantity, price:ticketPrice)
            ticketName=myModel.tickets[row].name
            
            ticketQuantity = myModel.tickets[row].quantity
            
            ticketPrice = myModel.tickets[row].price
            
            num=row
        }
    }
    
    //This function to get the ticket numbers(quantity)
    @IBAction func digitpressed(_ sender: Any) {
        lblPurchaseQuantity.text! += (sender as AnyObject).currentTitle!
        //  if lblPurchaseQuantity.text != nil{
        if let value=lblPurchaseQuantity.text,!value.isEmpty{
            totalPrice=Double(Double(lblPurchaseQuantity.text!)! * ticketPrice)
            lblTotalPrice.text=String(format:"%.2f",totalPrice)
        }
    }
    //This function excute many operations, calcualte the total price
    // then add Ticket History to an array, and remove the ticket from ticket array
    @IBAction func Buy(_ sender: Any) {
        if !lblPurchaseQuantity.text!.isEmpty && !lblTotalPrice.text!.isEmpty {
            let purchaseQuantity:Int=Int(lblPurchaseQuantity.text!)!
            if purchaseQuantity<=ticketQuantity{
                //This code to create confirmation dialog controller with Agree and cancel Button
                let buyalert = UIAlertController(title: "Confirmation",
                                                 message: "You are Purchasing:\n\(self.ticketName)\nQuantity: \(purchaseQuantity)\nTotal Price:  \(lblTotalPrice.text!) ", preferredStyle: UIAlertController.Style.alert)
                let AgreeAction=UIAlertAction(title: "Agree", style: .default)
                {(buyalert1) in
                    self.myModel.Buy(name: self.ticketName, totalQquantity: self.ticketQuantity, purchaseQuantity: purchaseQuantity, price: self.ticketPrice, row: self.num, tickets: &self.myModel.tickets, ticketsHistoryArray:  &self.myModel.ticketshistory)
                    self.ticketPicker.reloadAllComponents()
                    self.myModel.clearText(label1: self.lblPurchaseQuantity, label2: self.lblTotalPrice)
                }
                let CancelAction=UIAlertAction(title: "Cancel", style: .default)
                {
                    (haneler) in
                    self.myModel.clearText(label1: self.lblPurchaseQuantity, label2: self.lblTotalPrice)
                }
                buyalert.addAction(CancelAction)
                buyalert.addAction(AgreeAction)
                
                self.present(buyalert, animated: true, completion: nil)
            }else
            {
                //This code to display warning message to check quantity availability
                let uialert = UIAlertController(title: "warning", message: "Please,Select a quantity less than the available quantity "
                                                , preferredStyle: UIAlertController.Style.alert)
                uialert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
                self.present(uialert, animated: true, completion: nil)
                myModel.clearText(label1: lblPurchaseQuantity, label2: lblTotalPrice)
            }
            
        }else
        {
            //This code to display warning message to check if the quantity field is not empty
            let uialert = UIAlertController(title: "warning", message: "Please, Enter a positive number in Quantity field"
                                            , preferredStyle: UIAlertController.Style.alert)
            uialert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
            self.present(uialert, animated: true, completion: nil)
        }
    }
    //This code to clear label
    @IBAction func clear(_ sender: Any) {
        myModel.clearText(label1: lblPurchaseQuantity, label2: lblTotalPrice)
    }
    //This function to send model data to the next view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let Managervc=segue.destination as? ManagerViewController{
            Managervc.myModel=self.myModel
        }
    }
}

