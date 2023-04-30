//
//  FavoriteDashboardVC.swift
//  movie-buff
//
//  Created by Prox on 27/04/2023.
//  Copyright © 2023 Prox. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class FavoriteDashboardVC: BasePageViewModelController<FavoriteDashboardVM> {
    
    @IBOutlet weak var vSegment     : SegmentPV!
    @IBOutlet weak var vPageView    : UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initSegment()
    }
    
    override func initPageView() {
        super.initPageView()
        /** `Setup pageVC` */
        // Hiển thị UIPageViewController trong UIView hiện tại
        self.addChild(self.pageViewController)
        self.vPageView.addSubview(self.pageViewController.view)
        self.pageViewController.didMove(toParent: self)
        
        // Hiển thị trang đầu tiên
        if let viewcontroller = self.viewControllerAtIndex(0) {
            DispatchQueue.main.async {
                self.vSegment.rxSegmentSelected.accept(0)
                self.pageViewController.setViewControllers([viewcontroller],
                                                           direction: .forward,
                                                           animated: false,
                                                           completion: nil)
            }
        }
    }
    
    private func initSegment() {
        self.vSegment
            .rxSegmentSelected
            .asDriver()
            .drive(onNext: { [weak self] (index) in
                guard
                    let `self`  = self,
                    let topVC   = self.pageViewController.viewControllers?.first
                else { return }
                
                let currInd = self.indexForViewController(topVC)
                if let viewcontroller = self.viewControllerAtIndex(index) {
                    self.pageViewController.setViewControllers([viewcontroller],
                                                               direction: (currInd < index) ? .forward : .reverse,
                                                               animated: true,
                                                               completion: nil)
                }
            })
            .disposed(by: self.rxDisposeBag)
    }
    
    override func setupBinding() {
        super.setupBinding()
        self.rxCurrentIndex
            .asDriver()
            .drive(onNext: { [weak self] (index) in
                guard let `self` = self else { return }
                self.vSegment.rxSegmentSelected.accept(index)
            })
            .disposed(by: self.rxDisposeBag)
    }
}
