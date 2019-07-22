//
//  FeedInteractorImpTests.swift
//  StellerExampleTests
//
//  Created by Jakub Dohnal on 16/07/2019.
//  Copyright © 2019 Jakub Dohnal. All rights reserved.
//

import XCTest
@testable import StellerExample

class FakeNetworkService: NetworkService {

    private var result: Result<StoriesResponse>!

    func setErrorCompletion(error: Error) {
        result = Result.error(error)
    }

    func setValueCompletion(value: StoriesResponse) {
        result = Result.value(value)
    }

    func fetch<Value>(request: Request, completion: @escaping (Result<Value>) -> Void) where Value : Decodable, Value : Encodable {
        guard Value.self == StoriesResponse.self else { return }

        completion(result as! Result<Value>)
    }
}

extension StoriesResponse: Equatable {
    public static func == (lhs: StoriesResponse, rhs: StoriesResponse) -> Bool {
        return lhs.stories == rhs.stories
    }
}

extension StoryResponse: Equatable {
    public static func == (lhs: StoryResponse, rhs: StoryResponse) -> Bool {
        return lhs.aspectRatio == rhs.aspectRatio
            && lhs.coverSrc == rhs.coverSrc
    }
}

class FeedInteractorImpTests: XCTestCase {

    // Tested object
    var feedinteractor: FeedInteractorImp!

    // Injected object
    var service: FakeNetworkService!

    override func setUp() {
        service = FakeNetworkService()
        feedinteractor = FeedInteractorImp(service: service)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSuccessResult() {
        let input = StoriesResponse(stories: [StoryResponse(coverSrc: "", aspectRatio: "")])
        let expectedOutput = input

        service.setValueCompletion(value: input)
        feedinteractor.getStories { result in
            switch result {
            case .value(let value):
                XCTAssertEqual(expectedOutput, value)
            case .error(let error):
                XCTFail("Get Stories should not failed with error: \(error)")
            }
        }
    }

    func testFailedResult() {
        let input = NSError.init(domain: "", code: 000, userInfo: [:])
        let expectedOutput = input

        service.setErrorCompletion(error: input)
        feedinteractor.getStories { result in
            switch result {
            case .value(let value):
                XCTFail("Get Stories should not success with: \(value)")
            case .error(let error):
                let error = error as NSError
                XCTAssertEqual(expectedOutput, error)
            }
        }
    }
}
