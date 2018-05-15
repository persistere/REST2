//
//  RESTCAR.swift
//  igpsRastreamento
//
//  Created by Jose Otavio on 10/05/2018.
//  Copyright © 2018 iGps Sistemas. All rights reserved.
//

import Foundation


class RESTCAR {
    
    var user: String
    var pass: String
    var user_id: String
    var pai: String
    
    init(u: String, s: String, ui: String, p: String){
        user = u
        pass = s
        user_id = ui
        pai = p
    }
    
    private static let configuration: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        config.allowsCellularAccess = false
        config.httpAdditionalHeaders = ["Content-Type":"application/json"]
        config.timeoutIntervalForRequest = 30.0
        config.httpMaximumConnectionsPerHost = 5
        return config
    }()
    

    private static let session = URLSession(configuration: configuration)
    
    func loadCars() {
        
        let urlString = "http://mobile.igps.com.br/app_1/call_app_1.php?inicial=1&user_id=\(user_id)&usuario=\(user)&user=\(user)&senha=\(pass)&pass=\(pass)&pai=\(pai)"
        
        let url = NSURL(string: urlString)

        URLSession.shared.dataTask(with: (url as URL?)!, completionHandler: {(data, response, error) -> Void in
            
            
            
            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                

                
                if let veiculos = jsonObj!.value(forKey: "veiculos") as? NSArray {


                    
                    for veiculo in veiculos {
                        if let i = veiculo as? NSDictionary {
                           // if let ano_m = i.value(forKey: "ano_m") {
                                print(i)

                            //}
                        }
                    }
                }
                
                OperationQueue.main.addOperation({
                    //self.tableView.reloadData()
                })
            }
        }).resume()
        
    }
    
}
