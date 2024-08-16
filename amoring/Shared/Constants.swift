//
//  Constants.swift
//  amoring
//
//  Created by 이준녕 on 11/22/23.
//

import Foundation

class Constants {
    static let domain = "https://api.amoring.info"
    static let genderOptions = ["MALE", "FEMALE"]
    
    static let businessTypes = ["클럽", "라운지", "주점", "바", "펍", "호프", "포차", "이자카야", "카페", "페스티벌"]
    static let daysOfWeek = ["일", "월", "화", "수", "목", "금", "토"]

//    static let interestCategories: [InterestCategory] = [
//        InterestCategory(name: InterestCategoryEnum.interest.rawValue, interests: interests),
//        InterestCategory(name: InterestCategoryEnum.music.rawValue, interests: music),
//        InterestCategory(name: InterestCategoryEnum.food.rawValue, interests: food_drink),
//        InterestCategory(name: InterestCategoryEnum.travel.rawValue, interests: travel),
//        InterestCategory(name: InterestCategoryEnum.movie.rawValue, interests: movies_novels),
//        InterestCategory(name: InterestCategoryEnum.sport.rawValue, interests: sport)
//    ]
    
//    관심사
//    static let interests = [
//        Interest(id: "101", name: "🎪 페스티벌", category: InterestCategory(name: InterestCategoryEnum.interest.rawValue)),
//        Interest(id: "102", name: "🥂 바", category: InterestCategory(name: InterestCategoryEnum.interest.rawValue)),
//        Interest(id: "103", name: "🎉 클럽", category: InterestCategory(name: InterestCategoryEnum.interest.rawValue)),
//        Interest(id: "104", name: "🎫 콘서트", category: InterestCategory(name: InterestCategoryEnum.interest.rawValue)),
//        Interest(id: "105", name: "🎤 노래방", category: InterestCategory(name: InterestCategoryEnum.interest.rawValue)),
//        Interest(id: "106", name: "🖼️ 갤러리", category: InterestCategory(name: InterestCategoryEnum.interest.rawValue)),
//        Interest(id: "107", name: "🎬 영화", category: InterestCategory(name: InterestCategoryEnum.interest.rawValue)),
//        Interest(id: "108", name: "💰 경제", category: InterestCategory(name: InterestCategoryEnum.interest.rawValue)),
//        Interest(id: "109", name: "📰 정치", category: InterestCategory(name: InterestCategoryEnum.interest.rawValue)),
//        Interest(id: "110", name: "🔭 우주", category: InterestCategory(name: InterestCategoryEnum.interest.rawValue)),
//        Interest(id: "111", name: "💃 댄스", category: InterestCategory(name: InterestCategoryEnum.interest.rawValue)),
//        Interest(id: "112", name: "👨‍👩‍👧‍👦 통일", category: InterestCategory(name: InterestCategoryEnum.interest.rawValue)),
//        Interest(id: "113", name: "🌡️ 지구온난화", category: InterestCategory(name: InterestCategoryEnum.interest.rawValue)),
//        Interest(id: "114", name: "💸 가난", category: InterestCategory(name: InterestCategoryEnum.interest.rawValue)),
//    ]
////    음악
//    static let music = [
//        Interest(id: "201", name: "🎵 EDM", category: InterestCategory(name: InterestCategoryEnum.music.rawValue)),
//        Interest(id: "202", name: "🎵 힙합", category: InterestCategory(name: InterestCategoryEnum.music.rawValue)),
//        Interest(id: "203", name: "🎵 컨트리", category: InterestCategory(name: InterestCategoryEnum.music.rawValue)),
//        Interest(id: "204", name: "🎵 라틴", category: InterestCategory(name: InterestCategoryEnum.music.rawValue)),
//        Interest(id: "205", name: "🎵 팝", category: InterestCategory(name: InterestCategoryEnum.music.rawValue)),
//        Interest(id: "206", name: "🎵 K-팝", category: InterestCategory(name: InterestCategoryEnum.music.rawValue)),
//        Interest(id: "207", name: "🎵 포크", category: InterestCategory(name: InterestCategoryEnum.music.rawValue)),
//        Interest(id: "208", name: "🎵 재즈", category: InterestCategory(name: InterestCategoryEnum.music.rawValue)),
//        Interest(id: "209", name: "🎵 메탈", category: InterestCategory(name: InterestCategoryEnum.music.rawValue)),
//        Interest(id: "210", name: "🎵 R&B", category: InterestCategory(name: InterestCategoryEnum.music.rawValue)),
//        Interest(id: "211", name: "🎵 랩", category: InterestCategory(name: InterestCategoryEnum.music.rawValue)),
//        Interest(id: "212", name: "🎵 하우스", category: InterestCategory(name: InterestCategoryEnum.music.rawValue)),
//        Interest(id: "213", name: "🎵 테크노", category: InterestCategory(name: InterestCategoryEnum.music.rawValue)),
//        Interest(id: "214", name: "🎵 트랜스", category: InterestCategory(name: InterestCategoryEnum.music.rawValue)),
//        Interest(id: "215", name: "🎵 클래식", category: InterestCategory(name: InterestCategoryEnum.music.rawValue)),
//        Interest(id: "216", name: "🎵 인디", category: InterestCategory(name: InterestCategoryEnum.music.rawValue)),
//        Interest(id: "217", name: "🎵 락", category: InterestCategory(name: InterestCategoryEnum.music.rawValue)),
//    ]
////    푸드&음료
//    static let food_drink = [
//        Interest(id: "301", name: "🥬 비건", category: InterestCategory(name: InterestCategoryEnum.food.rawValue)),
//        Interest(id: "302", name: "🥦 채식주의자", category: InterestCategory(name: InterestCategoryEnum.food.rawValue)),
//        Interest(id: "303", name: "🍺 맥주", category: InterestCategory(name: InterestCategoryEnum.food.rawValue)),
//        Interest(id: "304", name: "🧃 소주", category: InterestCategory(name: InterestCategoryEnum.food.rawValue)),
//        Interest(id: "305", name: "🍸 진", category: InterestCategory(name: InterestCategoryEnum.food.rawValue)),
//        Interest(id: "306", name: "🥃 위스키", category: InterestCategory(name: InterestCategoryEnum.food.rawValue)),
//        Interest(id: "307", name: "🍷 와인", category: InterestCategory(name: InterestCategoryEnum.food.rawValue)),
//        Interest(id: "308", name: "🍣 초밥", category: InterestCategory(name: InterestCategoryEnum.food.rawValue)),
//        Interest(id: "309", name: "🍕 피자", category: InterestCategory(name: InterestCategoryEnum.food.rawValue)),
//        Interest(id: "310", name: "🍛 커리", category: InterestCategory(name: InterestCategoryEnum.food.rawValue)),
//    ]
////    여행
//    static let travel = [
//        Interest(id: "401", name: "🎒 백패킹", category: InterestCategory(name: InterestCategoryEnum.travel.rawValue)),
//        Interest(id: "402", name: "🏖️ 바다여행", category: InterestCategory(name: InterestCategoryEnum.travel.rawValue)),
//        Interest(id: "403", name: "🏕️ 캠핑", category: InterestCategory(name: InterestCategoryEnum.travel.rawValue)),
//        Interest(id: "404", name: "🎣 낚시", category: InterestCategory(name: InterestCategoryEnum.travel.rawValue)),
//        Interest(id: "405", name: "🏃‍♀️ 하이킹", category: InterestCategory(name: InterestCategoryEnum.travel.rawValue)),
//        Interest(id: "406", name: "❄️ 겨울스포츠", category: InterestCategory(name: InterestCategoryEnum.travel.rawValue)),
//        Interest(id: "407", name: "♨️ 스파", category: InterestCategory(name: InterestCategoryEnum.travel.rawValue)),
//        Interest(id: "408", name: "🛤️ 로드트립", category: InterestCategory(name: InterestCategoryEnum.travel.rawValue)),
//        Interest(id: "409", name: "✈️ 해외여행", category: InterestCategory(name: InterestCategoryEnum.travel.rawValue)),
//        Interest(id: "410", name: "🗿 유적지탐험", category: InterestCategory(name: InterestCategoryEnum.travel.rawValue)),
//        ]
////    영화&소설
//    static let movies_novels = [
//        Interest(id: "501", name: "🎞️ 코미디", category: InterestCategory(name: InterestCategoryEnum.movie.rawValue)),
//        Interest(id: "502", name: "🎞️ 스릴러", category: InterestCategory(name: InterestCategoryEnum.movie.rawValue)),
//        Interest(id: "503", name: "🎞️ 액션", category: InterestCategory(name: InterestCategoryEnum.movie.rawValue)),
//        Interest(id: "504", name: "🎞️ 애니메이션", category: InterestCategory(name: InterestCategoryEnum.movie.rawValue)),
//        Interest(id: "505", name: "🎞️ 공상과학", category: InterestCategory(name: InterestCategoryEnum.movie.rawValue)),
//        Interest(id: "506", name: "🎞️ 발리우드", category: InterestCategory(name: InterestCategoryEnum.movie.rawValue)),
//        Interest(id: "507", name: "🎞️ 범죄", category: InterestCategory(name: InterestCategoryEnum.movie.rawValue)),
//        Interest(id: "508", name: "🎞️ 요리", category: InterestCategory(name: InterestCategoryEnum.movie.rawValue)),
//        Interest(id: "509", name: "🎞️ 드라마", category: InterestCategory(name: InterestCategoryEnum.movie.rawValue)),
//        Interest(id: "510", name: "🎞️ K-드라마", category: InterestCategory(name: InterestCategoryEnum.movie.rawValue)),
//        Interest(id: "511", name: "🎞️ 게임쇼", category: InterestCategory(name: InterestCategoryEnum.movie.rawValue)),
//        Interest(id: "512", name: "🎞️ 리얼리티쇼", category: InterestCategory(name: InterestCategoryEnum.movie.rawValue)),
//        Interest(id: "513", name: "🎞️ 미스테리", category: InterestCategory(name: InterestCategoryEnum.movie.rawValue)),
//        Interest(id: "514", name: "🎞️ 호러", category: InterestCategory(name: InterestCategoryEnum.movie.rawValue)),
//        Interest(id: "515", name: "🎞️ 판타지", category: InterestCategory(name: InterestCategoryEnum.movie.rawValue)),
//        Interest(id: "516", name: "🎞️ 다큐멘터리", category: InterestCategory(name: InterestCategoryEnum.movie.rawValue)),
//        Interest(id: "517", name: "📚 철학", category: InterestCategory(name: InterestCategoryEnum.movie.rawValue)),
//        Interest(id: "518", name: "📚 과학", category: InterestCategory(name: InterestCategoryEnum.movie.rawValue)),
//        Interest(id: "519", name: "📚 위인전", category: InterestCategory(name: InterestCategoryEnum.movie.rawValue)),
//        Interest(id: "520", name: "📚️ 시", category: InterestCategory(name: InterestCategoryEnum.movie.rawValue)),
//        Interest(id: "521", name: "📚 심리", category: InterestCategory(name: InterestCategoryEnum.movie.rawValue)),
//        ]
//    
//    //스포츠
//    static let sport = [
//        Interest(id: "601", name: "🏋️‍♂️ 헬스", category: InterestCategory(name: InterestCategoryEnum.sport.rawValue)),
//        Interest(id: "602", name: "🎾️ 테니스", category: InterestCategory(name: InterestCategoryEnum.sport.rawValue)),
//        Interest(id: "603", name: "⛳️ 골프", category: InterestCategory(name: InterestCategoryEnum.sport.rawValue)),
//        Interest(id: "604", name: "🚴 자전거", category: InterestCategory(name: InterestCategoryEnum.sport.rawValue)),
//        Interest(id: "605", name: "🤿️ 스쿠버다이빙", category: InterestCategory(name: InterestCategoryEnum.sport.rawValue)),
//        Interest(id: "606", name: "🏄‍ 서핑", category: InterestCategory(name: InterestCategoryEnum.sport.rawValue)),
//        Interest(id: "607", name: "🏊‍♀️️ 수영", category: InterestCategory(name: InterestCategoryEnum.sport.rawValue)),
//        Interest(id: "608", name: "🧘‍♀️ 요가", category: InterestCategory(name: InterestCategoryEnum.sport.rawValue)),
//        ]
    
    static let phoneCodeList = [
        "010",
        "070",
        "02",
        "031",
        "032",
        "033",
        "041",
        "042",
        "043",
        "044",
        "051",
        "052",
        "053",
        "054",
        "055",
        "061",
        "062",
        "063",
        "064",
    ]
    
//    static let phoneCodeList = [
//        (010, "이동전화"),
//        (070, "인터넷 전화 (VolP)"),
//        (02, "서울특별시"),
//        (031, "경기도"),
//        (032, "인천광역시"),
//        (033, "강원특별자치도"),
//        (041, "충청남도"),
//        (042, "대전광역시"),
//        (043, "충청북도"),
//        (044, "세종특별자치시"),
//        (051, "부산광역시"),
//        (052, "울산광역시"),
//        (053, "대구광역시"),
//        (054, "경상북도"),
//        (055, "경상남도"),
//        (061, "전라남도"),
//        (062, "광주광역시"),
//        (063, "전라북도"),
//        (064, "제주특별자치도")
//    ]
    static var version: String {
        guard let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        else {
            return ""
        }
        return version
    }

    static var build: String {
        guard let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
        else {
            return ""
        }
        return build
    }
}
