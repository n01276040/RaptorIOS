//
//  DataModelClass.swift
//  Raptors
//
//  Created by Adnan Alg on 2021-03-27.
//  Copyright © 2021 ca.Humber. All rights reserved.
//

import Foundation
//class Ticket
class Ticket:Codable {
    //Variables Declartion
    var name:String
    var quantity:Int
    var price:Double
    //init (constructor)
    init(name:String,quantity:Int,price:Double){
        self.name=name
        self.quantity=quantity
        self.price=price
    }
    //init (constructor)
    init(name:String,quantity:Int){
        self.name=name
        self.quantity=quantity
        self.price=0
    }
}
//ticket class to receive Tickets Array from json
class Tickets:Codable{
    // Array to save Tickets
    var tickets=[Ticket]()
}
