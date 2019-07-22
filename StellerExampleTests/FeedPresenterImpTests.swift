//
//  FeedPresenterImpTests.swift
//  StellerExampleTests
//
//  Created by Jakub Dohnal on 22/07/2019.
//  Copyright © 2019 Jakub Dohnal. All rights reserved.
//

import XCTest
@testable import StellerExample

class FakeFeedInteractor: FeedInteractor {

    private var result: Result<StoriesResponse>!

    func setErrorCompletion(error: Error) {
        result = Result.error(error)
    }

    func setValueCompletion(value: StoriesResponse) {
        result = Result.value(value)
    }

    func getStories(completion: @escaping (Result<StoriesResponse>) -> Void) {
        completion(result)
    }
}

class FakeFeedPresenterDelegate: FeedPresenterDelegate {

    var completion: ((_ didLoad: Bool, _ didFailed: Bool) -> Void)?

    func feedDidLoad() {
        let didLoad = true
        let didFailed = false

        completion?(didLoad, didFailed)
    }

    func feedLoadFailed(errorMessage: String) {
        let didLoad = false
        let didFailed = true

        completion?(didLoad, didFailed)
    }
}

class FeedPresenterImpTests: XCTestCase {

    // Tested object
    var feedPresenter: FeedPresenterImp!

    // Injected objects
    var interactor: FakeFeedInteractor!
    var delegate: FakeFeedPresenterDelegate!

    override func setUp() {
        delegate = FakeFeedPresenterDelegate()
        interactor = FakeFeedInteractor()
        feedPresenter = FeedPresenterImp(interactor: interactor)

        feedPresenter.delegate = delegate
    }

    func testSuccessStoriesLoad() {
        let input = StoriesResponse(stories: [StoryResponse(coverSrc: "", aspectRatio: "")])

        let expectation = self.expectation(description: "FeedPresenterImp delegate async. on main thread then FakeFeedPresenterDelegate completion closure run on main thread.")

        delegate.completion = { didLoad, didFailed in
            XCTAssertTrue(didLoad)
            XCTAssertFalse(didFailed)
            expectation.fulfill()
        }

        interactor.setValueCompletion(value: input)
        feedPresenter.reload()


        waitForExpectations(timeout: 2) { error in
            if let error = error {
            XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }

    func testFailedStoriesLoad() {
        let input = NSError(domain: "", code: 0)

        let expectation = self.expectation(description: "FeedPresenterImp delegate async. on main thread then FakeFeedPresenterDelegate completion closure run on main thread.")

        delegate.completion = { didLoad, didFailed in
            XCTAssertFalse(didLoad)
            XCTAssertTrue(didFailed)

            expectation.fulfill()
        }

        interactor.setErrorCompletion(error: input)
        feedPresenter.reload()

        waitForExpectations(timeout: 2) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
}
