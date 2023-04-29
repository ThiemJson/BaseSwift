//
//  BasePageViewModelController.swift
//  movie-buff
//
//  Created by ThiemJason on 29/04/2023.
//  Copyright © 2023 Prox. All rights reserved.
//

import Foundation
import UIKit

class BasePageViewModelController<T>: BaseViewController, UIPageViewControllerDataSource {
    private(set) var viewModel          : T?
    
    private(set) var pageViewController : UIPageViewController!
    
    var viewControllers                 : [UIViewController] = []
    
    var currentIndex                    : Int = 0
    
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
        self.pageViewController.dataSource = self
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
            self.currentIndex = self.indexForViewController(currentViewController)
        }
    }
    
    func getCurrentIndex() -> Int? {
        if let page     = self.pageViewController.viewControllers?.first,
           let index    = self.pageViewController.viewControllers?.firstIndex(of: page) {
            return index
        }
        return nil
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
    
    func moveToViewController(at index: Int) {
        guard let currentViewController = self.pageViewController.viewControllers?.first else { return }
        guard let nextViewController = self.pageViewController.dataSource?.pageViewController(self.pageViewController, viewControllerAfter: currentViewController) else {
            return
        }
        self.pageViewController.setViewControllers([nextViewController],
                                                   direction: index > currentIndex ? .forward : .reverse,
                                                   animated: true,
                                                   completion: nil)
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
