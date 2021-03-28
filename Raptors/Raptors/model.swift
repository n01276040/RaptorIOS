
//
//  model.swift
//  Raptors
//
//  Created by Adnan on 2021-02-22.
//  Copyright © 2021 ca.Humber. All rights reserved.
//

import Foundation
import UIKit

//Class TickHistory
class TicketHistory:Ticket {
    var purchaseDate = Date()
    var totalPrice:Double
    init(name:String,quantity:Int,totalPrice:Double){
        self.totalPrice=totalPrice
        super.init(name:name,quantity:quantity)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}

//model class
class Raptor{
    // Array to save Tickets
    var tickets:[Ticket]=[]
    // Array to save Tickets History
    var ticketshistory:[TicketHistory]=[]
    
    //This function to excute purchase process including add a sould ticket to historyarray and remove it from tickets array
    func Buy(name:String,totalQquantity:Int,purchaseQuantity:Int,price:Double,row:Int,tickets:inout [Ticket],ticketsHistoryArray:inout [TicketHistory])->() {
        var totalPrice1:Double=0.0
        if !name.isEmpty && purchaseQuantity>0 && purchaseQuantity<=totalQquantity && !tickets.isEmpty{
            totalPrice1=Double(purchaseQuantity)*price
            //instance of TicketHistory
            let ticketHistory=TicketHistory(name:name,quantity:purchaseQuantity,totalPrice:totalPrice1)
            ticketsHistoryArray.append(ticketHistory)
            //quantity subtraction
            let quantityChange:Int = totalQquantity-purchaseQuantity
            tickets[row].quantity=quantityChange
            
        }
    }
    
    //This function to increase the quantity in Tickets Array it use in Reset view controller
    func increaseQuantity(quantity:Int,tickets:[Ticket],row:Int)->(){
        
        if quantity>0 && !tickets.isEmpty{
            tickets[row].quantity+=quantity
            
        }
    }
    //Some utilies functions to dispaly and filltext
    //This utility function for display string in picker view
    func getDisplayStraing(name:String,quantity:Int,price:Double)->(String){
        let dispalyString:String="\(name)   \(quantity)  \(price)"
        return dispalyString
    }
    
    //This utility function to fill labels because I used some times
    func fillTexts(label1:UILabel,label2:UILabel,label3:UILabel,name1:String,quantity:Int,price:Double)->(){
        label1.text=name1
        label2.text="\(quantity)"
        label3.text=String(format:"%.2f",price)
    }
    //This utility function to clear labels
    func clearText(label1:UILabel,label2:UILabel)->(){
        label1.text=""
        label2.text=""
    }
    
}
//This extension and code make iPhone Keyboard dismiss after the user selects the numbers
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
