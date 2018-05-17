//
//  Pin.swift
//  igpsRastreamento
//
//  Created by Jose Otavio on 17/05/2018.
//  Copyright © 2018 iGps Sistemas. All rights reserved.
//

import UIKit
import MapKit

class Pin : NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    
    init(coordinate : CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}
