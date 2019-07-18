//
//  FeedViewController.swift
//  StellerExample
//
//  Created by Jakub Dohnal on 16/07/2019.
//  Copyright © 2019 Jakub Dohnal. All rights reserved.
//

import UIKit

class FeedViewController: UICollectionViewController {

    let space: CGFloat = 20
    let presenter: FeedPresenter

    var stories: [StoryViewModel] = [] {
        didSet {
            collectionView.reloadData()
        }
    }

    init(presenter: FeedPresenter) {
        self.presenter = presenter

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

        setupUI()
        
        presenter.delegate = self
        presenter.reload()
    }
}

private extension FeedViewController {
    func setupUI() {
        loadCells([FeedCell.self])
        collectionView?.backgroundColor = .white
    }
}

// MARK: UICollectionViewDataSource
extension FeedViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stories.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(FeedCell.self, for: indexPath)
    
        // Configure the cell
        cell.config(viewModel: stories[indexPath.row])
    
        return cell
    }
}

// MARK: UICollectionViewDelegate
extension FeedViewController {
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let story = stories[indexPath.row]
        presenter.present(story: story)
    }
}

extension FeedViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfColumns: CGFloat = 2
        let width = (collectionView.bounds.width - space * (numberOfColumns + 1)) / numberOfColumns
        let height = width / CGFloat(stories[indexPath.row].ratio)
        return CGSize(width: width, height: height)
    }
}

extension FeedViewController: FeedPresenterDelegate {
    func feedLoadFailed(errorMessage: String) {
        // TODO: Show alert
        print("💔\(errorMessage)")
    }

    func feedLoaded(stories: [StoryViewModel]) {
        self.stories = stories
    }
}
