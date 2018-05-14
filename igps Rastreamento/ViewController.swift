//
//  ViewController.swift
//  igps Rastreamento
//
//  Created by Jose Otavio on 31/12/2017.
//  Copyright © 2017 iGps Sistemas. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    
    
    
    
    
    @IBOutlet var tfUser: UITextField!
    @IBOutlet var tfPass: UITextField!
    @IBOutlet var btEnviar: UIButton!
    
    var user = "jbpribeiro";
    var pass = "dd9e2080ceebd0ac714c47d0f8a6c934";//otavio
    
    
    @IBAction func btEnviar(_ sender: UIButton) {
        
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        if tfUser.text == "" || tfPass.text == "" {
            alerta(titulo: "Atenção", erro: "Por favor preencha o usuário e senha")
            activityIndicator.stopAnimating()
        } else {
            user = tfUser.text!
            pass = MD5(tfPass.text!)!
            
            RESTLOGIN.loadLogin(user: user, pass: pass)
            
            //RESTLOGIN.loadLogin(urlLogin: urlLogin)
            
            activityIndicator.stopAnimating()
            
            //btEnviar.isEnabled = false
            //btEnviar.alpha = 0.5
            
            //alerta(titulo: "Erro", erro: "Aconteceu um erro inesperado, favor tente mais tarde")
            //activityIndicator.stopAnimating()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //downloadJsonWithURL()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
   
    
    
    func downloadJsonWithURL() {
        let urlString = "http://mobile.igps.com.br/app_1/call_app_1.php?inicial=1&user_id=4344&usuario=jbpribeiro&user=jbpribeiro&senha=dd9e2080ceebd0ac714c47d0f8a6c934&pass=66858572417537341635b4ed95534259&pai=aWc%3D"
        
        let url = NSURL(string: urlString)
        URLSession.shared.dataTask(with: (url as URL?)!, completionHandler: {(data, response, error) -> Void in
            
            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                
                
                if let actorArray = jsonObj!.value(forKey: "veiculos") as? NSArray {
                    for veiculo in actorArray {
                        if let i = veiculo as? NSDictionary {
                            if let ano_m = i.value(forKey: "ano_m") {
                                
                                print(ano_m)
                            }
                            

                        }
                    }
                }
                
//                OperationQueue.main.addOperation({
//                    self.tableView.reloadData()
//                })
            }
        }).resume()
    }
    
    
    func downloadJsonWithTask() {
        
        let url = NSURL(string: urlString)
        
        var downloadTask = URLRequest(url: (url as URL?)!, cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: 20)
        
        downloadTask.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: downloadTask, completionHandler: {(data, response, error) -> Void in
            
            let jsonData = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)
            
            print(jsonData)
            
        }).resume()
    }
    
    
    func MD5(_ string: String) -> String? {
        let length = Int(CC_MD5_DIGEST_LENGTH)
        var digest = [UInt8](repeating: 0, count: length)
        if let d = string.data(using: String.Encoding.utf8) {
            d.withUnsafeBytes { (body: UnsafePointer<UInt8>) in
                CC_MD5(body, CC_LONG(d.count), &digest)
            }
        }
        return (0..<length).reduce("") {
            $0 + String(format: "%02x", digest[$1])
        }
    }
    
    func alerta(titulo: String, erro: String)  {
        let alert = UIAlertController(title: titulo, message: erro, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
        return
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }


}


