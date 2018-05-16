//
//  RESTCAR.swift
//  igpsRastreamento
//
//  Created by Jose Otavio on 10/05/2018.
//  Copyright © 2018 iGps Sistemas. All rights reserved.
//

import Foundation
import UIKit

struct Respostajson: Decodable {
    let resp: Int
    let msg: String
    let configuracoes: Configuracoes
    let veiculos: [Veiculos]
}

struct Configuracoes: Decodable{
    let frota: Int
    let modelo: Int
}

struct Veiculos: Decodable{
    let serie: String
    let placa: String
}


class RESTCAR {
    private static let configuration: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        config.allowsCellularAccess = false
        config.httpAdditionalHeaders = ["Content-Type":"application/json"]
        config.timeoutIntervalForRequest = 30.0
        config.httpMaximumConnectionsPerHost = 5
        return config
    }()
    
    private static let session = URLSession(configuration: configuration)
    
    
    class func loadCars(onComplete: @escaping ([Veiculos]) -> Void) {
        var user: String = ""
        var pass: String = ""
        var user_id: String = ""
        var pai: String = ""
        var data = [TabelaLogin]()
        
        do {
            data = try context.fetch(TabelaLogin.fetchRequest())
            
            for i in data {
                user_id = i.userId!
                user = i.user!
                pass = i.pass!
                pai = i.pai!
            }
        } catch {
            print("error")
        }
        
        let urlString = "http://mobile.igps.com.br/app_1/call_app_1.php?inicial=1&user_id=\(user_id)&usuario=\(user)&user=\(user)&senha=\(pass)&pass=\(pass)&pai=\(pai)"
        
        
        print(urlString)
        
        guard let url = URL(string: urlString) else {return}
        
        let dataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            if error == nil {
                guard let response = response as? HTTPURLResponse else {return}
                
                if response.statusCode == 200 {
                    guard let data = data else {return}

                    do {
                        let cars = try JSONDecoder().decode(Respostajson.self, from: data)
                        
                        //print(cars.veiculos)
                        onComplete(cars.veiculos)
                        
                    } catch {
                        print(error.localizedDescription)
                    }
                    
                } else {
                    print("Algum Status Invalido")
                }
                
            } else {
                print(error!)
            }
        }
        dataTask.resume()
        
        
        
        
        /*
         
         let url = NSURL(string: urlString)
         
        URLSession.shared.dataTask(with: (url as URL?)!, completionHandler: {(data, response, error) -> Void in
            

            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                
                if let veiculos = jsonObj!.value(forKey: "veiculos") as? NSArray {
                    
                    onComplete(veiculos as! [Car])
                    
//                    for veiculo in veiculos {
//                        if let i = veiculo as? NSDictionary {
//                           // if let ano_m = i.value(forKey: "ano_m") {
//                                print(i)
//
//                            //}
//                        }
//                    }
                }
                
                OperationQueue.main.addOperation({
                    //self.tableView.reloadData()
                })
            }
        }).resume()
        
        */
        
    }
    
}
