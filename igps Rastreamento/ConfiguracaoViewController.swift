//
//  ConfiguracaoViewController.swift
//  igpsRastreamento
//
//  Created by Jose Otavio on 20/05/2018.
//  Copyright © 2018 iGps Sistemas. All rights reserved.
//

import UIKit
import CoreData

class ConfiguracaoViewController: UIViewController {
    
    @IBAction func btSair(_ sender: UIButton) {
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "TabelaLogin")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
            
            DispatchQueue.main.async {
                [unowned self] in
                self.performSegue(withIdentifier: "voltarLogin", sender: self)
            }
        } catch {
            print ("There was an error")
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
