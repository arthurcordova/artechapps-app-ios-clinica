//
//  AvisoService.swift
//  BeautyClinic
//
//  Created by Matheus Nonaka on 7/1/15.
//  Copyright (c) 2015 Matheus Nonaka. All rights reserved.
//

import Foundation

class AvisoService {

    class func getAvisos(codCliente: String) -> Aviso {
        
        //Teste com json local para verificacao das telas
        let file = "avisos"
        let path = NSBundle.mainBundle().pathForResource(file, ofType:"json")!
        let data = NSData(contentsOfFile: path)!
        let aviso = parserAvisos(data)
        return aviso
        
    }
    
    class func parserAvisos(data: NSData) -> Aviso {
        
        let aviso: Aviso = Aviso()
        do {
            let formatter = NSDateFormatter()
            formatter.dateFormat = "dd:MM"
            
            let dateString = formatter.stringFromDate(NSDate())
            aviso.dataAtual = "Bemvindo fulano, a data atual é \(dateString)"
            aviso.qtdMensagens = "Você não possui novas mensagens"
            aviso.qtdProcedimentos = "Você não possui agendamentos próximos"
            if (data.length > 0) {
                
                let dict: NSDictionary = try NSJSONSerialization.JSONObjectWithData(data, options:
                    NSJSONReadingOptions.MutableContainers) as! NSDictionary
                aviso.qtdMensagens = dict["qtdavisos"] as! String
                aviso.qtdProcedimentos = dict["qtdmensagens"] as! String
            }
        } catch let error as NSError {
            print("json error: \(error.localizedDescription)")
        }
        return aviso
        
    }
}
