//
//  ResetViewController.swift
//  Raptors
//
//  Created by Adnan on 2021-02-23.
//  Copyright © 2021 ca.Humber. All rights reserved.
//

import UIKit

class ResetViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    
    //Variables Declaration
    var mymodel:Raptor=Raptor()
    var num:Int=0
    @IBOutlet weak var txtQuantityUpdtae: UITextField!
    @IBOutlet weak var lblResetTicketName: UILabel!
    @IBOutlet weak var lblCurrentQuantity: UILabel!
    @IBOutlet weak var lblResetTicketPrice: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    
    //load
    override func viewDidLoad() {
        super.viewDidLoad()
        //This line of code for iphone keyboard,
        //so it will disapper when the user select numbers and finish
        //The main code in the controller
        self.hideKeyboardWhenTappedAround()
    }
    
    //This code for component number of pickerview(columns)
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    //This code for numbers of row pickerview(rows)
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var count:Int=0
        if !mymodel.tickets.isEmpty{
            count=mymodel.tickets.count
        }
        return count
    }
    //fill Picker view
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        
        if !mymodel.tickets.isEmpty{
            //This code to file labels as initials
            mymodel.fillTexts(label1: lblResetTicketName, label2: lblCurrentQuantity, label3: lblResetTicketPrice, name1: mymodel.tickets[row].name, quantity:  mymodel.tickets[row].quantity, price:mymodel.tickets[row].price)
            //This code to fill the picker veiw
            return mymodel.getDisplayStraing(name: mymodel.tickets[row].name, quantity: mymodel.tickets[row].quantity, price: mymodel.tickets[row].price)
        }
        return ""
    }
    
    //This code when user select a row
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        if !mymodel.tickets.isEmpty{
            //This code to file labels when user select row in picker view
            mymodel.fillTexts(label1: lblResetTicketName, label2: lblCurrentQuantity, label3:lblResetTicketPrice, name1: mymodel.tickets[row].name, quantity:  mymodel.tickets[row].quantity, price: mymodel.tickets[row].price)
            num=row
        }
    }
    
    
    //This code to update the quantity
    @IBAction func updateQuantity(_ sender: Any) {
        if let value=txtQuantityUpdtae.text,!value.isEmpty{
            let IncreasedQuantity:Int=Int(txtQuantityUpdtae.text!)!
            let newQuantity:Int=Int(lblCurrentQuantity.text!)!+IncreasedQuantity
            // show alert when user choose Agree YesAction is excuted otherwise NoAction is excuted
            let buyalert = UIAlertController(title: "Confirmation",
                                             message: "You are Updating Quantity:\n\n\(lblResetTicketName.text!)\n\nNew Quantity: \(newQuantity)\n ", preferredStyle: UIAlertController.Style.alert)
            let YesAction=UIAlertAction(title: "Agree", style: .default)
            {(buyalert1) in
                self.mymodel.increaseQuantity(quantity: IncreasedQuantity, tickets: self.mymodel.tickets, row: self.num)
                self.txtQuantityUpdtae.text=""
                self.pickerView.reloadAllComponents()
            }
            let NoAction=UIAlertAction(title: "Cancel", style: .default){
                (haneler) in
                self.txtQuantityUpdtae.text=""
            }
            buyalert.addAction(NoAction)
            buyalert.addAction(YesAction)
            self.present(buyalert, animated: true, completion: nil)
        }else{
            //This code to display warning message to check if the update quantity field is not empty
            let uialert = UIAlertController(title: "warning", message: "Please, Enter a positive number in Update Quantity field"
                , preferredStyle: UIAlertController.Style.alert)
            uialert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
            self.present(uialert, animated: true, completion: nil)
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



