//
//  CoreDataTests.swift
//  FilmStarSwiftUITests
//
//  Created by Jakub Gawecki on 05/12/2021.
//

import XCTest

class CoreDataTests: XCTestCase {

    func testConvertingFilmToDataSucceeds() {
        do {
            let sut = try JSONEncoder().encode(FilmMock.gogv2)
            XCTAssertNotNil(sut)
        } catch {
            XCTFail()
        }
    }
    
    func testConvertingAndUncovertingFilmSucceeds() {
        do {
            let data = try JSONEncoder().encode(FilmMock.gogv2)
            let sut = try JSONDecoder().decode(FilmMock.self, from: data)
            
            XCTAssertEqual(sut.title, FilmMock.gogv2.title)
        } catch {
            XCTFail()
        }
    }

}
