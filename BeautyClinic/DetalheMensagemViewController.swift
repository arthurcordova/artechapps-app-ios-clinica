//
//  DetalheMensagemViewController.swift
//  BeautyClinic
//
//  Created by Arthur on 21/11/16.
//  Copyright © 2016 Arthur Cordova. All rights reserved.
//

import UIKit

class DetalheMensagemViewController: UIViewController {

    @IBOutlet var lbTitulo: UILabel!
    @IBOutlet var lbMensagem: UITextView!
    @IBOutlet var lbData: UILabel!
    
    @IBAction func apagar(sender: UIBarButtonItem) {
        MensagemService.apagarMensagem(self.codigo!)
        self.navigationController!.popViewControllerAnimated(false)
    }
       
    var codigo: Int?
    var titulo: String?
    var mensagem: String?
    var data: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lbTitulo.text = self.titulo
        lbMensagem.text = self.mensagem
        lbData.text = self.data
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_animated: Bool) {
        super.viewWillAppear(_animated)
        self.navigationController?.navigationBar.backItem?.title = " "
        self.tabBarController?.navigationItem.hidesBackButton = true
        self.title = "Detalhes"
    }

    
       

   
}
