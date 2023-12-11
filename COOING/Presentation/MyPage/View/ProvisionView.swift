//
//  ProvisionView.swift
//  COOING
//
//  Created by 최지우 on 12/11/23.
//

import UIKit

class ProvisionView: BaseView, UITextViewDelegate {
    
    // MARK: - UI Components
    
    var privisionTextView = UITextView().then {
        $0.text = """
최종 수정일: 2023년 12월 10일

제 1조(개인정보 수집 목적)
"COOING" 서비스(이하 "서비스")는 회원 가입 및 서비스 제공을 위해 다음과 같은 개인정보를 수집하고 있습니다.

회원 가입 시:

수집 항목: 사용자 이메일, 자녀의 생년월일, 닉네임, 성별
수집 목적: 회원 가입, 서비스 제공, 계정 관리, 안내/고지, 사용자 상담
음성 녹음 및 텍스트 변환:

수집 항목: 음성 녹음 파일, 텍스트 변환 결과, 형태소 분석 결과, 단어 분석 결과
수집 목적: 음성 기반 서비스 제공, 분석 및 피드백 제공
제 2조(수집한 정보의 이용 방법)
수집한 개인정보는 다음과 같은 목적으로 이용됩니다:

서비스 제공 및 개선
사용자 상담 및 응대
음성 녹음 파일의 텍스트 변환, 형태소 분석 결과 제공
서비스 운영상, 기술상의 필요에 따른 변경
법령 및 약관 준수 등
제 3조(개인정보의 보유 및 보존 기간)
회사는 "회원"의 경우 회원 탈퇴일로부터 30일 동안 개인정보를 보유한 후 삭제합니다.

제 4조(개인정보의 제3자 제공)
회사는 이용자의 개인정보를 본래의 수집 및 이용 목적 범위를 초과하여 제3자에게 제공하지 않습니다. 다만, 이용자의 동의가 있는 경우와 법령의 규정에 따라 제공이 요구되는 경우에는 예외로 합니다.

제 5조(안전성 확보 조치)
회사는 개인정보의 안전성 확보를 위해 다음과 같은 조치를 취합니다:

개인정보 암호화 전송
해킹 등에 대비한 기술적 대책
개인정보에 대한 접근 제한
제 6조(이용자의 권리와 행사 방법)
이용자는 다음과 같은 권리를 행사할 수 있습니다:

개인정보 열람, 정정, 삭제 요청
개인정보 처리 일시 중지 요청
개인정보 이전 동의 철회 요청
제 7조(개인정보보호책임자)
성명: 국혜경
메일: lockertttt@gmail.com
제 8조(정책 변경)
회사는 개인 정보 보호 정책을 업데이트할 수 있으며 변경 사항은 해당 페이지에 게시된 직후 적용됩니다.

제 9조(적용일)
본 개인정보 처리방침은 2023년 12월 10일부터 적용됩니다.
"""
        $0.isEditable = false
    }
    
    // MARK: - Functions
    
    override func configureUI() {
        self.addSubview(privisionTextView)
    }
    
    override func setLayout() {
        privisionTextView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
        }
    }
    
}
