//
//  CadastroService.swift
//  BeautyClinic
//
//  Created by Matheus Nonaka on 6/29/16.
//  Copyright (c) 2016 Matheus Nonaka. All rights reserved.
//

import Foundation

class CadastroService {
    
    class func doCadastro(callback: (cliente: Cliente, error: NSError!) -> Void, cpf: String, nome: String, senha: String, codFilial: Int) {
        
        if let url = NSURL(string: "http://www2.beautyclinic.com.br/clinwebservice/servidor/cadcliente") {
            let request = NSMutableURLRequest( URL: url)
            request.HTTPMethod = "POST"
            
            let params = ["cpfcnpj":cpf, "nome":nome, "senha":senha, "codFilial":codFilial, "tipopessoa":"F", "opcad":42] as Dictionary<String, AnyObject>
            
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
                    let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
                    print(jsonStr)
                    let cliente = Cliente()
                    /*let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableLeaves) as? NSDictionary
                    
                    if let parseJSON = json {
                        let cliente = Cliente()
                        cliente.codCliente = parseJSON["codcliente"] as! Int
                        cliente.cpfcnpj = parseJSON["cpfcnpj"] as! String
                        cliente.nome = parseJSON["nome"] as! String
                        cliente.sexo = parseJSON["senha"] as! String
                        //let jsonStatus: NSDictionary = parseJSON["status"] as! NSDictionary
                        //cliente.agendamentos = jsonStatus["agendamentos"] as! Int
                        //cliente.mensagens = jsonStatus["mensagens"] as! Int*/
                        callback(cliente: cliente, error: error)
                    //}
                    
                } catch let error as NSError {
                    print("erro ao inicializar json: \(error.localizedDescription)")
                }
            }
            task.resume()
        }
    }
}