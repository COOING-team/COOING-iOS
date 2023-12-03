//
//  FrequentTableViewCell.swift
//  COOING
//
//  Created by 박윤빈 on 2023/12/02.
//

import UIKit

import SnapKit
import Then

final class FrequentTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = "FrequentTableViewCell"
    private let numberImageList: [UIImage] = [Image.one,
                                              Image.two,
                                              Image.three,
                                              Image.four,
                                              Image.five]
    
    // MARK: - UI Components
    
    private var rankImageView = UIImageView(image: Image.one)
    private var frequentWordView = FrequentWordRightView()
    
    // MARK: - init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        configureUI()
        hieararchy()
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Functions
    
    private func configureUI() {
        
    }
    
    private func hieararchy() {
        self.contentView.addSubViews(rankImageView, frequentWordView)
    }
    
    private func setLayout() {
        rankImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(27.adjusted)
            $0.centerY.equalToSuperview()
        }
        
        frequentWordView.snp.makeConstraints {
            $0.height.equalTo(63.adjusted)
            $0.trailing.equalToSuperview().inset(27.adjusted)
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(rankImageView.snp.trailing).offset(24.adjusted)
        }
    }
    
    func configureCell(index: Int) {
        rankImageView.image = numberImageList[index]
    }
}
