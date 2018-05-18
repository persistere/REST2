//
//  ViewController+CoreData.swift
//  igpsRastreamento
//
//  Created by Jose Otavio on 18/05/2018.
//  Copyright © 2018 iGps Sistemas. All rights reserved.
//

import UIKit
import CoreData

extension UIViewController {
    
    var context: NSManagedObjectContext {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
        
    }
    
}
