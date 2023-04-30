//
//  FVPageTVShowVC.swift
//  movie-buff
//
//  Created by ThiemJason on 29/04/2023.
//  Copyright © 2023 Prox. All rights reserved.
//

import UIKit

class FVPageTVShowVC: BaseViewModelController<FVPageTVShowVM> {
    @IBOutlet weak var clvMovie: UICollectionView!
    var data = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
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
        self.clvMovie.register(UINib(nibName: FvPageMovieCell.nibName, bundle: nil), forCellWithReuseIdentifier: FvPageMovieCell.nibName)
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

extension FVPageTVShowVC : UICollectionViewDelegate,
                             UICollectionViewDataSource,
                             UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FvPageMovieCell.nibName, for: indexPath) as? FvPageMovieCell else { return UICollectionViewCell()}
        
        cell.lblType.text       = "Fiction"
        cell.lblSeason.text     = "Season 1"
        cell.lblYear.text       = "2023"
        cell.lblContent.text    = "Puss in Boots : The Last Wish"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sizeCollection  = self.clvMovie.frame.size
        let width           = sizeCollection.width * 0.95
        let height          = sizeCollection.height * ( 105 / 572 )
        return CGSize(width: width, height: height)
    }
}
