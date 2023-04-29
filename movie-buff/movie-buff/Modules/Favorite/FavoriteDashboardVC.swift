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
            self.pageViewController.setViewControllers([viewcontroller],
                                                       direction: .forward,
                                                       animated: false,
                                                       completion: nil)
        }
    }
    
    private func initSegment() {
        self.vSegment
            .rxSegmentSelected
            .asDriver()
            .drive(onNext: { [weak self] (type) in
                guard let `self` = self else { return }
                print("===> \(self.currentIndex)")
                let index           = SegmentPV.indexMapper[type] ?? 0
                if let viewcontroller = self.viewControllerAtIndex(index) {
                    self.pageViewController.setViewControllers([viewcontroller],
                                                               direction: .forward,
                                                               animated: true,
                                                               completion: nil)
                }
            })
            .disposed(by: self.rxDisposeBag)
    }
}
