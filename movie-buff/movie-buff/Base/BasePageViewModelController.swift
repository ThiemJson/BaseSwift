//
//  BasePageViewModelController.swift
//  movie-buff
//
//  Created by ThiemJason on 29/04/2023.
//  Copyright © 2023 Prox. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class BasePageViewModelController<T>: BaseViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    private(set) var viewModel          : T?
    
    private(set) var pageViewController : UIPageViewController!
    
    var viewControllers                 : [UIViewController] = []
    
    let rxCurrentIndex                   = BehaviorRelay<Int>.init(value: 0)
    
    init(_ viewModel: T?, _ viewcontrollers: [UIViewController]) {
        super.init()
        self.viewModel          = viewModel
        self.viewControllers    = viewcontrollers
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initPageView()
    }
    
    open func initPageView() {
        // Khởi tạo UIPageViewController
        self.pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        // Đặt datasource của UIPageViewController là chính nó
        self.pageViewController.dataSource  = self
        self.pageViewController.delegate    = self
    }
    
    func indexForViewController(_ viewController: UIViewController) -> Int {
        // Trả về chỉ số của ViewController trong danh sách ViewController của UIPageViewController
        // ở đây, danh sách ViewController được lưu trữ trong một mảng có tên là viewControllers
        return viewControllers.firstIndex(of: viewController) ?? 0
    }
    
    func viewControllerAtIndex(_ index: Int) -> UIViewController? {
        // Trả về ViewController ở chỉ số được chỉ định trong danh sách ViewController
        if index < 0 || index >= viewControllers.count {
            return nil
        }
        return viewControllers[index]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        if completed, let currentViewController = pageViewController.viewControllers?.first {
            self.rxCurrentIndex.accept(self.indexForViewController(currentViewController))
        }
    }
    
    override func setupBinding() {
        super.setupBinding()
        if let viewModel = viewModel as? BaseViewModel {
            viewModel.rxLoading
                .distinctUntilChanged()
                .onMain()
                .subscribe(onNext: { [weak self] loading in
                    loading ? self?.showLoading() : self?.hideLoading()
                })
                .disposed(by: self.rxDisposeBag)
        }
    }
    
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
