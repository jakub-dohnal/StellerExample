//
//  CollectionCell+Registrable.swift
//  StellerExample
//
//  Created by Jakub Dohnal on 16/07/2019.
//  Copyright © 2019 Jakub Dohnal. All rights reserved.
//

import UIKit

typealias RegistrableCell = Loudable & Reusable & UICollectionViewCell

extension UICollectionViewController {

    func loadCells(_ cellTypes: [RegistrableCell.Type]) {
        cellTypes.forEach { cell in
            collectionView?.register(
                UINib(nibName: cell.nibName, bundle: Bundle.main),
                forCellWithReuseIdentifier: cell.identifier
            )
        }
    }

    func dequeueReusableCell<T>(_ cellType: T.Type, for indexPath: IndexPath) -> T where T: RegistrableCell {
       return collectionView.dequeueReusableCell(withReuseIdentifier: cellType.identifier, for: indexPath) as! T
    }
}

