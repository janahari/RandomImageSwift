

//
// RandomImageInteractor.swift
//  RandomCatApp
//
//  Created by Hari Prasad Jana on 04/11/24.
//
import Foundation

protocol RandomImageInteractorProtocol: AnyObject {
    func fetchRandomContent()
}

class RandomImageInteractor: RandomImageInteractorProtocol {
    weak var presenter: RandomImageInteractorOutputProtocol?
    var imageID: String = "0"
    func fetchRandomContent() {
        fetchRandomImage()
        fetchRandomFact()
    }
    
    private func fetchRandomImage() {
        guard let url = URL(string: "https://api.thecatapi.com/v1/images/search") else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let images = try JSONDecoder().decode([ImageModel].self, from: data)
                if let image = images.first {
                    self.imageID = image.id
                    self.presenter?.didFetchRandomImage(image)
                }
            } catch {
                print("Failed to decode image JSON:", error)
            }
        }.resume()
    }
    
    private func fetchRandomFact() {
        guard let url = URL(string: "https://meowfacts.herokuapp.com/?id=\(self.imageID)") else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let fact = try JSONDecoder().decode(CatFactResponse.self, from: data)
                self.presenter?.didFetchRandomFact(fact)
            } catch {
                print("Failed to decode fact JSON:", error)
            }
        }.resume()
    }
}

