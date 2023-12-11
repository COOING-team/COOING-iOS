//
//  SecretNoteDTO.swift
//  COOING
//
//  Created by 박윤빈 on 2023/12/04.
//

import Foundation

struct SecretNoteDTO: Codable {
    let grade1, grade2, grade3: [Bool]
}

extension SecretNoteDTO {
    static func booleanDummy() -> SecretNoteDTO {
        return SecretNoteDTO(grade1: [true, false, true, true, false], grade2: [false, true, true, false, true, true, true], grade3: [true, true, true, false])
    }
}

struct SecretNoteLevel {
    let firstSection, secondSection, thirdSection: [String]
}

extension SecretNoteLevel {
    static func setFirstLevelSection() -> SecretNoteLevel {
        return SecretNoteLevel(firstSection: ["한 낱말 이상의 문장 구조가 나타나요."],
                               secondSection: ["말에 명사를 주로 사용해요.",
                                               "이거, 뭐 등 대명사가 나타나요.",
                                               "줘, 가, 앉아, 먹어  등 간단한 동사가 나타나요."],
                               thirdSection: ["-야, -자 등 간단한 종결어미가 나타나요."])
    }
    
    static func setSecondLevelSection() -> SecretNoteLevel {
        return SecretNoteLevel(firstSection: ["두 낱말 이상을 조합하는  문장 구조가 나타나요."],
                               secondSection: ["끼워, 빼, 떼, 까 등의 좀 더 복잡한 동사가 나타나요. ",
                                               "더, 많이 또 등의 부사가 나타나요.",
                                               "누구, 어디 등의 의문사가 나타나요."],
                               thirdSection: ["-거 (이거, 저거) 등의 의존 명사가 나타나요.",
                                              "-가 등의 주격조사, -는 등의 주체보조사가 나타나요.",
                                              "-줘 등 보조사가 나타나요."])
    }
    
    static func setThirdLevelSection() -> SecretNoteLevel {
        return SecretNoteLevel(firstSection: ["한국어의 기본 구조인 세 낱말 이상을 조합하는 \n문장 구조가 나타나요."],
                               secondSection: ["크다, 작다 등 관계어가 나타나요.",
                                               "왜, 어떻게, 이렇게 등의 의문사가 나타나요."],
                               thirdSection: ["고 등 연결어미가 나타나요.",
                                              "이전보다 다양하고 복잡한 종결어미가 나타나요."])
    }
}
