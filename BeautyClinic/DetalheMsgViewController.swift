//
//  DetalheMsgViewController.swift
//  BeautyClinic
//
//  Created by Matheus Nonaka on 9/14/15.
//  Copyright (c) 2015 Matheus Nonaka. All rights reserved.
//

import UIKit

class DetalheMsgViewController: UIViewController {
    
   
    
    var idMensagem: Int     = 0
    
    var titulo: String = ""
    var autor: String = ""
    var mensagem: String = ""
    
    @IBAction func apagarMensagem(codMensagem: Int) {
        MensagemService.apagarMensagem(idMensagem)
        self.navigationController!.popViewControllerAnimated(false)
    }
    
    @IBAction func fecharDetalhe() {
        self.navigationController!.popViewControllerAnimated(false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Detalhes da mensagem"
        /*
        self.tfTitulo.text = titulo
        self.tfAutor.text = autor
        self.tvMensagem.text = mensagem
        self.tvMensagem.editable = false
 */

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
