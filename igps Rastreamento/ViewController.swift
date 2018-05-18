//
//  ViewController.swift
//  igps Rastreamento
//
//  Created by Jose Otavio on 31/12/2017.
//  Copyright © 2017 iGps Sistemas. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ViewController: UIViewController {
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    var tabelaLogin: TabelaLogin!
    
    var logins = [TabelaLogin]()
    
    @IBOutlet var tfUser: UITextField!
    @IBOutlet var tfPass: UITextField!
    @IBOutlet var btEnviar: UIButton!
    
    @IBAction func btEnviar(_ sender: UIButton) {
        
        if tfUser.text == "" || tfPass.text == "" {
            alerta(titulo: "Atenção", erro: "Por favor preencha o usuário e senha")
        } else {
            
            let user = tfUser.text!
            let pass = MD5(tfPass.text!)!

            let jsonURL = "http://mobile.igps.com.br/acesso_app.php?user=\(user)&pass=\(pass)&ip=10.20.20.20&push=22211122&pai=aWc=&s_o=2&v_s_o=A.12_6.35&v_app=1.3&lat=-23.456&lng=-46.456&valida_1=1"
            
            let url = URL(string: jsonURL)
            
            URLSession.shared.dataTask(with: url!){( data, response, error ) in
                do {
                    let users = try JSONDecoder().decode(Login.self, from: data!)
                    
//                    print("---------------------------v")
//                    print(users.pai)
//                    print(users.user_id)
                    
                    if( users.pai == nil && users.user_id == nil ) {
                        self.alertaErro()
                    } else {
                        
                        if self.tabelaLogin == nil {
                            self.tabelaLogin = TabelaLogin(context: self.context)
                        }
                        
                        let pai = users.pai
                        let userId = users.user_id
                        
                        self.tabelaLogin.pai = pai
                        self.tabelaLogin.pass = pass
                        self.tabelaLogin.userId = userId
                        self.tabelaLogin.user = user
                        
                        do {
                            try self.context.save()
                        } catch {
                            print("Nao salvo")
                        }
                        
                        DispatchQueue.main.async {
                            [unowned self] in
                            self.performSegue(withIdentifier: "sucessoSegue", sender: self)
                        }
                    }
                    
                } catch {
                    print("Error")
                }
            }.resume()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lista()
    }
    
    func alertaErro(){
        print("erro")
    }
    
    func lista() {
        var lista = 0
        
        do {
            logins = try context.fetch(TabelaLogin.fetchRequest())
            
            for i in logins {
                
                if (i.pai == "aWc=") {
                    lista = 1
                }
                print("tableview")
                print("Nome: \(i.pai)\n Senha:\( i.pass)" )
            }
            
            if lista >= 1 {
                DispatchQueue.main.async {
                    [unowned self] in
                    self.performSegue(withIdentifier: "sucessoSegue", sender: self)
                }
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


