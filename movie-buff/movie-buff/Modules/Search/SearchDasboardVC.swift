//
//  SearchDasboardVC.swift
//  movie-buff
//
//  Created by Prox on 27/04/2023.
//  Copyright © 2023 Prox. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SearchDasboardVC: BaseViewModelController<SearchDasboardVM> {
    @IBOutlet weak var vNavBar  : NavBar!
    @IBOutlet weak var clvMovie : UICollectionView!
    @IBOutlet weak var vNodata  : UIView!
    @IBOutlet weak var imgNodata: UIImageView!
    @IBOutlet weak var lblNodata: UILabel!
    
    var data = 10
    override func setupNavBar() {
        super.setupNavBar()
        self.vNavBar.rxType.accept(.Search)
    }
    
    override func setupUI() {
        super.setupUI()
        self.setupCollectionView()
        self.view.backgroundColor   = .black
        
        /** `UINodata` */
        self.vNodata.isHidden       = true
        self.imgNodata.tintColor    = Constant.Color.hex_7A7A7A
        self.lblNodata.textColor    = Constant.Color.hex_7A7A7A
        self.lblNodata.font         = BaseFont.System.text_bold
        self.lblNodata.text         = "Oh sorry No search results"
    }
    
    override func setupBinding() {
        super.setupBinding()
        
        self.vNavBar.vSearchBar
            .rxTextDidChange
            .asDriver()
            .debounce(RxTimeInterval.milliseconds(500))
            .drive(onNext: { [weak self] (input) in
                guard let `self` = self, input.isEmpty == false else { return }
                self.data = 0
                self.clvMovie.reloadData()
                
                self.showLoading()
                self.refreshData()
            })
            .disposed(by: self.rxDisposeBag)
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
    
    @objc func loadMoreRefresh(_ sender: AnyObject) {
        self.data = self.data + 5
        self.clvMovie.reloadData()
    }
    
    private func setupCollectionView() {
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
        self.clvMovie.register(UINib(nibName: SearchCell.nibName, bundle: nil), forCellWithReuseIdentifier: SearchCell.nibName)
    }
}
 
extension SearchDasboardVC : UICollectionViewDelegate,
                             UICollectionViewDataSource,
                             UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCell.nibName, for: indexPath) as? SearchCell else { return UICollectionViewCell()}
        
        cell.lblType.text   = "Fiction"
        cell.lblSeason.text = "Season 1"
        cell.lblYEar.text   = "2023"
        cell.lblSubcr.text  = "DARK"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sizeCollection  = self.clvMovie.frame.size
        let width           = sizeCollection.width * ( 148 / 326 )
        let height          = sizeCollection.height * ( 276 / 734 )
        return CGSize(width: width, height: height)
    }
}
