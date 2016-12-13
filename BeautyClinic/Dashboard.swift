//
//  Dashboard.swift
//  BeautyClinic
//
//  Created by Arthur on 05/12/16.
//  Copyright © 2016 Matheus Nonaka. All rights reserved.
//

import UIKit

class Dashboard: UIViewController {
    
    
    @IBOutlet var btnMenu: UIBarButtonItem!
    @IBOutlet var viewMenu: UIViewController!
    
    @IBAction func funcMenu(sender: AnyObject) {
        print("Apertou menu")
        
    }
    
    @IBAction func funcMensagens(sender: AnyObject) {
        print("Chmando Mensagens")
        let mensagemView = MensagemViewController(nibName: "MensagemViewController", bundle: nil)
        //mensagemView.codCliente = "\(cliente.codCliente)"
        mensagemView.codCliente = "999999"
        self.navigationController!.pushViewController(mensagemView, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
