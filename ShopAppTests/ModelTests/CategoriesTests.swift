//
//  CategoriesTest.swift
//  ShopAppTests
//
//  Created by Andres Felipe Rojas R. on 28/03/21.
//

import XCTest
@testable import ShopApp

class CategoriesTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCategoryModel() throws {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "categories_response", withExtension: "json") else {
            XCTFail("Could not find response json")
            return
        }
        guard let data = try? Data(contentsOf: url) else {
            XCTFail("Could not get data from URL")
            return
        }
        let categories = try? JSONDecoder().decode([ProductCategory].self, from: data)
        XCTAssertNotNil(categories)
    }

}
