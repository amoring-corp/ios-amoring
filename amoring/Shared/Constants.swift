//
//  Constants.swift
//  amoring
//
//  Created by 이준녕 on 11/22/23.
//

import Foundation

class Constants {
    static let genderOptions = ["MALE", "FEMALE"]
    
    static let businessTypes = ["클럽", "라운지", "주점", "바", "펍", "호프", "포차", "이자카야", "카페", "페스티벌"]

//    관심사
    static let interests = [
        Interest(id: 101, title: "🎪 페스티벌", category: .interest),
        Interest(id: 102, title: "🥂 바", category: .interest),
        Interest(id: 103, title: "🎉 클럽", category: .interest),
        Interest(id: 104, title: "🎫 콘서트", category: .interest),
        Interest(id: 105, title: "🎤 노래방", category: .interest),
        Interest(id: 106, title: "🖼️ 갤러리", category: .interest),
        Interest(id: 107, title: "🎬 영화", category: .interest),
        Interest(id: 108, title: "💰 경제", category: .interest),
        Interest(id: 109, title: "📰 정치", category: .interest),
        Interest(id: 110, title: "🔭 우주", category: .interest),
        Interest(id: 111, title: "💃 댄스", category: .interest),
        Interest(id: 112, title: "👨‍👩‍👧‍👦 통일", category: .interest),
        Interest(id: 113, title: "🌡️ 지구온난화", category: .interest),
        Interest(id: 114, title: "💸 가난", category: .interest),
    ]
//    음악
    static let music = [
        Interest(id: 201, title: "🎵 EDM", category: .music),
        Interest(id: 202, title: "🎵 힙합", category: .music),
        Interest(id: 203, title: "🎵 컨트리", category: .music),
        Interest(id: 204, title: "🎵 라틴", category: .music),
        Interest(id: 205, title: "🎵 팝", category: .music),
        Interest(id: 206, title: "🎵 K-팝", category: .music),
        Interest(id: 207, title: "🎵 포크", category: .music),
        Interest(id: 208, title: "🎵 재즈", category: .music),
        Interest(id: 209, title: "🎵 메탈", category: .music),
        Interest(id: 210, title: "🎵 R&B", category: .music),
        Interest(id: 211, title: "🎵 랩", category: .music),
        Interest(id: 212, title: "🎵 하우스", category: .music),
        Interest(id: 213, title: "🎵 테크노", category: .music),
        Interest(id: 214, title: "🎵 트랜스", category: .music),
        Interest(id: 215, title: "🎵 클래식", category: .music),
        Interest(id: 216, title: "🎵 인디", category: .music),
        Interest(id: 217, title: "🎵 락", category: .music),
    ]
//    푸드&음료
    static let food_drink = [
        Interest(id: 301, title: "🥬 비건", category: .food),
        Interest(id: 302, title: "🥦 채식주의자", category: .food),
        Interest(id: 303, title: "🍺 맥주", category: .food),
        Interest(id: 304, title: "🧃 소주", category: .food),
        Interest(id: 305, title: "🍸 진", category: .food),
        Interest(id: 306, title: "🥃 위스키", category: .food),
        Interest(id: 307, title: "🍷 와인", category: .food),
        Interest(id: 308, title: "🍣 초밥", category: .food),
        Interest(id: 309, title: "🍕 피자", category: .food),
        Interest(id: 310, title: "🍛 커리", category: .food),
    ]
//    여행
    static let travel = [
        Interest(id: 401, title: "🎒 백패킹", category: .travel),
        Interest(id: 402, title: "🏖️ 바다여행", category: .travel),
        Interest(id: 403, title: "🏕️ 캠핑", category: .travel),
        Interest(id: 404, title: "🎣 낚시", category: .travel),
        Interest(id: 405, title: "🏃‍♀️ 하이킹", category: .travel),
        Interest(id: 406, title: "❄️ 겨울스포츠", category: .travel),
        Interest(id: 407, title: "♨️ 스파", category: .travel),
        Interest(id: 408, title: "🛤️ 로드트립", category: .travel),
        Interest(id: 409, title: "✈️ 해외여행", category: .travel),
        Interest(id: 410, title: "🗿 유적지탐험", category: .travel),
        ]
//    영화&소설
    static let movies_novels = [
        Interest(id: 501, title: "🎞️ 코미디", category: .movie),
        Interest(id: 502, title: "🎞️ 스릴러", category: .movie),
        Interest(id: 503, title: "🎞️ 액션", category: .movie),
        Interest(id: 504, title: "🎞️ 애니메이션", category: .movie),
        Interest(id: 505, title: "🎞️ 공상과학", category: .movie),
        Interest(id: 506, title: "🎞️ 발리우드", category: .movie),
        Interest(id: 507, title: "🎞️ 범죄", category: .movie),
        Interest(id: 508, title: "🎞️ 요리", category: .movie),
        Interest(id: 509, title: "🎞️ 드라마", category: .movie),
        Interest(id: 510, title: "🎞️ K-드라마", category: .movie),
        Interest(id: 511, title: "🎞️ 게임쇼", category: .movie),
        Interest(id: 512, title: "🎞️ 리얼리티쇼", category: .movie),
        Interest(id: 513, title: "🎞️ 미스테리", category: .movie),
        Interest(id: 514, title: "🎞️ 호러", category: .movie),
        Interest(id: 515, title: "🎞️ 판타지", category: .movie),
        Interest(id: 516, title: "🎞️ 다큐멘터리", category: .movie),
        Interest(id: 517, title: "📚 철학", category: .movie),
        Interest(id: 518, title: "📚 과학", category: .movie),
        Interest(id: 519, title: "📚 위인전", category: .movie),
        Interest(id: 520, title: "📚️ 시", category: .movie),
        Interest(id: 521, title: "📚 심리", category: .movie),
        ]
    
    //스포츠
    static let sport = [
        Interest(id: 601, title: "🏋️‍♂️ 헬스", category: .sport),
        Interest(id: 602, title: "🎾️ 테니스", category: .sport),
        Interest(id: 603, title: "⛳️ 골프", category: .sport),
        Interest(id: 604, title: "🚴 자전거", category: .sport),
        Interest(id: 605, title: "🤿️ 스쿠버다이빙", category: .sport),
        Interest(id: 606, title: "🏄‍ 서핑", category: .sport),
        Interest(id: 607, title: "🏊‍♀️️ 수영", category: .sport),
        Interest(id: 608, title: "🧘‍♀️ 요가", category: .sport),
        ]
}
