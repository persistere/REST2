//
//  RESTCAR.swift
//  igpsRastreamento
//
//  Created by Jose Otavio on 10/05/2018.
//  Copyright © 2018 iGps Sistemas. All rights reserved.
//

import Foundation

class RESTCAR {
    
    private static let basePath = "http://mobile.igps.com.br/app_1/call_app_1.php?inicial=1&user_id=4344&usuario=jbpribeiro&user=jbpribeiro&senha=dd9e2080ceebd0ac714c47d0f8a6c934&pass=66858572417537341635b4ed95534259&pai=aWc%3D"
    
    private static let configuration: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        config.allowsCellularAccess = false
        config.httpAdditionalHeaders = ["Content-Type":"application/json"]
        config.timeoutIntervalForRequest = 30.0
        config.httpMaximumConnectionsPerHost = 5
        return config
    }()
    
    private static let session = URLSession(configuration: configuration)
    
    class func loadCars(pai: String, user_id: String) {
        guard let url = URL(string: basePath) else {return}
        
        let dataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            if error == nil {
                guard let response = response as? HTTPURLResponse else {return}
                
                if response.statusCode == 200 {
                    
                    guard let data = data else {return}
                    do {
                        let cars = try JSONDecoder().decode([Car].self, from: data)
                        
                        for car in cars {
                            print(car.ano_m, car.cor )
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
