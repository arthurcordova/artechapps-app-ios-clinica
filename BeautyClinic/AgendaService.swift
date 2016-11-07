//
//  LoginService.swift
//  BeautyClinic
//
//  Created by Matheus Nonaka on 6/15/15.
//  Copyright (c) 2015 Matheus Nonaka. All rights reserved.
//

import Foundation

class AgendaService {
    
    class func getAgendamentos(callback: (agendamentos: Array<Agendamento>, error: NSError!) -> Void, codCliente: String) {
        
        let http = NSURLSession.sharedSession()
        let url = NSURL(string: "http://www2.beautyclinic.com.br/clinwebservice2/servidor/agendamentos/"+codCliente)!
        let task = http.dataTaskWithURL(url, completionHandler: {
            (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            if (error != nil) {
                callback(agendamentos:[], error: error)
            } else {
                let agendamentos = AgendaService.parserAgendamentos(data!)
                dispatch_sync(dispatch_get_main_queue(), {
                    callback(agendamentos:agendamentos, error: nil)
                })
            }
        })
        task.resume()
        
    }
    
    class func parserAgendamentos(data: NSData) -> Array<Agendamento> {
        
        if (data.length == 0) {
            return []
        }
        
        var agendamentos: Array<Agendamento> = []
        do {
            let dict: NSArray = try NSJSONSerialization.JSONObjectWithData(data, options:
                NSJSONReadingOptions.MutableContainers) as! NSArray
            
            for obj:AnyObject in dict {
                let dict = obj as! NSDictionary
                let agendamento = Agendamento()
                agendamento.codProcedimento = dict["codProcedimento"] as! Int
                agendamento.descProcedimento = dict["descProcedimento"] as! String
                agendamento.data = dict["data"] as! String
                agendamento.horario = dict["horario"] as! String
                agendamento.status = dict["status"] as! String
                agendamento.codAgenda = dict["codAgenda"] as! Int
                agendamentos.append(agendamento)
            }
        } catch let error as NSError {
            print("json error: \(error.localizedDescription)")
        }
        
        return agendamentos
    }
    
}
