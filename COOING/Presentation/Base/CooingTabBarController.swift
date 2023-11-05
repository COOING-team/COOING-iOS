//
//  CooingTabBarController.swift
//  COOING
//
//  Created by 박윤빈 on 2023/11/05.
//

import UIKit

import SnapKit
import Then

class CooingTabBarController: UITabBarController {
    
    
    //MARK: - UI Components
    
    let homeViewController = HomeViewController()
    let historyViewController = HistoryViewController()
    let reportViewController = ReportViewController()
    let myPageViewController = MyPageViewController()
    
    lazy var homeNavigationContrller = UINavigationController(rootViewController: homeViewController)
    lazy var historyNavigationContrller = UINavigationController(rootViewController: historyViewController)
    lazy var reportNavigationContrller = UINavigationController(rootViewController: reportViewController)
    lazy var myPageNavigationContrller = UINavigationController(rootViewController: myPageViewController)
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTabBar()
        setNavigationController()
        setViewController()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tabBar.frame.size.height = 53
        tabBar.frame.origin.y = view.frame.height - 100
    }
    
    //MARK: - Custom Method
    
    private func setTabBar(){
        tabBar.backgroundColor = .white
        tabBar.itemPositioning = .centered
        tabBar.tintColor = .cooingYellow
        tabBar.layer.addBorder([.top], color: .cooingGray1, width: 1)

    }
    
    private func setNavigationController() {
        homeNavigationContrller.setNavigationBarHidden(true, animated: true)
        historyNavigationContrller.setNavigationBarHidden(true, animated: true)
        reportNavigationContrller.setNavigationBarHidden(true, animated: true)
        myPageNavigationContrller.setNavigationBarHidden(true, animated: true)
    }
    
    private func setViewController(){
        homeNavigationContrller.tabBarItem = setTabBarItem(title: "홈", image: Image.home, selectedImage: Image.homeFill)
        historyNavigationContrller.tabBarItem = setTabBarItem(title: "모아보기", image: Image.history, selectedImage: Image.historyFill)
        reportNavigationContrller.tabBarItem = setTabBarItem(title: "레포트", image: Image.report, selectedImage: Image.reportFill)
        myPageNavigationContrller.tabBarItem = setTabBarItem(title: "마이페이지", image: Image.my, selectedImage: Image.myFill)
        
        viewControllers = [
            homeNavigationContrller,
            historyNavigationContrller,
            reportNavigationContrller,
            myPageNavigationContrller
        ]
    }
    
    private func setTabBarItem(title: String, image: UIImage, selectedImage: UIImage) -> UITabBarItem {
        let tabBarItem = UITabBarItem(title: title, image: image, selectedImage: selectedImage)
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.navGray]
        tabBarItem.setTitleTextAttributes(attributes, for: .normal)
        tabBarItem.setTitleTextAttributes(attributes, for: .selected)
        return tabBarItem
    }
}
