//
//  RandomCatAppTests.swift
//  RandomCatAppTests
//
//  Created by Hari Prasad Jana on 04/11/24.
//

import XCTest
@testable import RandomCatApp
final class RandomCatAppTests: XCTestCase {
    
    var presenter: RandomImagePresenter!
    var mockView: MockView!
    var mockInteractor: MockInteractor!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
       // super.setUpWithError()
        mockView = MockView()
        mockInteractor = MockInteractor()
        presenter = RandomImagePresenter()
        
        presenter.view = mockView
        presenter.interactor = mockInteractor
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        presenter = nil
        mockView = nil
        mockInteractor = nil
       // super.tearDownWithError()
        
    }
    func testLoadRandomContent() {
        presenter.loadRandomContent()
        XCTAssertTrue(mockInteractor.fetchRandomContentCalled, "Expected fetch")
    }
    
    func testDidFetchRandimImage() {
        let image = ImageModel(id: "12", url: "https://cdn2.thecatapi.com/images/MTkzMzI2MA.jpg", width: 100, height: 100)
        presenter.didFetchRandomImage(image)
        XCTAssertEqual(mockView.displayedImageUrl, image.url, "Expected displayImage to be called")
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
class MockView: RandomImageViewProtocol {
    func displayFact(_ fact: [String]) {
        displayedFact = fact[0]
    }
    
    var displayedImageUrl: String?
    var displayedFact: String?
   

    func displayImage(with url: String) {
        displayedImageUrl = url
    }
    
   
    
    
}
class MockInteractor: RandomImageInteractorProtocol {
    var fetchRandomContentCalled = false
    weak var presenter: RandomImageInteractorOutputProtocol?

    func fetchRandomContent() {
        fetchRandomContentCalled = true
    }
}
