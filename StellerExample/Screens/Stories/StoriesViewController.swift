//
//  StoriesViewController.swift
//  StellerExample
//
//  Created by Jakub Dohnal on 18/07/2019.
//  Copyright © 2019 Jakub Dohnal. All rights reserved.
//

import UIKit
import QuickLook

class StoriesViewController: UICollectionViewController {

    let space: CGFloat = 20
    let presenter: StoriesPresenter

    init(presenter: StoriesPresenter) {
        self.presenter = presenter

        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = space * 2
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: space, left: space, bottom: space, right: space)

        super.init(collectionViewLayout: layout)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()

        let index = presenter.selectedStory
        let indexPath = IndexPath(row: index, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
        collectionView.isPagingEnabled = true

        let gesture = UIPanGestureRecognizer(target: self, action: #selector(panGesture(_:)))
        collectionView.addGestureRecognizer(gesture)
        gesture.delegate = self
    }

    @objc func panGesture(_ gestureRecognizer: UIPanGestureRecognizer) {
        switch gestureRecognizer.state {
        case .ended:
            presenter.close()
        default:
            break
        }
    }
}

extension StoriesViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let panGestureRecognizer = gestureRecognizer as? UIPanGestureRecognizer else { return true }
        let velocity = panGestureRecognizer.velocity(in: collectionView)
        return abs(velocity.y) > abs(velocity.x);
    }
}


private extension StoriesViewController {
    func setupUI() {
        loadCells([StoryCell.self])
        collectionView?.backgroundColor = .white
    }
}

// MARK: UICollectionViewDataSource
extension StoriesViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.stories.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(StoryCell.self, for: indexPath)

        // Configure the cell
        cell.config(viewModel: presenter.stories[indexPath.row])

        return cell
    }
}

// MARK: UICollectionViewDelegate
extension StoriesViewController {
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return false
    }
}

extension StoriesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfColumns: CGFloat = 1
        let width = (collectionView.bounds.width - space * (numberOfColumns + 1))
        let height = width / CGFloat(presenter.stories[indexPath.row].ratio)
        return CGSize(width: width, height: height)
    }
}
