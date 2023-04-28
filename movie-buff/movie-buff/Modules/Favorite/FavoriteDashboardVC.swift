//
//  FavoriteDashboardVC.swift
//  movie-buff
//
//  Created by Prox on 27/04/2023.
//  Copyright © 2023 Prox. All rights reserved.
//

import UIKit

class FavoriteDashboardVC: BaseViewModelController<FavoriteDashboardVM> {
    
    @IBOutlet weak var vSegment : SegmentPV!
    @IBOutlet weak var vPageView: UIView!
    var pageViewController      : UIPageViewController!
    var viewControllers         : [UIViewController] = [
        SearchDasboardVC(SearchDasboardVMObject()),
        SettingDashboardVC(SettingDashboardVMObject())
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Khởi tạo UIPageViewController
        self.pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
        // Đặt datasource của UIPageViewController là chính nó
        self.pageViewController.dataSource = self
        
        // Hiển thị UIPageViewController trong UIView hiện tại
        self.addChild(self.pageViewController)
        self.vPageView .addSubview(self.pageViewController.view)
        self.pageViewController.didMove(toParent: self)
        
        // Hiển thị trang đầu tiên
        if let viewcontroller = self.viewControllerAtIndex(0) {
            self.pageViewController.setViewControllers([viewcontroller],
                                                       direction: .forward,
                                                       animated: false,
                                                       completion: nil)
        }
    }
    
    func indexForViewController(_ viewController: UIViewController) -> Int {
        // Trả về chỉ số của ViewController trong danh sách ViewController của UIPageViewController
        // ở đây, danh sách ViewController được lưu trữ trong một mảng có tên là viewControllers
        return viewControllers.firstIndex(of: viewController)!
    }

    func viewControllerAtIndex(_ index: Int) -> UIViewController? {
        // Trả về ViewController ở chỉ số được chỉ định trong danh sách ViewController
        if index < 0 || index >= viewControllers.count {
            return nil
        }
        return viewControllers[index]
    }
}

extension FavoriteDashboardVC : UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        // Trả về ViewController trước đó
        let index = self.indexForViewController(viewController)
        return self.viewControllerAtIndex(index - 1)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        // Trả về ViewController tiếp theo
        let index = self.indexForViewController(viewController)
        return self.viewControllerAtIndex(index + 1)
    }
}
