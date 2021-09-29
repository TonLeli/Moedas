//
//  ViewController.swift
//  Moedas
//
//  Created by user on 13/09/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    @IBOutlet weak var tableview: UITableView!
    var currencies: Currencies?
    var listcurrencies = Array<Ars>()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.backgroundColor = .black
    
        ApiManager.getFinancialData { result in
            self.currencies = result.results.currencies
            self.listcurrencies.append(result.results.currencies.usd)
            self.listcurrencies.append(result.results.currencies.eur)
            self.listcurrencies.append(result.results.currencies.ars)
            
            self.tableview.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath) as! TableViewCell
        
        let currency = listcurrencies[indexPath.row]
        cell.labelCurrency.text = currency.name
        
        let percentegeFormated = String(format: "%.2f", currency.variation) + "%"
        
        cell.labelPercentage.text = percentegeFormated.replacingOccurrences(of: ".", with: ",")
        
        cell.contentView.layer.borderWidth = 1
        cell.contentView.layer.borderColor = UIColor.white.cgColor
        cell.contentView.layer.cornerRadius = 15
        
        cell.labelPercentage.textColor = getPercentageColor(percentegeFormated: percentegeFormated)
            
        return cell
    }
    
    func getPercentageColor(percentegeFormated: String) -> UIColor {
        if percentegeFormated == "0%" {
            return .white
        } else if percentegeFormated.contains("-") {
            return .red
        } else {
            return .systemGreen
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listcurrencies.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Cambio", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "CambioViewController") as! CambioViewController
        
        var currency = listcurrencies[indexPath.row]
        
        controller.ars = currency

        navigationController!.pushViewController(controller, animated: false)
    }
    
}

