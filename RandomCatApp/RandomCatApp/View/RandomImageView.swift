// RandomImageView.swift
import UIKit

protocol RandomImageViewProtocol: AnyObject {
    func displayImage(with url: String)
    func displayFact(_ fact: [String])
}

class RandomImageView: UIViewController, RandomImageViewProtocol {
    
    
    var presenter: RandomImagePresenterProtocol!
    private let imageView = UIImageView()
    private let factLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter.loadRandomContent()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapScreen))
        view.addGestureRecognizer(tapGesture)
    }

    private func setupUI() {
        view.backgroundColor = .white
        imageView.contentMode = .scaleAspectFit
        factLabel.numberOfLines = 0
        factLabel.textAlignment = .center

        view.addSubview(imageView)
        view.addSubview(factLabel)

        imageView.translatesAutoresizingMaskIntoConstraints = false
        factLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            imageView.widthAnchor.constraint(equalToConstant: 300),
            imageView.heightAnchor.constraint(equalToConstant: 300),
            
            factLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            factLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            factLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

    @objc private func didTapScreen() {
        presenter.loadRandomContent()
    }

    func displayImage(with url: String) {
        if let imageUrl = URL(string: url) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: imageUrl), let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.imageView.image = image
                    }
                }
            }
        }
    }
    
    func displayFact(_ fact: [String]) {
        DispatchQueue.main.async {
            self.factLabel.text = fact[0]
        }
    }
}

