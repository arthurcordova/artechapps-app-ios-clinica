//
//  LoginViewController.swift
//  BeautyClinic
//
//  Created by Matheus Nonaka on 6/15/15.
//  Copyright (c) 2015 Matheus Nonaka. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    var agendamentos: Array<Agendamento> = []
    
    @IBOutlet var imgCentral: UIImageView!
    @IBOutlet var strCpf: UITextField!
    @IBOutlet var strSenha: UITextField!
    @IBOutlet var btnLogin: UIButton!
    @IBOutlet var btnCadastrar: UIButton!
    @IBOutlet var progress: UIActivityIndicatorView!
    
    @IBAction func fazerLogin(sender: UIButton) {
        
        progress.startAnimating()
        btnLogin.hidden = true
        
        var cpfCnpjAux = self.strCpf.text!.stringByReplacingOccurrencesOfString(".", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)

        cpfCnpjAux = cpfCnpjAux.stringByReplacingOccurrencesOfString("-", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)

        
        LoginService.doLogin({(cliente: Cliente) in
            if (cliente.nome == "Erro") {
                dispatch_sync(dispatch_get_main_queue(), {
                    self.progress.stopAnimating()
                    if #available(iOS 8.0, *) {
                        Alerta.alerta("Falha no acesso", mensagem: "Verifique seus dados de login e tente novamente", viewController: self)
                        self.btnLogin.hidden = false
                    } else {
                        // Fallback on earlier versions
                    }
                })
            } else {
                dispatch_sync(dispatch_get_main_queue(), {
                    self.progress.stopAnimating()
                    
                    let principalViewController = ControllerMain(nibName: "PrincipalView",
                        bundle: nil)
                    principalViewController.cliente = Cliente()
                    principalViewController.cliente = cliente
                    self.navigationController!.pushViewController(principalViewController, animated: false)
                })
            }
            }, cpfCnpj: cpfCnpjAux, senha: self.strSenha.text!)
    }
    
    @IBAction func cadastrar(sender: UIButton) {
        let cadUsuarioViewController = CadUsuarioViewController(nibName: "CadUsuarioViewController", bundle: nil)
        self.navigationController!.pushViewController(cadUsuarioViewController, animated: false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.strCpf.delegate = self
        self.strSenha.delegate = self
        self.addAuxButtonsOnKeyboard()
        var codigo = 0
        let defaults = NSUserDefaults.standardUserDefaults()
        codigo = defaults.integerForKey("codigo")
        if (codigo > 0){
            let principalViewController = ControllerMain(nibName: "PrincipalView",
                                                         bundle: nil)
            let cliente: Cliente = Cliente()
            cliente.codCliente = codigo
            cliente.nome = defaults.objectForKey("nome") as! String
            
            principalViewController.cliente = Cliente()
            principalViewController.cliente = cliente
            self.navigationController!.pushViewController(principalViewController, animated: false)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if (textField == strCpf) {
            //strSenha.becomeFirstResponder()
            textField.resignFirstResponder()
            return true
        } else if (textField == strSenha) {
            self.fazerLogin(btnLogin!)
            return true
        }
        return false
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        if (textField == strCpf) {
            
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
    
    func addAuxButtonsOnKeyboard()
    {
//        let doneToolbarCpf: UIToolbar = UIToolbar(frame: CGRectMake(0, 0, 320, 50))
//        doneToolbarCpf.barStyle = UIBarStyle.Default
//        
//        let doneToolbarSenha: UIToolbar = UIToolbar(frame: CGRectMake(0, 0, 320, 50))
//        doneToolbarSenha.barStyle = UIBarStyle.Default
//        
//        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
//        
//        let doneCPF: UIBarButtonItem = UIBarButtonItem(title: "OK", style: UIBarButtonItemStyle.Done, target: self, action: #selector(LoginViewController.doneCPFAction))
//    
//        doneCPF.setTitleTextAttributes([
//            NSFontAttributeName: UIFont(name: "Avenir", size:20)!,
//            NSForegroundColorAttributeName: UIColor.purpleColor()],
//                               forState: UIControlState.Normal)
//        
//        let doneSenha: UIBarButtonItem = UIBarButtonItem(title: "OK", style: UIBarButtonItemStyle.Done, target: self, action: #selector(LoginViewController.doneSenhaAction))
//        
//        doneSenha.setTitleTextAttributes([
//            NSFontAttributeName: UIFont(name: "Avenir", size:20)!,
//            NSForegroundColorAttributeName: UIColor.purpleColor()],
//                                    forState: UIControlState.Normal)
//        
//        let cancel: UIBarButtonItem = UIBarButtonItem(title: "Cancelar", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(LoginViewController.cancelAction))
//        
//        cancel.setTitleTextAttributes([
//            NSFontAttributeName: UIFont(name: "Avenir", size:20)!,
//            NSForegroundColorAttributeName: UIColor.purpleColor()],
//                                         forState: UIControlState.Normal)
//        
//        doneToolbarCpf.items = [flexSpace, doneCPF, cancel]
//        doneToolbarCpf.sizeToFit()
//        
//        self.strCpf.inputAccessoryView = doneToolbarCpf
//        
//        let cancel2: UIBarButtonItem = UIBarButtonItem(title: "Cancelar", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(LoginViewController.cancelAction))
//        
//        cancel2.setTitleTextAttributes([
//            NSFontAttributeName: UIFont(name: "Avenir", size:20)!,
//            NSForegroundColorAttributeName: UIColor.purpleColor()],
//                                      forState: UIControlState.Normal)
//        
//        doneToolbarSenha.items = [flexSpace, doneSenha, cancel2]
//        doneToolbarSenha.sizeToFit()
//        self.strSenha.inputAccessoryView = doneToolbarSenha
        //1431993
        
    }
    
    func doneCPFAction()
    {
        self.strCpf.resignFirstResponder()
        //self.strSenha.becomeFirstResponder()
    }
    
    func doneSenhaAction() {
        if (self.strCpf.text?.characters.count > 0) {
            self.fazerLogin(btnLogin)
        } else {
            self.strSenha.resignFirstResponder()
            //self.strCpf.becomeFirstResponder()
            if #available(iOS 8.0, *) {
                Alerta.alerta("Atenção", mensagem: "Informe o CPF do usuário.", viewController: self)
            }
        }
    }
    
    func cancelAction() {
        self.strCpf.resignFirstResponder()
        self.strSenha.resignFirstResponder()
    }
}
