//
//  Mensagem.swift
//  BeautyClinic
//
//  Created by Matheus Nonaka on 6/20/15.
//  Copyright (c) 2015 Matheus Nonaka. All rights reserved.
//

import Foundation
import UIKit

@available(iOS 8.0, *)
class Alerta {
    
    class func alerta(titulo: String, mensagem: String, viewController: UIViewController) {
        let alert = UIAlertController(title: titulo, message: mensagem,
            preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler:nil))
        viewController.presentViewController(alert, animated: true, completion: nil)
    }
    
}