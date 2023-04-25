//
//  BaseViewController.swift
//  base-swift
//
//  Created by ThiemJason on 24/04/2023.
//

import UIKit
import Reachability
import RxSwift
import RxCocoa
import RxLocalizer

open class BaseViewController: UIViewController {
    
    /** `Properties` */
    open var shouldDisplayLostConnectionView        : Bool
    
    open var backButton                             : UIBarButtonItem?
    
    open var titleBackButton                        : String? = ""
    
    open var rxDisposeBag                           = DisposeBag()
    
    var languageModel                               = LanguageModel(localizer: Localizer.shared)
    
    /** `Background task` */
    open var shouldUseBackgroundTask                : Bool
    
    open var backgroundTaskID                       : UIBackgroundTaskIdentifier?
    
    private var _keyboardHeight                     : CGFloat = 0
    
    open var keyboardHeight: CGFloat {
        return self._keyboardHeight
    }
    
    public init() {
        self.shouldDisplayLostConnectionView = true
        self.shouldUseBackgroundTask = false
        super.init(nibName: nil, bundle: nil)
        self.initDefault()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        self.shouldDisplayLostConnectionView = true
        self.shouldUseBackgroundTask = false
        super.init(coder: aDecoder)
        self.initDefault()
    }
    
    override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.shouldDisplayLostConnectionView = true
        self.shouldUseBackgroundTask = false
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.initDefault()
    }
    
    private func initDefault() {
        self.hidesBottomBarWhenPushed = true
    }
    
    deinit {
        print("Deinit ==> \(self.description)")
        self.unregisterNotification()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupCommonNavigation()
        if let titleBackButton = self.titleBackButton, titleBackButton != "" {
            self.backButton?.title = titleBackButton
        }
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.titleBackButton = self.backButton?.title
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.backItem?.backBarButtonItem?.title = ""
        } else {
            self.navigationController?.navigationBar.topItem?.backBarButtonItem?.title = ""
        }
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupBinding()
        self.handlerAction()
        self.registerNotification()
    }
    
    /** `UI Configuration` */
    open func setupUI() {}
    
    /** `Localizer` */
    open func setupLocalizer() {}
    
    /** `Binding Rx` */
    open func setupBinding() {}
    
    /** `Handler action button tap(), ...` */
    open func handlerAction() {}
    
    /** `Vào view nếu mât kết nối thì sẽ refresh data sau khi có kết nối trở lại` */
    open func refreshData() {}
}

// MARK: Notification Center
extension BaseViewController {
    public func registerNotification() {
        /** `Reachability` */
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.reachabilityChanged(_:)),
                                               name: Notification.Name.reachabilityChanged,
                                               object: ReachabilityService.shared.reachability)
        
        /** `Keyboard` */
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil);
        
        /** `Application state` */
        NotificationCenter.default.addObserver(self, selector: #selector(self.applicationDidBecomeActive(_:)), name: UIApplication.didBecomeActiveNotification, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(self.applicationDidEnterBackground(_:)), name: UIApplication.didEnterBackgroundNotification, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(self.applicationWillEnterForeground(_:)), name: UIApplication.willEnterForegroundNotification, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(self.applicationWillResignActive(_:)), name: UIApplication.willResignActiveNotification, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(self.applicationWillTerminate(_:)), name: UIApplication.willTerminateNotification, object: nil);
    }
    
    public func unregisterNotification() {
        /** `Remove all Notification center` */
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: Reachability
extension BaseViewController {
    /** ` Check internet connection ngay khi vào viewcontroller` */
    public func checkInternetAndRefreshData() {
        if ReachabilityService.shared.isConnectionEnable() {
            self.refreshData()
        } else {
            if self.shouldDisplayLostConnectionView {
                self.showLostConnectionView()
            }
        }
    }
    
    /** `Show UI Lost connection` */
    public func showLostConnectionView() {}
    
    /** `Kiểm tra internet connection liên tục khi có thông báo kết nối/ngắt` */
    @objc func reachabilityChanged(_ note: Notification) {
        if let reachability = note.object as? Reachability {
            if [Reachability.Connection.cellular, Reachability.Connection.wifi].contains(reachability.connection) {
                /** Xử lý ngay lập tức khi có kết nối */
                self.reachableInternet()
            } else {
                /** Xử lý ngay lập tức khi bị mất mạng */
                self.reachableNotInternet()
            }
        }
    }
    
    /** `Có kết nối` */
    public func reachableInternet() {}
    
    /** `Mất kết nối` */
    public func reachableNotInternet() {}
}

// MARK: Setting navigation bar
extension BaseViewController {
    public func setupCommonNavigation() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage    = UIImage()
        self.navigationController?.navigationBar.isTranslucent  = true
        self.navigationController?.navigationBar.barTintColor   = UIColor.clear
        self.navigationController?.navigationBar.tintColor      = .white
        self.navigationController?.navigationBar.barStyle       = .black
    }
    
    public func resetBackBarButton(_ title: String, _ titleColor: UIColor? = .white) {
        if self.backButton == nil {
            self.backButton = UIBarButtonItem()
            self.backButton?.tintColor = titleColor
        }
        self.backButton?.title = title
        navigationController?.navigationBar.tintColor = titleColor
        navigationController?.navigationBar.backItem?.backBarButtonItem = self.backButton
    }
    
    public func resetCurrentBackBarButton(_ title: String, _ titleColor: UIColor? = .white) {
        if self.backButton == nil {
            self.backButton = UIBarButtonItem()
            self.backButton?.tintColor = titleColor
        }
        self.backButton?.title = title
        navigationController?.navigationBar.tintColor = titleColor
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.topItem?.backBarButtonItem = self.backButton
        } else {
            navigationController?.navigationBar.backItem?.backBarButtonItem = self.backButton
        }
    }
}

// MARK: Auto layout
extension BaseViewController {
    @objc open func keyboardWillShow(_ notification: Notification) {
        guard let keyboardHeight = notification.keyboardHeight else { return }
        self._keyboardHeight = keyboardHeight
        self.viewWillLayoutSubviews()
        UIView.animate(withDuration: notification.keyboardAnimationDuration ?? 0.3) { [weak self] in
            self?.view.layoutIfNeeded()
        }
    }
    
    @objc open func keyboardWillHide(_ notification: Notification) {
        self._keyboardHeight = 0
        self.viewWillLayoutSubviews()
        UIView.animate(withDuration: notification.keyboardAnimationDuration ?? 0.3) { [weak self] in
            self?.view.layoutIfNeeded()
        }
    }
}

// MARK: Loading, snack, msg
extension BaseViewController {
    public func showLoading(message: String? = nil) {
        DispatchQueue.main.async { [weak self] in
            guard let `self` = self else { return }
            self.showLoading(forView: self.view, message: message)
        }
    }
    
    public func showLoading(forView view: UIView?, message: String? = nil) {
        if let view = view {
            BaseLoading.shared.show(forView: view, message: message)
        }
    }
    
    public func hideLoading() {
        DispatchQueue.main.async {
            BaseLoading.shared.dismiss()
        }
    }
    
    public func showSnackError(message: String) {
        DispatchQueue.main.async {
            AppMessagesManager.shared.showMessage(messageType: .error, message: message)
        }
    }
    
    public func showSnackAlertSuccess(message: String) {
        DispatchQueue.main.async {
            AppMessagesManager.shared.showMessage(messageType: .success, message: message)
        }
    }
}

// MARK: Rounting
extension BaseViewController {
    @objc open func pop() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc open func push(vc: UIViewController) {
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc public func dismiss() {
        self.dismiss(animated: true)
    }
    
    @objc public func show(completion: (() -> Void)? = nil) {
        modalPresentationStyle  = .overFullScreen
        modalTransitionStyle    = .crossDissolve
        UIViewController.topViewController?.present(self, animated: true, completion: completion)
    }
    
    func replaceRoot(to viewController: UIViewController,
                     withTransitionType type: CATransitionType = .push,
                     andTransitionSubtype subtype: CATransitionSubtype = .fromRight ) {
        
        let navVC       = viewController.embedInNavigationController()
        let window      = UIApplication.shared.windows.first(where: { $0.isKeyWindow })
        let transition  = CATransition()
        transition.duration         = 0.3
        transition.timingFunction   = CAMediaTimingFunction(
            name: CAMediaTimingFunctionName.easeOut
        )
        transition.type = type
        transition.subtype = subtype
        window?.layer.add(transition, forKey: kCATransition)
        window?.rootViewController = navVC
    }
}

// MARK: UIGestureRecognizerDelegate
extension BaseViewController: UIGestureRecognizerDelegate {
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer.isEqual(self.navigationController?.interactivePopGestureRecognizer) {
            self.navigationController?.popViewController(animated: true)
        }
        return false
    }
}

// MARK: - Handler Application change ( Orientation change, moveToBackground,.. )
extension BaseViewController {
    /** `applicationWillResignActive` */
    @objc open func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    /** `applicationDidEnterBackground` */
    @objc open func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.\
        
        if self.shouldUseBackgroundTask == false { return }
        self.backgroundTaskID = UIApplication.shared.beginBackgroundTask(expirationHandler: { [weak self] in
            guard let `self` = self else { return }
            /** `Background task must be end after exacuted` */
            self.startBackgroundTask()
        })
    }
    
    /** `applicationWillEnterForeground` */
    @objc open func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        /** `Dispose background task` */
        if
            let backgroundTaskID            = self.backgroundTaskID,
            self.shouldUseBackgroundTask    == true {
            UIApplication.shared.endBackgroundTask(backgroundTaskID)
        }
    }
    
    /** `applicationDidBecomeActive` */
    @objc open func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    /** `enter app terminate` */
    @objc open func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

// MARK: - Background task
extension BaseViewController {
    public func startBackgroundTask() {
        /** `Background task must be end after exacuted` */
    }
    
    public func endBackgroundTask() {
        /** `Background task must be end after exacuted` */
        if let backgroundTaskID = self.backgroundTaskID {
            UIApplication.shared.endBackgroundTask(backgroundTaskID)
        }
    }
}
