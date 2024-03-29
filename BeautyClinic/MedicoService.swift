//
//  MedicoService.swift
//  BeautyClinic
//
//  Created by Matheus Nonaka on 7/14/16.
//  Copyright © 2016 Matheus Nonaka. All rights reserved.
//

import Foundation

class MedicoService {
    
    class func parserMedicos(data: NSData) -> Array<Mensagem> {
        do {
            if (data.length == 0) {
                return []
            }
            //Teste
            var mensagens: Array<Mensagem> = []
            let dict: NSArray = try NSJSONSerialization.JSONObjectWithData(data, options:
                NSJSONReadingOptions.MutableContainers) as! NSArray
            
            for obj:AnyObject in dict {
                let dict = obj as! NSDictionary
                let mensagem = Mensagem()
                mensagem.id = dict["id"] as! Int
                mensagem.titulo = dict["titulo"] as! String
                mensagem.autor = dict["autor"] as! String
                mensagem.tipoMensagem = dict["tipoMensagem"] as! String
                mensagem.dataEnvio = dict["dataEnvio"] as! String
                mensagem.visualizada = dict["visualizada"] as! Bool
                mensagem.idMsgCliente = dict["idMsgCliente"] as! Int
                mensagem.mensagem = dict["mensagem"] as! String
                mensagens.append(mensagem)
            }
            
            return mensagens
        } catch let error as NSError {
            print("json error: \(error.localizedDescription)")
            return []
        }
        
    }
    
    class func getMensagens(callback: (mensagens: Array<Mensagem>, error: NSError!) -> Void, codCliente: String) {
        
        let http = NSURLSession.sharedSession()
        let url = NSURL(string: "http://www2.beautyclinic.com.br/clinwebservice/servidor/msgsporcliente/1295")!
        let task = http.dataTaskWithURL(url, completionHandler: {
            (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            if (error != nil) {
                callback(mensagens:[], error: error)
            } else {
                let mensagens = MensagemService.parserMensagens(data!)
                dispatch_sync(dispatch_get_main_queue(), {
                    callback(mensagens:mensagens, error: nil)
                })
            }
        })
        task.resume()
        
    }
    
    class func apagarMensagem(idMensagem: Int) {
        
        let http = NSURLSession.sharedSession()
        let url = NSURL(string: "http://www2.beautyclinic.com.br/clinwebservice/servidor/excluirmsg/"+"\(idMensagem)")!
        let task = http.dataTaskWithURL(url)
        task.resume()
        
    }
    
}
