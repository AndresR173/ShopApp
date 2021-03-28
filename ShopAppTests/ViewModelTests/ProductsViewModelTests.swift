//
//  ProductsViewModelTests.swift
//  ShopAppTests
//
//  Created by Andres Felipe Rojas R. on 28/03/21.
//

import XCTest
@testable import ShopApp

class ProductsViewModelTests: XCTestCase {

    var sut: ProductsViewModelProtocol!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoadingAnimationShown() {

        sut = ProductsViewModel(service: MockApi())

        let expectation = XCTestExpectation(description: "Wait for the ViewModel to update the animation status")

        sut.animation.bind { animation in
            if animation != nil {
                expectation.fulfill()
            }
        }

        sut.search(for: "")

        wait(for: [expectation], timeout: 2)
    }

}
