//
//  Cambio.swift
//  Moedas
//
//  Created by user on 28/09/21.
//

import UIKit


class CambioViewController: UIViewController {
    
    @IBOutlet weak var containerMoeda: UIView!
    @IBOutlet weak var containerQuantidade: UIView!
    @IBOutlet weak var quantidade: UITextField!
    @IBOutlet weak var botaoVender: UIButton!
    @IBOutlet weak var botaoComprar: UIView!
    @IBOutlet weak var moeda: UILabel!
    @IBOutlet weak var porcentagem: UILabel!
    @IBOutlet weak var valorDeCompra: UILabel!
    @IBOutlet weak var valorDeVenda: UILabel!
    @IBOutlet weak var saldo: UILabel!
    @IBOutlet weak var moedaCaixa: UILabel!

    var valorTotalRealCaixa = 1000.0
    
    var dolarCaixa = 0.0
    var euroCaixa = 0.0
    var pesoCaixa = 0.0
    
    var ars : Ars?
    
    @IBAction func botaoVender(_ sender: Any) {
        var valorSelecionado = Double(quantidade.text!)
        var valorConvertidoReal = 0.0
        if let valorVenda = ars?.sell {
            valorConvertidoReal = valorSelecionado! * valorVenda
        } else {
            valorConvertidoReal = valorSelecionado! * ars!.buy
        }
       
        
            if ars?.name == "Dollar" {
                if dolarCaixa < valorSelecionado! {
                    botaoVender.isUserInteractionEnabled = false
                    botaoVender.alpha = 0.5
                } else {
                    dolarCaixa =  dolarCaixa - valorSelecionado!
                    valorTotalRealCaixa = valorTotalRealCaixa + valorConvertidoReal
                    mostrarTelaSucessoVenda(valorSelecionado: valorSelecionado!, valorReal: valorConvertidoReal)
                }
            }else if ars?.name == "Euro" {
                if euroCaixa < valorSelecionado! {
                    botaoVender.isUserInteractionEnabled = false
                    botaoVender.alpha = 0.5
                } else {
                    euroCaixa =  euroCaixa - valorSelecionado!
                    valorTotalRealCaixa = valorTotalRealCaixa + valorConvertidoReal
                    mostrarTelaSucessoVenda(valorSelecionado: valorSelecionado!, valorReal: valorConvertidoReal)
                }
            } else {
                if pesoCaixa < valorSelecionado! {
                    botaoVender.isUserInteractionEnabled = false
                    botaoVender.alpha = 0.5
                } else {
                    pesoCaixa =  pesoCaixa - valorSelecionado!
                    valorTotalRealCaixa = valorTotalRealCaixa + valorConvertidoReal
                    mostrarTelaSucessoVenda(valorSelecionado: valorSelecionado!, valorReal: valorConvertidoReal)
                }
            }
            viewDidLoad()
        
    
    }
    
    @IBAction func botaoComprar(_ sender: Any) {
        var valorSelecionado = Double(quantidade.text!)
        
        botaoComprar.isUserInteractionEnabled = true
        botaoComprar.alpha = 1.0
        
        var valorConvertidoParaReal = valorSelecionado! * ars!.buy
        
        if valorConvertidoParaReal > valorTotalRealCaixa {
            botaoComprar.isUserInteractionEnabled = true
            botaoComprar.alpha = 0.5
            
        } else {
            if ars?.name == "Dollar" {
                dolarCaixa =  dolarCaixa + valorSelecionado!
                valorTotalRealCaixa = valorTotalRealCaixa - valorConvertidoParaReal
                mostrarTelaSucessoCompra(valorSelecionado: valorSelecionado!, valorReal: valorConvertidoParaReal)
            }else if ars?.name == "Euro" {
                euroCaixa =  euroCaixa + valorSelecionado!
                valorTotalRealCaixa = valorTotalRealCaixa - valorConvertidoParaReal
                mostrarTelaSucessoCompra(valorSelecionado: valorSelecionado!, valorReal: valorConvertidoParaReal)
            } else {
                pesoCaixa =  pesoCaixa + valorSelecionado!
                valorTotalRealCaixa = valorTotalRealCaixa - valorConvertidoParaReal
                mostrarTelaSucessoCompra(valorSelecionado: valorSelecionado!, valorReal: valorConvertidoParaReal)
            }
            viewDidLoad()
        }
    }
    
    
    func mostrarTelaSucessoVenda(valorSelecionado: Double, valorReal: Double) {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "pt_BR") // Change this to another locale if you want to force a specific locale, otherwise this is redundant as the current locale is the default already
        formatter.numberStyle = .currency
        let storyboard = UIStoryboard(name: "Sucesso", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "SucessoViewController") as! SucessoViewController
        
        controller.isVenda = true
        controller.valorMoeda = getVendaText(valorSelecionado: valorSelecionado)
        controller.valorReais = formatter.string(from: (valorReal as NSNumber?)!)!
            

        navigationController!.pushViewController(controller, animated: false)
    }
    
    func mostrarTelaSucessoCompra(valorSelecionado: Double, valorReal: Double) {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "pt_BR") // Change this to another locale if you want to force a specific locale, otherwise this is redundant as the current locale is the default already
        formatter.numberStyle = .currency
        let storyboard = UIStoryboard(name: "Sucesso", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "SucessoViewController") as! SucessoViewController
        
        controller.isVenda = false
        controller.valorMoeda = getVendaText(valorSelecionado: valorSelecionado)
        controller.valorReais = formatter.string(from: (valorReal as NSNumber?)!)!
            

        navigationController!.pushViewController(controller, animated: false)
    }
    
    func getVendaText(valorSelecionado: Double) -> String {
        
        if ars?.name == "Dollar" {
            let formatter = NumberFormatter()
            formatter.locale = Locale(identifier: "en_US") // Change this to another locale if you want to force a specific locale, otherwise this is redundant as the current locale is the default already
            formatter.numberStyle = .currency
            return formatter.string(from: valorSelecionado as NSNumber)!
        }else if ars?.name == "Euro" {
            
            let formatter = NumberFormatter()
            formatter.locale = Locale(identifier: "pt_PT") // Change this to another locale if you want to force a specific locale, otherwise this is redundant as the current locale is the default already
            formatter.numberStyle = .currency
            return formatter.string(from: valorSelecionado as NSNumber)!
        } else {
            let formatter = NumberFormatter()
            formatter.locale = Locale(identifier: "es_AR") // Change this to another locale if you want to force a specific locale, otherwise this is redundant as the current locale is the default already
            formatter.numberStyle = .currency
            return formatter.string(from: valorSelecionado as NSNumber)!
        }
    }
    
    override func viewDidLoad() {
        
        quantidade.addTarget( nil,
                              action: #selector(textChanged(sender:)),
                              for: UIControl.Event.editingChanged)
        
        let percentegeFormated = String(format: "%.2f", ars!.variation) + "%"
        self.navigationController?.navigationBar.isHidden = false
        self.title = "Câmbio"
        self.navigationController?.navigationBar.backItem?.backButtonTitle = "Moedas"
        moeda.text = ars?.name
        porcentagem.text = percentegeFormated.replacingOccurrences(of: ".", with: ",")
        
        porcentagem.textColor = getPercentageColor(percentegeFormated: percentegeFormated)
        
        
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "pt_BR") // Change this to another locale if you want to force a specific locale, otherwise this is redundant as the current locale is the default already
        formatter.numberStyle = .currency
        
        
        saldo.text = "Saldo disponível: \(formatter.string(from: valorTotalRealCaixa as! NSNumber)!)"

        if let valorVenda = ars?.sell {
            if let valorVendaFormatado = formatter.string(from: ars?.sell as! NSNumber) {
                valorDeVenda.text = "Venda: \(valorVendaFormatado)"
            }
        }else {
            valorDeVenda.text = "Venda: R$ 0,00"
        }
       
        if let valorCompra = ars?.buy {
            if let valorCompraFormatado = formatter.string(from: ars?.buy as! NSNumber) {
                valorDeCompra.text = "Compra: \(valorCompraFormatado)"
            }
        } else {
            valorDeVenda.text = "Compra: R$ 0,00"
        }
        
        moedaCaixa.text = getValorMoedas()
        
    }
    
    @objc func textChanged(sender: Any!) {
        botaoComprar.alpha = 1.0
        botaoComprar.isUserInteractionEnabled = true
        botaoVender.alpha = 1.0
        botaoVender.isUserInteractionEnabled = true
      }
    
    func getValorMoedas() -> String {

        
        if ars?.name == "Dollar" {
            let formatter = NumberFormatter()
            formatter.locale = Locale(identifier: "pt_BR") // Change this to another locale if you want to force a specific locale, otherwise this is redundant as the current locale is the default already
            formatter.numberStyle = .currency
            return "Dollar em caixa: \(formatter.string(from: dolarCaixa as NSNumber)!)"
        }else if ars?.name == "Euro" {
            
            let formatter = NumberFormatter()
            formatter.locale = Locale(identifier: "pt_PT") // Change this to another locale if you want to force a specific locale, otherwise this is redundant as the current locale is the default already
            formatter.numberStyle = .currency
            return "Euro em caixa: \(formatter.string(from: euroCaixa as NSNumber)!)"
        } else {
            let formatter = NumberFormatter()
            formatter.locale = Locale(identifier: "es_AR") // Change this to another locale if you want to force a specific locale, otherwise this is redundant as the current locale is the default already
            formatter.numberStyle = .currency
            return "Peso Argentino em caixa: \(formatter.string(from: pesoCaixa as NSNumber)!)"
        }
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
    
    override func viewWillAppear(_ animated: Bool) {
        containerMoeda.layer.borderWidth = 1
        containerMoeda.layer.borderColor = UIColor.white.cgColor
        containerMoeda.layer.cornerRadius = 15
        containerQuantidade.layer.borderWidth = 1
        containerQuantidade.layer.borderColor = UIColor.gray.cgColor
        containerQuantidade.layer.cornerRadius = 10
        quantidade.textColor = UIColor.gray
        
        botaoVender.layer.cornerRadius = 22
        botaoComprar.layer.cornerRadius = 22
        
    }
    
}
