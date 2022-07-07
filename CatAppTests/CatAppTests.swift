//
//  CatAppTests.swift
//  CatAppTests
//
//  Created by Serkan on 27.04.2022.
//

import XCTest

@testable import CatApp

class CatAppTests: XCTestCase {
    
    func testParsing() throws {
        let bundle = Bundle(for: CatAppTests.self)
        let url = bundle.url(forResource: "cats", withExtension: "json")
        let data = try Data(contentsOf: url!)
        let decoder = JSONDecoder()
        let cats = try decoder.decode(Cats.self, from: data)
        
        XCTAssertEqual(cats.name, "Abyssinian")
        XCTAssertEqual(cats.temperament, "Active, Energetic, Independent, Intelligent, Gentle")
        XCTAssertEqual(cats.description, "The Abyssinian is easy to care for, and a joy to have in your home. They’re affectionate cats and love both people and other animals.")
        XCTAssertEqual(cats.wikipediaUrl, "https://en.wikipedia.org/wiki/Abyssinian_(cat)")
        XCTAssertEqual(cats.image?.imageUrl, "https://cdn2.thecatapi.com/images/0XYvRd7oD.jpg")
    }
}
