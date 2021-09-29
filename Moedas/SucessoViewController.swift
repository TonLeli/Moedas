//
//  Sucesso.swift
//  Moedas
//
//  Created by user on 28/09/21.
//

import UIKit


class SucessoViewController: UIViewController {
    
    var isVenda = false
    
    @IBOutlet weak var labelSucesso: UILabel!
    @IBOutlet weak var homeBotao: UIButton!
    var valorMoeda = "0.0"
    var valorReais = "0.0"
    
    @IBAction func botaoVoltarHome(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        homeBotao.layer.cornerRadius = 22.0
        
        navigationController?.navigationBar.backItem?.backButtonTitle = "Câmbio"
        if isVenda {
            self.title = "Vender"
            labelSucesso.text = "Parabéns!  Você acabou de vender \(valorMoeda), totalizando  \(valorReais)"
        } else {
            self.title = "Comprar"
            labelSucesso.text = "Parabéns!  Você acabou de comprar \(valorMoeda), totalizando  \(valorReais)"
        }
       
    }
    
}
