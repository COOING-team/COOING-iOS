//
//  MyPageViewController.swift
//  COOING
//
//  Created by 박윤빈 on 2023/11/05.
//

import UIKit

import Moya

class MyPageViewController: BaseViewController {
    
    let provider = MoyaProvider<MyRouter>()
    
    // MARK: - UI Components
    
    let myPageView = MyPageView()
    
    // MARK: - override Functions

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegate()
    }
    
    override func hieararchy() {
        view.addSubview(myPageView)
    }
    
    override func setLayout() {
        myPageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func setButtonEvent() {
    }
    
    // MARK: - Custom Method

    func setDelegate() {
        myPageView.myPageTableView.dataSource = self
        myPageView.myPageTableView.delegate = self
    }
   
    func logout() {
        RealmService.shared.resetDB()

        let loginViewController = LoginViewController()
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
        let keyWindow = windowScene.windows.first(where: { $0.isKeyWindow }) {
        keyWindow.replaceRootViewController(UINavigationController(rootViewController: loginViewController), animated: true, completion: nil)
        }
    }

}


// MARK: - TableView DataSource

extension MyPageViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myPageView.myPageServiceLabelList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyPageServiceCell.identifier,
                                                       for: indexPath)
                as? MyPageServiceCell else {
            return MyPageServiceCell()
        }

        let title = myPageView.myPageServiceLabelList[indexPath.row].titleLabel
        cell.serviceLable.text = title
   
        cell.rightItemLabel.text = ">"
        cell.contentView.backgroundColor = .cooingGray2
        
        return cell
    }
}

extension MyPageViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        if indexPath.row == 0 {
            let provisionViewController = ProvisionViewController()
            self.navigationController?.pushViewController(provisionViewController, animated: true)
        } else if indexPath.row == 1 {
           // 로그아웃
            logout()
        } else if indexPath.row == 2 {
            // 탈퇴
        } else {
            return
        }
    }
}

// MARK: - Network
extension MyPageViewController {
    
    private func getBabyInfo() {
        self.provider.request(.getBabyInfo) { response in
            switch response {
            case .success(let response):
                do {
                    print(response.statusCode)

                    let responseData = try response.map(GenericResponse<MyInfoResponseDTO>.self)
                    self.myPageView.nameLabel.text = responseData.result.name
                    self.myPageView.monthLabel.text = "\(responseData.result.birthMonth)"

                    print("🔆\(responseData.result)")
                } catch(let err) {
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
//    
//    private func deleteUser() {
//        self.myProvider.request(.signOut) { response in
//            switch response {
//            case .success(let moyaResponse):
//                do {
//                    let isSuccess = try moyaResponse.map(Bool.self)
//                    if isSuccess {
//                        RealmService.shared.resetDB()
//                        let loginViewController = LoginViewController()
//                        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
//                           let keyWindow = windowScene.windows.first(where: { $0.isKeyWindow }) {
//                            keyWindow.replaceRootViewController(UINavigationController(rootViewController: loginViewController), animated: true, completion: nil)
//                        }
//                    }
//                } catch(let err) {
//                    print(err.localizedDescription)
//                }
//            case .failure(let err):
//                print(err.localizedDescription)
//            }
//        }
//    }

}
