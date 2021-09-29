//
//  ApiManage.swift
//  Moedas
//
//  Created by user on 15/09/21.
//

import Alamofire
import Foundation

class ApiManager {
   
    static func getFinancialData(oncompletion: @escaping (_ financemodel: FinanceModel) -> Void){
        AF.request("https://api.hgbrasil.com/finance").responseDecodable(of: FinanceModel.self) { response in
            if let responseapi = response.value {
                oncompletion(responseapi)
            }
            
        }
    }
}
