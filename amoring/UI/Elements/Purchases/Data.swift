//
//  Data.swift
//  amoring
//
//  Created by 이준녕 on 12/15/23.
//

import Foundation

let purchasesList = [
    PurchaseModel(barTitle: "좋아요", title: "좋아요 구매하기", subtitle: "더 많은 좋아요로 더 많은 인연을 만들어보세요.", description: "purchase.likes.description",
                  description3: "구매 안내",
                  description4: "purchase.likes.description4",
                  type: .like),
    
    PurchaseModel(barTitle: "라운지", title: "라운지", subtitle: "내 주변에 있을\n인연을 발견하세요", description: "소중한 인연이 스쳐지나갈까 걱정되나요?\n내 주변 반경 2km까지 라운지를 넓혀보세요.", description2: "패스는 구입시점 부터 12시간동안 적용됩니다.\n구매시 패스가 자동으로 활성화 되니 걱정마세요!", type: .lounge),
    
    
    PurchaseModel(barTitle: "내 프로필 숨기기", title: "내 프로필 숨기기", subtitle: "나를 드러내지 않고 조용히 인연을 찾아보세요.", description: "내가 좋아요를 보낸 멤버에게만 프로필을 공개할 수 있습니다.", description3: "구매 안내", description4: "purchase.hide.description4", type: .transparent),
    
    
    PurchaseModel(
        barTitle: "나를 좋아한 사람 보기",
        title: "나를 좋아한 사람 보기",
        subtitle: "메시지 탭에서 나에게 좋아요를 보낸 멤버를 확인해 보세요.",
        description: "오늘 밤, 리스트 보기를 활성화하고 당신에게 관심을 보인 멤버에게 메시지를 보내 보세요.", description3: "구매 안내", description4: "purchase.hide.description4", type: .list),
]
