//
//  FVPageActorVC.swift
//  movie-buff
//
//  Created by ThiemJason on 29/04/2023.
//  Copyright © 2023 Prox. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class FVPageActorVC: BaseViewModelController<FVPageActorVM> {
    @IBOutlet weak var clvMovie: UICollectionView!
    var data = 10
    
    override func setupUI() {
        super.setupUI()
        self.setupClv()
    }

    private func setupClv() {
        self.clvMovie.backgroundColor   = .clear
        self.clvMovie.showsVerticalScrollIndicator      = false
        self.clvMovie.showsHorizontalScrollIndicator    = false
        self.clvMovie.delegate          = self
        self.clvMovie.dataSource        = self
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing       = .normal
        layout.minimumInteritemSpacing  = .normal
        layout.sectionInset             = .init(horizontal: .small, vertical: .doubleNormal)
        self.clvMovie.collectionViewLayout = layout
        self.refreshControl.tintColor           = .white
        self.refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        self.clvMovie.addSubview(self.refreshControl)
        self.clvMovie.register(UINib(nibName: FVPageActorCell.nibName, bundle: nil), forCellWithReuseIdentifier: FVPageActorCell.nibName)
    }
    
    override func refreshData() {
        super.refreshData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.refreshControl.endRefreshing()
            self.hideLoading()
            self.data = 10
            self.clvMovie.reloadData()
        }
    }
    
    @objc func refresh(_ sender: AnyObject) {
        self.refreshData()
    }
}

extension FVPageActorVC : UICollectionViewDelegate,
                             UICollectionViewDataSource,
                             UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FVPageActorCell.nibName, for: indexPath) as? FVPageActorCell else { return UICollectionViewCell()}
        
        cell.lblActor.text       = "Nguyen Cao Thiem"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sizeCollection  = self.clvMovie.frame.size
        let width           = sizeCollection.width * ( 3 / 10 )
        let height          = sizeCollection.height * ( 105 / 572 )
        return CGSize(width: width, height: height)
    }
}
