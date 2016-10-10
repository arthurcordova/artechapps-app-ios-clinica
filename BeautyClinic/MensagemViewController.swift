//
//  MensagemViewController.swift
//  BeautyClinic
//
//  Created by Matheus Nonaka on 9/14/15.
//  Copyright (c) 2015 Matheus Nonaka. All rights reserved.
//

import UIKit

class MensagemViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    var mensagens: Array<Mensagem> = []
    var codCliente: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Mensagens"
        self.navigationController!.setNavigationBarHidden(false, animated: false)
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        let xib = UINib(nibName: "MensagemCell", bundle: nil)
        self.tableView.registerNib(xib, forCellReuseIdentifier: "cell")
        
        getMensagens(codCliente)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_animated: Bool) {
        super.viewWillAppear(_animated)
        self.title = "Mensagens"
        getMensagens(codCliente)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mensagens.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
        -> UITableViewCell {

            let cell = self.tableView.dequeueReusableCellWithIdentifier("cell") as! MensagemCell
            let linha = indexPath.row
            let mensagem = self.mensagens[linha]
            
            cell.id = mensagem.id
            cell.data.text = "Data: \(mensagem.dataEnvio)"
            cell.titulo.text = "Título: \(mensagem.titulo)"
            cell.mensagem = mensagem.mensagem
            
            return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let linha = indexPath.row
        let mensagem = self.mensagens[linha]
        
        let detalheView = DetalheMsgViewController(nibName: "DetalheMsgViewController", bundle: nil)
        detalheView.idMensagem = mensagem.idMsgCliente
        detalheView.autor = mensagem.autor
        detalheView.titulo = mensagem.titulo
        detalheView.mensagem = mensagem.mensagem
        
        self.navigationItem.title = ""
        self.navigationController!.pushViewController(detalheView, animated: true)
        
    }
    
    func getMensagens(codCliente: String) {
        
        MensagemService.getMensagens({(mensagens: Array<Mensagem>, error: NSError!) in
            if (error != nil) {
                if #available(iOS 8.0, *) {
                    Alerta.alerta("Erro", mensagem: "erro", viewController: self)
                } else {
                    // Fallback on earlier versions
                }
            } else {
                self.mensagens = mensagens
                self.tableView.reloadData()
                
            }
            }, codCliente: codCliente)
        
    }

}
