//
//  ReceivingViewController.swift
//  PassDataBetweenViewControllers
//
//  Created by JeongminKim on 2023/04/10.
//

import UIKit

class ReceivingViewController: UIViewController {
    
    private lazy var dataLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        label.text = "NO DATA"
        return label
    }()
    
    private lazy var popupButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Popup SendingVC", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(didTapPopupButton), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "ReceivingViewController"
        view.backgroundColor = .green
        setLayout()
    }
    
    private func setLayout() {
        view.addSubview(dataLabel)
        view.addSubview(popupButton)
        
        NSLayoutConstraint.activate([
            dataLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dataLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            popupButton.topAnchor.constraint(equalTo: dataLabel.bottomAnchor, constant: 25),
            popupButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            popupButton.widthAnchor.constraint(equalToConstant: 200),
            popupButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    @objc private func didTapPopupButton() {
        let sendingVC = SendingViewController()
        // MARK: !! SendingViewController에 선언된 delegate를 self(ReceivingViewController)로 설정합니다. !!
        sendingVC.delegate = self
        
        sendingVC.modalPresentationStyle = .pageSheet
        sendingVC.sheetPresentationController?.detents = [.medium()]
        sendingVC.sheetPresentationController?.prefersGrabberVisible = true
        present(sendingVC, animated: true)
    }
    
}

extension ReceivingViewController: DataDelegate { // DataDelegate를 implementation 해줍니다.
    /*
     - SendingViewController에서 delegate가 위임을 하면 해당 내용을 ReceivingViewController가 구현합니다.
     - 이 프로젝트에서는 SendingViewController.swift의
     delegate?.sendData(data: dataTextField.text ?? "Nothing left to say")
     함수가 호출되었을 때 입니다.
     */
    func sendData(data: String) {
        dataLabel.text = "Received data: \(data)"
    }
}
