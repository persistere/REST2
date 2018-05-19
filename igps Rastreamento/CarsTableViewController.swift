//
//  CarsTableViewController.swift
//  igpsRastreamento
//
//  Created by Jose Otavio on 10/05/2018.
//  Copyright © 2018 iGps Sistemas. All rights reserved.
//

import UIKit

class CarsTableViewController: UITableViewController {
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    var cars: [Veiculos] = []
    
    var refrasher: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refrasher = UIRefreshControl()
//        refrasher.attributedTitle = NSAttributedString(string: "reload")
        refrasher.addTarget(self, action: #selector(CarsTableViewController.viewWillAppear(_:)), for: UIControlEvents.valueChanged)
        tableView.addSubview(refrasher)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        RESTCAR.loadCars(onComplete: { (cars) in
            self.cars = cars
            DispatchQueue.main.async {
                self.refrasher.endRefreshing()
                self.tableView.reloadData()
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    // MARK: - Table view data source
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(self.cars.count == 0) {
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            
        } else {
            activityIndicator.stopAnimating()
        }
        
          print(self.cars.count)
        
        return self.cars.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CarsTableViewCell
        
        let placa = self.cars[indexPath.row].placa
        let endereco = self.cars[indexPath.row].endereco
        let gpsDataHora = self.cars[indexPath.row].dh_hps_tratado
        let latitude = self.cars[indexPath.row].latitude
        let longitude = self.cars[indexPath.row].longitude
        
//        let ignicao = self.cars[indexPath.row].chave
//        let dentroOuFora = self.cars[indexPath.row].atualizado
//        let marca = self.cars[indexPath.row].ano_m

        
        cell.placa?.text = placa
        cell.endereco?.text = endereco
        cell.gpsDataHora?.text = gpsDataHora

//        cell.marca?.text = ignicao
//        cell.bateria?.image = ignicao
//        cell.ignicao?.image = ignicao
//        cell.dentroOuFora?.image = ignicao
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)  {
        performSegue(withIdentifier: "showDatails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? MapaViewController{
            destination.veiculos = cars[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
