//
//  ViewController+CoreData.swift
//  igpsRastreamento
//
//  Created by Jose Otavio on 15/05/2018.
//  Copyright © 2018 iGps Sistemas. All rights reserved.
//

import UIKit
import CoreData

extension RESTLOGIN {
    
    var context: NSManagedObjectContext {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        return AppDelegate.persistentContainer.viewContext
        
        
    }
}
