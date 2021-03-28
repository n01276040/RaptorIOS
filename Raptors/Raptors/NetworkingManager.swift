//
//  NetworkingManager.swift
//  Raptors
//
//  Created by Adnan Alg on 2021-03-26.
//  Copyright © 2021 ca.Humber. All rights reserved.
//

import Foundation
class NetworkingManager{
    //fetch data function with complitionHnadler
    func fetchData(complitionHnadler : @escaping (Tickets)->Void){
        //variable result(Tickrt Array) to save the returned tickets from json
        var result:Tickets=Tickets()
        //The url of json frpm github
        let url1=URL(string:"https://raw.githubusercontent.com/n01276040/RaptorIOS/master/Ticket.json")
        //check url to avoid any null
        if let url=url1{
            //start thread (Asynchronous function)
            let task=URLSession.shared.dataTask(with: url)
            {
                //start Closures
                (data,response,error) in
                //checking for errors
                if let error=error{
                    print(error)
                    return
                }
                
                //checking for response
                guard let httprespons = response as? HTTPURLResponse,
                      (200...299).contains(httprespons.statusCode) else{
                    if let response=response as? HTTPURLResponse{
                        print("response is \(response.statusCode)")
                    }
                    return
                }
                //start fetch data
                if let jsondata=data{
                    //Deserialize the incoming data
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    do{
                        //The result it is an instance of Tickets class and containd Array of Ticket
                        result=try decoder.decode(Tickets.self, from: jsondata)
                        // the complitionHnadler is called after the result is  ready
                        complitionHnadler(result)
                        //catch any error
                    }catch{
                        print("error from catch")
                    }
                }
            }
            //start the thread
            task.resume()
            //this erro if the the url is null
        }else{
            print ("error from json")
            
        }
      
    }
}

