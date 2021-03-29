//
//  ProductsViewModelTests.swift
//  ShopAppTests
//
//  Created by Andres Felipe Rojas R. on 28/03/21.
//

import XCTest
@testable import ShopApp

class ProductsViewModelTests: XCTestCase {

    var sutNoError: ProductsViewModelProtocol!
    var sutError: ProductsViewModelProtocol!

    override func setUpWithError() throws {

        sutNoError = ProductsViewModel(service: MockApi())
        sutError = ProductsViewModel(service: MockErrorApi())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoadingAnimationShown() {

        let expectation = XCTestExpectation(description: "Wait for the ViewModel to update the animation status")

        sutNoError.animation.bind { animation in
            if animation != nil {
                expectation.fulfill()
            }
        }

        sutNoError.search(for: "")

        wait(for: [expectation], timeout: 2)
    }

    func testGetCategoriesFromApi() {

        let expectation = XCTestExpectation(description: "Wait for the ViewModel to update category list")

        sutNoError.elements.bind { elements in

            if elements != nil {
                expectation.fulfill()
            }
        }

        sutNoError.search(for: "")

        wait(for: [expectation], timeout: 2)
        XCTAssertNil(sutNoError.animation.value)
    }

    func testGetProductsFromApi() {

        let listExpectation = XCTestExpectation(description: "Wait for the ViewModel to update product list")
        let animationExpectation = XCTestExpectation(description: "Wait for the ViewModel to load an animation")

        sutNoError.animation.bind { animation in

            if animation != nil {

                animationExpectation.fulfill()
            }
        }

        sutNoError.elements.bind { elements in

            if elements != nil {
                listExpectation.fulfill()
            }
        }

        sutNoError.search(for: "")

        wait(for: [listExpectation, animationExpectation], timeout: 2)
        XCTAssertNil(sutNoError.animation.value)

        let currentList = sutNoError.elements.value?.count
        XCTAssertNotNil(currentList)

        sutNoError.loadMore()

        XCTAssertNil(sutNoError.animation.value)

        let newList = sutNoError.elements.value?.count
        XCTAssertNotNil(newList)

        XCTAssertGreaterThan(newList ?? 0, currentList ?? 0)
    }

    func testGetProductsByCategory() {

        let listExpectation = XCTestExpectation(description: "Wait for the ViewModel to update product list")
        let animationExpectation = XCTestExpectation(description: "Wait for the ViewModel to load an animation")

        sutNoError.elements.bind { elements in

            if elements != nil {
                listExpectation.fulfill()
            }
        }

        sutNoError.animation.bind { animation in

            if animation != nil {

                animationExpectation.fulfill()
            }
        }

        sutNoError.getCategories()

        wait(for: [listExpectation], timeout: 2)

        XCTAssert(sutNoError.elements.value is [ProductCategory])

        sutNoError.didSelectItem(at: IndexPath(row: 0, section: 0))

        wait(for: [animationExpectation], timeout: 2)

        XCTAssert(sutNoError.elements.value is [Product])

        let currentElements = sutNoError.elements.value?.count
        XCTAssertNotNil(currentElements)

        sutNoError.loadMore()

        let newElements = sutNoError.elements.value?.count
        XCTAssertNotNil(newElements)

        XCTAssertGreaterThan(newElements ?? 0 , currentElements ?? 0)
    }

    func testProductDetailFromViewModel() {

        // swiftlint:disable:next line_length
        let viewModelExpectation = XCTestExpectation(description: "Wait for the ViewModel to load the product detail View Controller")

        sutNoError.productDetail.bind { viewController in

            if viewController != nil {

                viewModelExpectation.fulfill()
            }
        }

        sutNoError.search(for: "")
        sutNoError.didSelectItem(at: IndexPath(row: 0, section: 0))

        wait(for: [viewModelExpectation], timeout: 2)

    }

    func testGetCategoriesError() {

        let animationExpectation = XCTestExpectation(description: "Wait for the ViewModel to load an animation")

        sutError.animation.bind { animation in

            if animation != nil {

                animationExpectation.fulfill()
            }
        }

        sutError.getCategories()

        wait(for: [animationExpectation], timeout: 2)

        XCTAssertNil(sutError.elements.value)
        XCTAssertEqual(sutError.animation.value?.animation, Constants.Animations.error)

    }

    func testGetSearchProductError() {

        let animationExpectation = XCTestExpectation(description: "Wait for the ViewModel to load an animation")

        sutError.animation.bind { animation in

            if animation != nil {

                animationExpectation.fulfill()
            }
        }

        sutError.search(for: "")

        wait(for: [animationExpectation], timeout: 2)

        XCTAssertNil(sutError.elements.value)
        XCTAssertEqual(sutError.animation.value?.animation, Constants.Animations.error)

    }

}
