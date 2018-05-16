//
//  RESTLOGIN.swift
//  igpsRastreamento
//
//  Created by Jose Otavio on 14/05/2018.
//  Copyright © 2018 iGps Sistemas. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class RESTLOGIN {

    private static let configuration: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        config.allowsCellularAccess = false
        config.httpAdditionalHeaders = ["Content-Type":"application/json"]
        config.timeoutIntervalForRequest = 30.0
        config.httpMaximumConnectionsPerHost = 5
        return config
    }()
    
    private static let session = URLSession(configuration: configuration)
    
    
    class func loadLogin(user: String, pass: String) {
        
        var tabelaLogin: TabelaLogin!
        
        var context: NSManagedObjectContext {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            return appDelegate.persistentContainer.viewContext
        }
        
        
        let basePath = "http://mobile.igps.com.br/acesso_app.php?user=\(user)&pass=\(pass)&ip=10.20.20.20&push=22211122&pai=aWc=&s_o=2&v_s_o=A.12_6.35&v_app=1.3&lat=-23.456&lng=-46.456&valida_1=1"
        
        guard let url = URL(string: basePath) else {return}
        
        let dataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            if error == nil {
                guard let response = response as? HTTPURLResponse else {return}
                
                if response.statusCode == 200 {
                    
                    guard let data = data else {return}
                    
                    do {
                        let users = try JSONDecoder().decode(Login.self, from: data)
                        
                        if tabelaLogin == nil {
                            tabelaLogin = TabelaLogin(context: context)
                        }
                        
                            if(users.pai != "" ) {
                                let pai = users.pai
                                let userId = users.user_id
                                
                                tabelaLogin.pai = pai
                                tabelaLogin.pass = pass
                                tabelaLogin.userId = userId
                                tabelaLogin.user = user
                                
                                do {
                                    try context.save()
                                } catch {
                                    print(error.localizedDescription)
                                }
                                
                                
                            } else {
                                print("erro de login")
                            }

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
    }
}


