//
//  ViewController.swift
//  calculator-imc
//
//  Created by Maxwell Silva on 06/05/25.
//

import UIKit

class ViewController: UIViewController {
    
    var imc = 0.0
    var peso: Float = 70.0
    var altura: Float = 1.75

    lazy var logoImage: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "logo-app")
        logo.translatesAutoresizingMaskIntoConstraints = false
        return logo
    }()
    
    private lazy var pesoLabel: UILabel = {
        let label = UILabel()
        label.text = "Peso: \(Int(peso)) kg"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var pesoSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 40
        slider.maximumValue = 150
        slider.value = peso
        slider.addTarget(self, action: #selector(pesoChanged), for: .valueChanged)
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    private lazy var alturaLabel: UILabel = {
        let label = UILabel()
        label.text = String(format: "Altura: %.2f m", altura)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var alturaSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 1.10
        slider.maximumValue = 2.30
        slider.value = altura
        slider.addTarget(self, action: #selector(alturaChanged), for: .valueChanged)
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    private lazy var resultadoButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 8
        button.backgroundColor = .systemBlue
        button.setTitle("Resultado", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.lightGray, for: .highlighted)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var resultadoLabel: UILabel = {
        let resultado = UILabel()
        resultado.text = ""
        resultado.textAlignment = .center
        resultado.translatesAutoresizingMaskIntoConstraints = false
        return resultado
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupLayout()
        selectButtonResult()
    }
    
    func selectButtonResult() {
        resultadoButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc func pesoChanged() {
        peso = pesoSlider.value
        pesoLabel.text = "Peso: \(Int(peso)) kg"
    }

    @objc func alturaChanged() {
        altura = alturaSlider.value
        alturaLabel.text = String(format: "Altura: %.2f m", altura)
    }

    @objc func buttonTapped() {
        calcularImc()
    }

    func calcularImc() {
        imc = Double(peso) / (Double(altura) * Double(altura))
        showResult()
    }

    func showResult() {
        var result = ""
        switch imc {
        case 0..<16:
            result = "Magreza"
        case 16..<18.5:
            result = "Abaixo do peso"
        case 18.5..<25:
            result = "Peso ideal"
        case 25..<30:
            result = "Sobre peso"
        default:
            result = "Obesidade"
        }
        
        resultadoLabel.text = "\(Int(imc)) - \(result)"
        view.endEditing(true)
    }

    func addComponents() {
        view.addSubview(logoImage)
        view.addSubview(pesoLabel)
        view.addSubview(pesoSlider)
        view.addSubview(alturaLabel)
        view.addSubview(alturaSlider)
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
            
            pesoLabel.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 40),
            pesoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            pesoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            pesoSlider.topAnchor.constraint(equalTo: pesoLabel.bottomAnchor, constant: 10),
            pesoSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            pesoSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            alturaLabel.topAnchor.constraint(equalTo: pesoSlider.bottomAnchor, constant: 30),
            alturaLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            alturaLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            alturaSlider.topAnchor.constraint(equalTo: alturaLabel.bottomAnchor, constant: 10),
            alturaSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            alturaSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            resultadoButton.topAnchor.constraint(equalTo: alturaSlider.bottomAnchor, constant: 30),
            resultadoButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            resultadoButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            resultadoLabel.topAnchor.constraint(equalTo: resultadoButton.bottomAnchor, constant: 20),
            resultadoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            resultadoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
}
