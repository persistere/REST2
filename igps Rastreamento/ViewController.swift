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
    
    var data = [TabelaLogin]()
    
    @IBOutlet var tfUser: UITextField!
    @IBOutlet var tfPass: UITextField!
    @IBOutlet var btEnviar: UIButton!
    
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

            let user = tfUser.text!
            let pass = MD5(tfPass.text!)!
            
            RESTLOGIN.loadLogin(user: user, pass: pass)
            
            activityIndicator.stopAnimating()
            
            navigationController?.popViewController(animated: true)
            
            lista()
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //downloadJsonWithURL()
        lista()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func lista() {
        
        do {
            data = try context.fetch(TabelaLogin.fetchRequest())
            
            for i in data {
                
                if (i.pai == "aWc=") {
                    print("tableview")
                } else {
                    print("fazer Login")
                }
                
                //print("Nome: \(i.pai)\n Senha:\( i.pass)" )
            }
        } catch {
            print("error")
        }
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


