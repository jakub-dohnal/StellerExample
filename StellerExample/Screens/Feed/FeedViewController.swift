//
//  FeedViewController.swift
//  StellerExample
//
//  Created by Jakub Dohnal on 16/07/2019.
//  Copyright © 2019 Jakub Dohnal. All rights reserved.
//

import UIKit

class FeedViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    let service: FeedService

    var storiesViewModels: [StoryViewModel] = [] {
        didSet {
            collectionView.reloadData()
        }
    }

    let space: CGFloat = 20

    init(service: FeedService) {
        self.service = service

        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = space
        layout.minimumLineSpacing = space
        layout.sectionInset = UIEdgeInsets(top: space, left: space, bottom: space, right: space)

        super.init(collectionViewLayout: layout)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        loadCells([FeedCell.self])
        collectionView?.backgroundColor = .white
        loadData()
    }

    func loadData() {
        service.getStories { [weak self] result in
            switch result {
            case .value(let response):
                let storiesViewModels = response.stories.compactMap { story -> StoryViewModel? in
                    guard let url = URL(string: story.coverSrc) else { return nil }
                    return StoryViewModel(coverURL: url)
                }
                self?.updateViewMode(storiesViewModels)
            case .error(let error):
                // TODO: Handle error
                break
            }
        }
    }

    private func updateViewMode(_ viewModel: [StoryViewModel]) {
        DispatchQueue.main.async { [weak self] in
            self?.storiesViewModels = viewModel
        }
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return storiesViewModels.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(FeedCell.self, for: indexPath)
    
        // Configure the cell
        cell.config(viewModel: storiesViewModels[indexPath.row])
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
}

extension FeedViewController {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfColumns: CGFloat = 2
        let width = (collectionView.bounds.width - space * (numberOfColumns + 1)) / numberOfColumns
        return CGSize(width: width, height: width)
    }
}
