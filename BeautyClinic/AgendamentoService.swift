//
//  AgendamentoService.swift
//  BeautyClinic
//
//  Created by Matheus Nonaka on 9/15/15.
//  Copyright (c) 2015 Matheus Nonaka. All rights reserved.
//

import Foundation

class AgendamentoService {
    
    var horarios: Array<Horario> = []

    class func parserHorarios(data: NSData) -> Array<Horario> {
        
        do {
            if (data.length == 0) {
                return []
            }
            
            var horarios: Array<Horario> = []
            let dict: NSArray = try NSJSONSerialization.JSONObjectWithData(data, options:
                NSJSONReadingOptions.MutableContainers) as! NSArray
            
            for obj:AnyObject in dict {
                let dict = obj as! NSDictionary
                let horario = Horario()
                horario.codSala = dict["codSala"] as! Int
                horario.horarioInicial = dict["horarioInicial"] as! String
                horario.intervaloMin = dict["intervaloMinutos"] as! Int
                horarios.append(horario)
            }
            
            return horarios
        } catch let error as NSError {
            print("json error: \(error.localizedDescription)")
            return []
        }
        
    }
    
    class func getHorarios(callback: (horarios: Array<Horario>, error: NSError!) -> Void, codProcedimento: Int, data: String) {
        
        let http = NSURLSession.sharedSession()
        let url = NSURL(string: "http://www2.beautyclinic.com.br/clinwebservice2/servidor/horarios/3/"+"\(codProcedimento)/"+data.stringByReplacingOccurrencesOfString("/", withString: "-"))!

        
        
        let task = http.dataTaskWithURL(url, completionHandler: {
            (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            if (error != nil) {
                callback(horarios:[], error: error)
            } else {
                let horarios = AgendamentoService.parserHorarios(data!)
                dispatch_sync(dispatch_get_main_queue(), {
                    callback(horarios:horarios, error: nil)
                })
            }
        })
        task.resume()
        
    }
    
    class func agendar(agendamento: Agendamento) {
        
        if let url = NSURL(string: "http://www2.beautyclinic.com.br/clinwebservice2/servidor/realizaragendamento") {
            
            let request = NSMutableURLRequest(URL: url)
            request.HTTPMethod = "POST"
            
            let dataAux = agendamento.data
            let params = ["codProcedimento":agendamento.codProcedimento,
                          "data":dataAux,
                          "horario":agendamento.horario,
                          "codCliente":agendamento.codCliente,
                          "codFilial":3
                ] as Dictionary<String, AnyObject>
            
            do {
                request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(params, options: [])
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                request.addValue("application/json", forHTTPHeaderField: "Accept")
            } catch let error as NSError {
                print("erro ao inicializar json: \(error.localizedDescription)")
            }
            
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
                data, response, error in
                
                let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
                
                if (jsonStr == "0") {
                    print("Agendamento realizado")
                }
                else if(jsonStr == "1") {
                    print("Erro ao realizar agendamento")
                } else if (jsonStr == "2") {
                    print("Horário ocupado")
                } else if (jsonStr == "3") {
                    print("Não atende no dia")
                }
            }
            task.resume()
        }

        
        /*let request = NSMutableURLRequest(URL: NSURL(string: "http://www2.beautyclinic.com.br/clinwebservice/servidor/realizaragendamento")!)
        let session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        
        let err: NSError?
        let dataAux = agendamento.data
        
        let params = ["codProcedimento":agendamento.codProcedimento,
            "data":dataAux,
            "horario":agendamento.horario,
            "codCliente":agendamento.codCliente,
            "codFilial":2
            ] as Dictionary<String, AnyObject>
        do {
        request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(params, options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        /*let task = session.dataTaskWithRequest(request, completionHandler: {
            (data, response, error) -> Void in
            do {
            var strData = NSString(data: data!, encoding: NSUTF8StringEncoding)
            var json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as? NSDictionary
            
            if(err != nil) {
                print(err!.localizedDescription)
            }
            else {
                print("Agendamento efetuado com sucesso")
            }
                
            } catch let error as NSError {
                print("erro ao agendar: \(error.localizedDescription)")
            }*/

        })
        task.resume()
            
        } catch let error as NSError {
            print("erro ao agendar: \(error.localizedDescription)")
        }*/
    }
}