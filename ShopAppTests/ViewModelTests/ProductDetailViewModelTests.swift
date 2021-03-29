//
//  ProductDetailViewModelTests.swift
//  ShopAppTests
//
//  Created by Andres Felipe Rojas R. on 29/03/21.
//

import XCTest
@testable import ShopApp

class ProductDetailViewModelTests: XCTestCase {

    var sut: ProductDetailViewModelProtocol!

    override func setUpWithError() throws {
        sut = ProductDetailViewModel(productId: "", service: MockItemService())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testProductDetailsFromViewModel() throws {

        let expectation = XCTestExpectation(description: "Wait for the ViewModel to update the animation status")
        let titleExpectation = XCTestExpectation(description: "Wait for the ViewModel to load title")
        let galleryExpectation = XCTestExpectation(description: "Wait for the ViewModel to load gallery")
        let descriptionExpectation = XCTestExpectation(description: "Wait for the ViewModel to load description")

        sut.animation.bind { animation in

            if animation != nil {

                expectation.fulfill()
            }
        }

        sut.title.bind { title in

            if title != nil {

                titleExpectation.fulfill()
            }
        }

        sut.gallery.bind { gallery in

            if gallery != nil {

                galleryExpectation.fulfill()
            }
        }

        sut.details.bind { details in

            if details != nil {

                descriptionExpectation.fulfill()
            }
        }

        sut.getItem()

        wait(for: [expectation, titleExpectation, galleryExpectation, descriptionExpectation], timeout: 2)

        XCTAssertNil(sut.animation.value)
    }

}
