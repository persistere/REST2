//
//  CarsTableViewCell.swift
//  igpsRastreamento
//
//  Created by Jose Otavio on 15/05/2018.
//  Copyright © 2018 iGps Sistemas. All rights reserved.
//

import UIKit

class CarsTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var placa: UILabel!
    @IBOutlet weak var endereco: UILabel!
    @IBOutlet weak var ignicao: UIImageView!
    @IBOutlet weak var dentroOuFora: UIImageView!
    @IBOutlet weak var gpsDataHora: UILabel!
    @IBOutlet weak var modelo: UILabel!
    @IBOutlet weak var bateria: UIImageView!
    @IBOutlet weak var frota: UILabel!
    @IBOutlet weak var cor: UILabel!
    @IBOutlet weak var ano: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
