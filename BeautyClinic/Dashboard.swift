//
//  Dashboard.swift
//  BeautyClinic
//
//  Created by Arthur on 05/12/16.
//  Copyright © 2016 Matheus Nonaka. All rights reserved.
//

import UIKit

class Dashboard: UIViewController {
    
    var cliente: Cliente!
    
    @IBOutlet var btnMenu: UIBarButtonItem!
    @IBOutlet var viewMenu: UIViewController!
    
    @IBAction func funcMenu(sender: AnyObject) {
        print("Apertou menu")
        
    }
    
    @IBAction func funcMensagens(sender: AnyObject) {
        print("Chmando Mensagens")
        let mensagemView = MensagemViewController(nibName: "MensagemViewController", bundle: nil)
        mensagemView.codCliente = "\(cliente.codCliente)"
        self.navigationController!.pushViewController(mensagemView, animated: true)
    }
    
    @IBAction func funcAgendamentos(sender: AnyObject) {
        let agendaView = AgendaViewController(nibName: "AgendaViewController", bundle: nil)
        agendaView.cliente = self.cliente
        self.navigationController!.pushViewController(agendaView, animated: true)
    }
    
    @IBAction func funcProdutos(sender: AnyObject) {
        let produtoView = ProdutoViewController(nibName: "ProdutoViewController", bundle: nil)
        self.navigationController!.pushViewController(produtoView, animated: true)
    }
    
    @IBAction func funcBudget(sender: AnyObject) {
        let orcamentoView = OrcamentoViewController(nibName: "OrcamentoViewController", bundle: nil)
        orcamentoView.cliente = self.cliente
        self.navigationController!.pushViewController(orcamentoView, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = true
     
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBarHidden = true
        self.navigationItem.setHidesBackButton(true, animated:true);
        
    }
    
}
