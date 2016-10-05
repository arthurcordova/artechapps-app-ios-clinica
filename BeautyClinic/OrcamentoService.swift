//
//  OrcamentoService.swift
//  BeautyClinic
//
//  Created by Matheus Nonaka on 7/9/15.
//  Copyright (c) 2015 Matheus Nonaka. All rights reserved.
//

import Foundation

class OrcamentoService {
    
    class func parserOrcamentos(data: NSData) -> Array<Orcamento> {
        
        do {
            if (data.length == 0) {
                return []
            }
            
            var orcamentos: Array<Orcamento> = []
            let dict: NSArray = try NSJSONSerialization.JSONObjectWithData(data, options:
                NSJSONReadingOptions.MutableContainers) as! NSArray
            
            for obj:AnyObject in dict {
                let dict = obj as! NSDictionary
                let orcamento = Orcamento()
                orcamento.codigo = dict["codOrcamento"] as! Int
                orcamento.data = dict["dataOrcamento"] as! String
                orcamento.valorTotal = dict["valorOrcamento"] as! Float
                orcamento.desconto = dict["valorDesconto"] as! Float
                orcamento.status = dict["status"] as! String
                orcamentos.append(orcamento)
            }
            
            return orcamentos
            
        } catch let error as NSError {
            print("json error: \(error.localizedDescription)")
            return []
        }
        
    }
    
    class func getOrcamentos(callback: (orcamentos: Array<Orcamento>, error: NSError!) -> Void, codCliente: String) {
        
        let http = NSURLSession.sharedSession()
        let url = NSURL(string: "http://www2.beautyclinic.com.br/clinwebservice2/servidor/orcporcliente/"+codCliente)!
        let task = http.dataTaskWithURL(url, completionHandler: {
            (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            if (error != nil) {
                callback(orcamentos:[], error: error)
            } else {
                let orcamentos = OrcamentoService.parserOrcamentos(data!)
                dispatch_sync(dispatch_get_main_queue(), {
                    callback(orcamentos:orcamentos, error: nil)
                })
            }
        })
        task.resume()
        
    }
}