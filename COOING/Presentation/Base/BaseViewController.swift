//
//  BaseViewController.swift
//  COOING
//
//  Created by 박윤빈 on 2023/11/05.
//

import UIKit

import SnapKit

class BaseViewController: UIViewController {

    // MARK: - Properties

    lazy private(set) var className: String = {
      return type(of: self).description().components(separatedBy: ".").last ?? ""
    }()

    // MARK: - Initializing

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("DEINIT: \(className)")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        hieararchy()
        setLayout()
        setButtonEvent()
        customNavigationBar()
        
    }

    //MARK: - Functions

    func configureUI() {
        //override Point
        view.backgroundColor = .white

    }

    func hieararchy() {
        //override Point
    }

    func setLayout() {
        //override Point
    }

    func setButtonEvent() {
        //override Point
    }
    
    func customNavigationBar() {
        navigationController?.navigationBar.tintColor = .cooingYellow
        let backButton: UIBarButtonItem = UIBarButtonItem()
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }

}
