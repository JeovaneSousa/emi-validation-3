//
//  ViewController.swift
//  LearningTask-4.4
//
//  Created by rafael.rollo on 15/02/2022.
//

import UIKit

class FormViewController: UIViewController {

    @IBOutlet weak var nomeTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var areaAtuacaoTextField: UITextField!
    @IBOutlet weak var statusProfissionalTextField: UITextField!
    
    typealias ValidationMessage = String
    typealias AlertTitle = String
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func botaoSubmissaoPressionado(_ sender: UIButton) {
        switch checarFormularios() {
        case (false, let alertTitle, let validationMessage):
            exibirAlerta(withTitle: alertTitle, andMessage: validationMessage)
        default:
            exibeAlertaDeRevisao()
        }
        
    }
    
    func exibeAlertaDeRevisao() {
        let mensagem = """
            Antes de enviarmos, por favor, revise seus dados:
        
            Nome: \(nomeTextField.text!)
            Email: \(emailTextField.text!)
            Área de Atuação: \(areaAtuacaoTextField.text!)
            Status Profissional: \(statusProfissionalTextField.text!)
        """
        
        let alert = UIAlertController(title: "Quase lá!", message: mensagem, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Confirmar", style: .default, handler: acaoDeConfirmacaoDisparada))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func acaoDeConfirmacaoDisparada(_ action: UIAlertAction) {
        exibirAlerta(withTitle: "Feito!", andMessage: "Verifique seu email e tenha acesso ao documento")
    }
    

    func checarFormularios() -> (Bool, AlertTitle?, ValidationMessage?){
        if let nome = nomeTextField.text, nome.isEmpty{
            return (false, "Quase lá", "Nome não pode estar em branco")
        }
        guard let email = emailTextField.text, !email.isEmpty else{
            return(false, "Quase lá", "Email não pode estar em branco")
        }
        if !validarEmail(email){
            return (false, "Quase lá", "O email informado é invalido")
        }
        if let areaDeAtuacao = areaAtuacaoTextField.text, areaDeAtuacao.isEmpty{
            return (false, "Quase lá", "Informe sua área de atuação")
        }
        if let status = statusProfissionalTextField.text, status.isEmpty {
            return (false, "Quase lá", "Informe seu status profissional")
        }
        return (true, nil, nil)
    }
    
    func validarEmail(_ email:String) -> Bool{
        let padrao = #"^\S+@\S+\.\S+$"#
        return NSPredicate(format: "SELF MATCHES %@", padrao).evaluate(with: email)
        
    }
    
    func exibirAlerta(withTitle alertTitle:AlertTitle?, andMessage validationMessage:ValidationMessage?){
        let alertTitle = alertTitle ?? "Quase lá"
        let validationMessage = validationMessage ?? "Verifique seus dados e tente novamente"
        
        let alert = UIAlertController(title: alertTitle, message: validationMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alert, animated: true)
    }

}

