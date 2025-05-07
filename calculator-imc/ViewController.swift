//
//  ViewController.swift
//  calculator-imc
//
//  Created by Maxwell Silva on 06/05/25.
//

import UIKit

class ViewController: UIViewController {
    
    var imc = 0.0
    
    lazy var logoImage: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "logo-app")
        logo.translatesAutoresizingMaskIntoConstraints = false
        return logo
    }()
    
    private lazy var pesoTextField: UITextField = {
        let peso = UITextField()
        peso.placeholder = "Digite seu peso em kg"
        peso.textAlignment = .center
        peso.borderStyle = .roundedRect
        peso.keyboardType = .numbersAndPunctuation
        peso.translatesAutoresizingMaskIntoConstraints = false
        return peso
    }()
    
    private lazy var alturaTextField: UITextField = {
        let altura = UITextField()
        altura.placeholder = "Digite sua altura em metros"
        altura.textAlignment = .center
        altura.borderStyle = .roundedRect
        altura.keyboardType = .numbersAndPunctuation
        altura.translatesAutoresizingMaskIntoConstraints = false
        return altura
    }()
    
    private lazy var resultadoButton: UIButton = {
        let button = UIButton()
        button.setTitle("Resultado", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitleColor(.lightGray, for: .highlighted)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var resultadoLabel: UILabel = {
        let resultado = UILabel()
        resultado.text = ""
        resultado.textAlignment = .center
        resultado.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 30)
        resultado.textColor = .systemBlue
        resultado.translatesAutoresizingMaskIntoConstraints = false
        return resultado
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Calculadora de IMC"
        setupLayout()
        selectButtonResult()
    }
    
    func selectButtonResult() {
        resultadoButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc func buttonTapped() {
        calcularImc()
    }
    
    func calcularImc() {
        if let pesoText = pesoTextField.text,
            let alturaText = alturaTextField.text,
            let peso = Double(pesoText),
            let altura = Double(alturaText) {
                imc = peso / (altura * altura)
                showResults()
        }
    }
    
    func showResults() {
        var result: String = ""
        switch imc {
            case 0..<16:
                result = "Magreza"
            case 16..<18.5:
                result = "Abaixo do peso"
            case 18.5..<25:
                result = "Peso ideal"
            case 25..<30:
                result = "Sobrepeso"
            default:
                result = "Obesidade"
        }
        resultadoLabel.text = "\(String(format: "%.1f", imc)) - \(result)"
    }
    
    func addComponents() {
        view.addSubview(logoImage)
        view.addSubview(pesoTextField)
        view.addSubview(alturaTextField)
        view.addSubview(resultadoButton)
        view.addSubview(resultadoLabel)
    }

    func setupLayout() {
        addComponents()
        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImage.heightAnchor.constraint(equalToConstant: 150),
            logoImage.widthAnchor.constraint(equalToConstant: 160),
            
            pesoTextField.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 40),
            pesoTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            pesoTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            alturaTextField.topAnchor.constraint(equalTo: pesoTextField.bottomAnchor, constant: 20),
            alturaTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            alturaTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            resultadoButton.topAnchor.constraint(equalTo: alturaTextField.bottomAnchor, constant: 20),
            resultadoButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            resultadoButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            resultadoLabel.topAnchor.constraint(equalTo: resultadoButton.bottomAnchor, constant: 20),
            resultadoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            resultadoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }

}

