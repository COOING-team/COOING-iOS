//
//  MyPageModel.swift
//  COOING
//
//  Created by 최지우 on 12/11/23.
//

import Foundation

struct MyPageLocalData: AppData {
    let titleLabel: String
}

extension MyPageLocalData {
    static let myPageServiceLabelList = [MyPageLocalData(titleLabel: "개인 정보 약관"),
                                         MyPageLocalData(titleLabel: "로그아웃"),
                                         MyPageLocalData(titleLabel: "탈퇴")]
}

