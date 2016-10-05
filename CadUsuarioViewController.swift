//
//  CadUsuarioViewController.swift
//  BeautyClinic
//
//  Created by Matheus Nonaka on 6/29/16.
//  Copyright (c) 2016 Matheus Nonaka. All rights reserved.
//

import UIKit
//import DLRadioButton

class CadUsuarioViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var tfNome: UITextField!
    @IBOutlet var tfCPF: UITextField!
    @IBOutlet var tfSenha: UITextField!
    @IBOutlet var btCadastrar: UIButton!
    @IBOutlet var btCancelar: UIButton!
    @IBOutlet var progress: UIActivityIndicatorView!
    @IBOutlet var tfSenhaConfirmar: UITextField!
    
    @IBAction func cadastrar(sender: UIButton) {
        
        progress.startAnimating()

        CadastroService.doCadastro({(cliente: Cliente, error: NSError!) in
            if (error != nil) {
                dispatch_sync(dispatch_get_main_queue(), {
                    self.progress.stopAnimating()
                    if #available(iOS 8.0, *) {
                        Alerta.alerta("Falha no cadastro do usuário", mensagem: "Verifique os dados de cadastro e tente novamente", viewController: self)
                    } else {
                        // Fallback on earlier versions
                    }
                })
            } else {
                dispatch_sync(dispatch_get_main_queue(), {
                    self.progress.stopAnimating()
                    let principalViewController = PrincipalViewController(nibName: "PrincipalViewController",
                        bundle: nil)
                    principalViewController.cliente = Cliente()
                    principalViewController.cliente = cliente
                    self.navigationController!.pushViewController(principalViewController, animated: false)
                })
            }
            }, cpf: tfCPF.text!, nome: tfNome.text!, senha: tfSenha.text!, codFilial: 3)
    }
    
    @IBAction func sair(sender: UIButton) {
        self.navigationController?.popViewControllerAnimated(false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tfCPF.delegate = self
        self.tfNome.delegate = self
        self.tfSenha.delegate = self
        addAuxButtonsOnKeyboard()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addAuxButtonsOnKeyboard()
    {
        let doneToolbarNome: UIToolbar = UIToolbar(frame: CGRectMake(0, 0, 320, 50))
        doneToolbarNome.barStyle = UIBarStyle.Default
        
        let doneToolbarCPF: UIToolbar = UIToolbar(frame: CGRectMake(0, 0, 320, 50))
        doneToolbarCPF.barStyle = UIBarStyle.Default
        
        let doneToolbarSenha: UIToolbar = UIToolbar(frame: CGRectMake(0, 0, 320, 50))
        doneToolbarSenha.barStyle = UIBarStyle.Default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        
        let doneNome: UIBarButtonItem = UIBarButtonItem(title: "OK", style: UIBarButtonItemStyle.Done, target: self, action: #selector(CadUsuarioViewController.doneNomeAction))
        
        doneNome.setTitleTextAttributes([
            NSFontAttributeName: UIFont(name: "Avenir", size:20)!,
            NSForegroundColorAttributeName: UIColor.purpleColor()],
                                       forState: UIControlState.Normal)
        
        let doneSenha: UIBarButtonItem = UIBarButtonItem(title: "OK", style: UIBarButtonItemStyle.Done, target: self, action: #selector(CadUsuarioViewController.doneSenhaAction))
        
        doneSenha.setTitleTextAttributes([
            NSFontAttributeName: UIFont(name: "Avenir", size:20)!,
            NSForegroundColorAttributeName: UIColor.purpleColor()],
                                         forState: UIControlState.Normal)
        
        let doneCPF: UIBarButtonItem = UIBarButtonItem(title: "OK", style: UIBarButtonItemStyle.Done, target: self, action: #selector(CadUsuarioViewController.doneCPFAction))
        
        doneCPF.setTitleTextAttributes([
            NSFontAttributeName: UIFont(name: "Avenir", size:20)!,
            NSForegroundColorAttributeName: UIColor.purpleColor()],
                                       forState: UIControlState.Normal)
        
        let cancel: UIBarButtonItem = UIBarButtonItem(title: "Cancelar", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(CadUsuarioViewController.cancelAction))
        
        cancel.setTitleTextAttributes([
            NSFontAttributeName: UIFont(name: "Avenir", size:20)!,
            NSForegroundColorAttributeName: UIColor.purpleColor()],
                                      forState: UIControlState.Normal)
        
        doneToolbarNome.items = [flexSpace, doneNome, cancel]
        doneToolbarNome.sizeToFit()
        
        self.tfNome.inputAccessoryView = doneToolbarNome
        
        let cancel2: UIBarButtonItem = UIBarButtonItem(title: "Cancelar", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(CadUsuarioViewController.cancelAction))
        
        cancel2.setTitleTextAttributes([
            NSFontAttributeName: UIFont(name: "Avenir", size:20)!,
            NSForegroundColorAttributeName: UIColor.purpleColor()],
                                       forState: UIControlState.Normal)
        
        doneToolbarSenha.items = [flexSpace, doneSenha, cancel2]
        doneToolbarSenha.sizeToFit()
        self.tfSenha.inputAccessoryView = doneToolbarSenha
        
        let cancel3: UIBarButtonItem = UIBarButtonItem(title: "Cancelar", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(CadUsuarioViewController.cancelAction))
        
        cancel3.setTitleTextAttributes([
            NSFontAttributeName: UIFont(name: "Avenir", size:20)!,
            NSForegroundColorAttributeName: UIColor.purpleColor()],
                                       forState: UIControlState.Normal)
        
        doneToolbarCPF.items = [flexSpace, doneCPF, cancel3]
        doneToolbarCPF.sizeToFit()
        self.tfCPF.inputAccessoryView = doneToolbarCPF
        
    }
    
    func doneCPFAction()
    {
        self.tfCPF.resignFirstResponder()
    }
    
    func doneSenhaAction() {
        self.tfSenha.resignFirstResponder()
    }
    
    func doneNomeAction() {
        self.tfNome.resignFirstResponder()
    }
    
    func cancelAction() {
        self.tfCPF.resignFirstResponder()
        self.tfSenha.resignFirstResponder()
        self.tfNome.resignFirstResponder()
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        if (textField == tfCPF) {
            
            let strCpf = textField.text!.stringByReplacingOccurrencesOfString(".", withString: "", options:NSStringCompareOptions.LiteralSearch, range: nil)
            
            if (textField.text!.isEmpty) {
                return true
            }
            
            switch strCpf.characters.count {
            case 3,6:
                if (string != "") && (!textField.text!.hasSuffix(".")) {
                    textField.text = textField.text!+"."
                }
                return true
            case 9:
                if (string != "") && (!textField.text!.hasSuffix("-")){
                    textField.text = textField.text!+"-"
                }
                return true
            case 12:
                if (string != "") {
                    return false
                } else {
                    return true
                }
                
            default: true
            }
            return true
        } else {
            return true
        }
    }

}
