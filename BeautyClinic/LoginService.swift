//
//  LoginService.swift
//  BeautyClinic
//
//  Created by Matheus Nonaka on 6/20/15.
//  Copyright (c) 2015 Matheus Nonaka. All rights reserved.
//

import Foundation

class LoginService {
    
    class func doLogin(completion: Cliente -> Void, cpfCnpj: String, senha: String) {
        
        if let url = NSURL(string: "http://www2.beautyclinic.com.br/clinwebservice2/servidor/login") {
            
            let request = NSMutableURLRequest( URL: url)
            request.HTTPMethod = "POST"
            
            let params = ["cpfcnpj":cpfCnpj, "senha":senha, "codFilial":3] as Dictionary<String, AnyObject>
            
            do {
                request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(params, options: [])
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                request.addValue("application/json", forHTTPHeaderField: "Accept")
            } catch let error as NSError {
                print("erro ao inicializar json: \(error.localizedDescription)")
            }
            
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
                data, response, error in
                
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableLeaves) as? NSDictionary

                    if let parseJSON = json {
                        let cliente = Cliente()
                        cliente.codCliente = parseJSON["codcliente"] as! Int
                        cliente.cpfcnpj = parseJSON["cpfcnpj"] as! String
                        cliente.nome = parseJSON["nome"] as! String
                        cliente.sexo = parseJSON["senha"] as! String
                        //let jsonStatus: NSDictionary = parseJSON["status"] as! NSDictionary
                        //cliente.agendamentos = jsonStatus["agendamentos"] as! Int
                        //cliente.mensagens = jsonStatus["mensagens"] as! Int
                        completion(cliente)
                    }
                    
                } catch let error as NSError {
                    print("erro ao inicializar json: \(error.localizedDescription)")
                    let cliente = Cliente()
                    cliente.codCliente = 0
                    cliente.cpfcnpj = "0"
                    cliente.nome = "Erro"
                    cliente.sexo = "F"
                    completion(cliente)
                }
            }
            task.resume()
        }
        
    }
}