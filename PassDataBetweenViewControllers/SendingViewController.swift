//
//  ViewController.swift
//  PassDataBetweenViewControllers
//
//  Created by JeongminKim on 2023/04/10.
//

import UIKit

protocol DataDelegate: AnyObject {
    func sendData(data: String)
}

class SendingViewController: UIViewController {
    
    weak var delegate: DataDelegate?
    
    private lazy var dataTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.placeholder = "Input some data"
        return textField
    }()
    
    private lazy var sendButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Send Data", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(didTapSendButton), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "SendingViewController"
        view.backgroundColor = .systemYellow
        setLayout()
    }
    
    private func setLayout() {
        view.addSubview(dataTextField)
        view.addSubview(sendButton)
        
        NSLayoutConstraint.activate([
            dataTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dataTextField.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150),
            dataTextField.widthAnchor.constraint(equalToConstant: 200),
            dataTextField.heightAnchor.constraint(equalToConstant: 45),
        ])
        
        NSLayoutConstraint.activate([
            sendButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sendButton.topAnchor.constraint(equalTo: dataTextField.bottomAnchor, constant: 50),
            sendButton.widthAnchor.constraint(equalToConstant: 120),
            sendButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
        
    @objc private func didTapSendButton() {
        delegate?.sendData(data: dataTextField.text ?? "Nothing left to say")
        dismiss(animated: true)
    }
}

