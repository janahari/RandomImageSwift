
//
// RandomImagePresenter.swift
//  RandomCatApp
//
//  Created by Hari Prasad Jana on 04/11/24.
//
import Foundation

protocol RandomImagePresenterProtocol: AnyObject {
    func loadRandomContent()
}

protocol RandomImageInteractorOutputProtocol: AnyObject {
    func didFetchRandomImage(_ image: ImageModel)
    func didFetchRandomFact(_ fact: CatFactResponse)
}

class RandomImagePresenter: RandomImagePresenterProtocol {
    weak var view: RandomImageViewProtocol?
    var interactor: RandomImageInteractorProtocol?
    var router: RandomImageRouterProtocol?

    func loadRandomContent() {
        interactor?.fetchRandomContent()
    }
}

extension RandomImagePresenter: RandomImageInteractorOutputProtocol {
    func didFetchRandomImage(_ image: ImageModel) {
        view?.displayImage(with: image.url)
    }
    
    func didFetchRandomFact(_ fact: CatFactResponse) {
        view?.displayFact(fact.data)
    }
}

