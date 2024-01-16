//
//  Dummy.swift
//  amoring
//
//  Created by 이준녕 on 12/15/23.
//

import Foundation

class Dummy {
    static let businesses = [
        Business(id: "1", businessName: "Pray Coffee Bar", businessCategory: "바", address: "서울 성동구 성덕정길 152", phoneNumber: "0310000000", bio: "#프레이 #프레이커피바 #pray #coffee #bar", images: [
            "https://firebasestorage.googleapis.com/v0/b/tinderdemo-497b9.appspot.com/o/dummy-biz1.jpg?alt=media&token=b4c0db02-c47f-46b4-9e45-616be0f08c52",
            "https://firebasestorage.googleapis.com/v0/b/tinderdemo-497b9.appspot.com/o/dummy-biz1-1.jpg?alt=media&token=d581a138-28fd-468f-bed6-bd3e7a3bb6f3"
        ], district: "강남", open: "11:00 PM".timeToDate(), close: "10:00 AM".timeToDate()),
        
        Business(id: "2", businessName: "Seoul Bar Show", businessCategory: "바", address: "서울 성동구 성덕정길 152", phoneNumber: "0310000000", bio: "#프레이 #프레이커피바 #pray #coffee #bar", images: [
            "https://firebasestorage.googleapis.com/v0/b/tinderdemo-497b9.appspot.com/o/dummy-biz2.png?alt=media&token=fdfc2cb2-46f5-46e7-af4d-8caca5f95d15"
        ], district: "강남", open: "11:00 PM".timeToDate(), close: "10:00 AM".timeToDate()),
        
        Business(id: "3", businessName: "Cakeshop", businessCategory: "클럽", address: "서울 성동구 성덕정길 152", phoneNumber: "0310000000", bio: "#프레이 #프레이커피바 #pray #coffee #bar", images: [
            "https://firebasestorage.googleapis.com/v0/b/tinderdemo-497b9.appspot.com/o/dummy-biz3.jpg?alt=media&token=dbcdca1a-0441-49d3-bcd5-3879d5a62e44"
        ], district: "강남", open: "11:00 PM".timeToDate(), close: "10:00 AM".timeToDate()),
        
        Business(id: "4", businessName: "Glove Bar", businessCategory: "바", address: "서울 성동구 성덕정길 152", phoneNumber: "0310000000", bio: "#프레이 #프레이커피바 #pray #coffee #bar", images: [
            "https://firebasestorage.googleapis.com/v0/b/tinderdemo-497b9.appspot.com/o/dummy-biz4.png?alt=media&token=f5607b70-f85c-41cf-8105-a635941c16ce"
        ], district: "강남", open: "11:00 PM".timeToDate(), close: "10:00 AM".timeToDate()),
        
        Business(id: "5", businessName: "Retro Game Bar", businessCategory: "바", address: "서울 성동구 성덕정길 152", phoneNumber: "0310000000", bio: "#프레이 #프레이커피바 #pray #coffee #bar", images: [
            "https://firebasestorage.googleapis.com/v0/b/tinderdemo-497b9.appspot.com/o/dummy-biz5.jpg?alt=media&token=9343ec41-2883-41f1-8a61-6b2e71c48881"
        ], district: "강남", open: "11:00 PM".timeToDate(), close: "10:00 AM".timeToDate()),
    ]
    
    static let reactions = [
        Reaction(byUserId: "3", toUserId: "0", like: true),
        Reaction(byUserId: "4", toUserId: "0", like: true),
        Reaction(byUserId: "5", toUserId: "0", like: true),
    ]
    
    static let conversations = [
        Conversation(
            id: "1",
            participants: [users.first!, users[1]],
            messages: [
                Message(id: 1, body: "하이~!!! How is the start of your today? Max width 240", sender: users[1], senderId: users[1].id, recipients: [], createdAt: Date().addingTimeInterval(-8000), updatedAt: Date().addingTimeInterval(-8000)),
                Message(id: 2, body: "오 안녕하세요~?!", sender: users[0], senderId: users[0].id, recipients: [], createdAt: Date().addingTimeInterval(-9000), updatedAt: Date().addingTimeInterval(-9000)),
                Message(id: 3, body: "시작의 느낌이 좋아요 ㅋㅋㅋ", sender: users[0], senderId: users[0].id, recipients: [], createdAt: Date().addingTimeInterval(-10000), updatedAt: Date().addingTimeInterval(-10000)),
                Message(id: 4, body: "ㅋㅋㅋ 저도", sender: users[1], senderId: users[1].id, recipients: [], createdAt: Date().addingTimeInterval(-11000), updatedAt: Date().addingTimeInterval(-11000)),
                Message(id: 5, body: "그래서 지금 어디에 있어요? 저희는 지금 테이블 T4 인데 같이 조인 ㄱ?", sender: users[1], senderId: users[1].id, recipients: [], createdAt: Date().addingTimeInterval(-12000), updatedAt: Date().addingTimeInterval(-12000)),
                Message(id: 6, body: "어 저희도 테이블 있는데???", sender: users[0], senderId: users[0].id, recipients: [], createdAt: Date().addingTimeInterval(-13000), updatedAt: Date().addingTimeInterval(-13000)),
                Message(id: 7, body: "!", sender: users[1], senderId: users[1].id, recipients: [], createdAt: Date().addingTimeInterval(-14000), updatedAt: Date().addingTimeInterval(-14000)),
                Message(id: 8, body: "테이블 합칠 수 있나 가게에 물어볼게요 잠시만 기달", sender: users[1], senderId: users[1].id, recipients: [], createdAt: Date().addingTimeInterval(-20000), updatedAt: Date().addingTimeInterval(-20000)),
                
            ], createdAt: Date(), archivedAt: Date(), updatedAt: Date()),
        
        Conversation(
            id: "2",
            participants: [users.first!, users[2]],
            messages: [
                //                Message(id: 1, body: "아, 네 저희도 지금 같이 있어요 ㅎㅎ 지금 어디 계세요?", sender: users[2], senderId: users[2].id, recipients: [], createdAt: Date(), updatedAt: Date())
            ], createdAt: Date(), archivedAt: Date(), updatedAt: Date()),
        
        Conversation(
            id: "3",
            participants: [users.first!, users[3]],
            messages: [
                Message(id: 1, body: "아, 네 저희도 지금 같이 있어요 ㅎㅎ 지금 어디 계세요?", sender: users[3], senderId: users[3].id, recipients: [], createdAt: Date().addingTimeInterval(-90000), updatedAt: Date().addingTimeInterval(-90000))
            ], createdAt: Date().addingTimeInterval(-90000), archivedAt: Date(), updatedAt: Date().addingTimeInterval(-90000)),
        
        Conversation(
            id: "4",
            participants: [users.first!, users[4]],
            messages: [
                Message(id: 1, body: "아... 근데... 저희 사실 테이블 없어요 ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ", sender: users[4], senderId: users[4].id, recipients: [], createdAt: Date().addingTimeInterval(-90000), updatedAt: Date().addingTimeInterval(-90000))
            ], createdAt: Date().addingTimeInterval(-90000), archivedAt: Date(), updatedAt: Date().addingTimeInterval(-90000)),
    ]
    
    static let users = [
        User(
            id: "1",
            userProfile:
                UserProfile(id: "1",
                            name: "Eugene Krabs",
                            birthYear: 2000,
                            height: 176,
                            weight: 78,
                            mbti: mbtiE.INFP.rawValue,
                            education: "사무직",
                            occupation: "학사/박사",
                            bio: "저희 3명이고, 테이블 잡음, 술 있음",
                            gender: "female",
                            images: [
                                UserProfileImage(sort: 0, file: File(url: "https://firebasestorage.googleapis.com/v0/b/tinderdemo-497b9.appspot.com/o/dummyUser-1.png?alt=media&token=426686d7-5cc7-4c9d-9de8-6a87c0f28a7b")),
                                UserProfileImage(sort: 0, file: File(url: "https://firebasestorage.googleapis.com/v0/b/tinderdemo-497b9.appspot.com/o/dummyUser-2.png?alt=media&token=52de63e4-cc28-40b3-b987-04c3a80b3fc9")),
                                UserProfileImage(sort: 0, file: File(url: "https://firebasestorage.googleapis.com/v0/b/tinderdemo-497b9.appspot.com/o/dummyUser-3.png?alt=media&token=c8d56ce7-f636-4942-a939-91367052480e")),
                                UserProfileImage(sort: 0, file: File(url: "https://firebasestorage.googleapis.com/v0/b/tinderdemo-497b9.appspot.com/o/dummyUser-4.png?alt=media&token=144e3abe-d17f-4fa6-9a7c-8670ad3157db"))
                            ],
                            interests: [
                                Constants.sport[1],
                                Constants.sport[4],
                                Constants.sport[7],
                                Constants.sport[2],
                                Constants.sport[0],
                                Constants.interests[0],
                            ],
                            age: 24
                           )
        ),
        User(
            id: "2",
            userProfile:
                UserProfile(id: "2",
                            name: "SpongeBob SquarePants",
                            birthYear: 2001,
                            height: 176,
                            weight: 78,
                            mbti: mbtiE.INFP.rawValue,
                            education: "사무직",
                            occupation: "학사/박사",
                            bio: "저희 3명이고, 테이블 잡음, 술 있음",
                            gender: "male",
                            images: [
                                UserProfileImage(sort: 0, file: File(url: "https://firebasestorage.googleapis.com/v0/b/tinderdemo-497b9.appspot.com/o/person-1.jpeg?alt=media&token=06896c71-dabf-4262-8948-77015fab150e")),
                                UserProfileImage(sort: 0, file: File(url: "https://firebasestorage.googleapis.com/v0/b/tinderdemo-497b9.appspot.com/o/dummyUser-2.png?alt=media&token=52de63e4-cc28-40b3-b987-04c3a80b3fc9")),
                                UserProfileImage(sort: 0, file: File(url: "https://firebasestorage.googleapis.com/v0/b/tinderdemo-497b9.appspot.com/o/dummyUser-3.png?alt=media&token=c8d56ce7-f636-4942-a939-91367052480e")),
                                UserProfileImage(sort: 0, file: File(url: "https://firebasestorage.googleapis.com/v0/b/tinderdemo-497b9.appspot.com/o/dummyUser-4.png?alt=media&token=144e3abe-d17f-4fa6-9a7c-8670ad3157db"))
                            ],
                            interests: [
                                Constants.sport[1],
                                Constants.sport[4],
                                Constants.sport[7],
                                Constants.sport[2],
                                Constants.sport[0],
                                Constants.interests[0],
                            ],
                            age: 23
                           )
        ),
        
        User(
            id: "3",
            userProfile:
                UserProfile(id: "3",
                            name: "Patric Star",
                            birthYear: 1999,
                            height: 176,
                            weight: 78,
                            mbti: mbtiE.INFP.rawValue,
                            education: "사무직",
                            occupation: "학사/박사",
                            bio: "저희 3명이고, 테이블 잡음, 술 있음",
                            gender: "female",
                            images: [
                                UserProfileImage(sort: 0, file: File(url: "https://firebasestorage.googleapis.com/v0/b/tinderdemo-497b9.appspot.com/o/person-2.jpeg?alt=media&token=5f6f4728-0ddc-4f9d-9991-7b3cb31deff2")),
                                UserProfileImage(sort: 0, file: File(url: "https://firebasestorage.googleapis.com/v0/b/tinderdemo-497b9.appspot.com/o/dummyUser-2.png?alt=media&token=52de63e4-cc28-40b3-b987-04c3a80b3fc9")),
                                UserProfileImage(sort: 0, file: File(url: "https://firebasestorage.googleapis.com/v0/b/tinderdemo-497b9.appspot.com/o/dummyUser-3.png?alt=media&token=c8d56ce7-f636-4942-a939-91367052480e")),
                                UserProfileImage(sort: 0, file: File(url: "https://firebasestorage.googleapis.com/v0/b/tinderdemo-497b9.appspot.com/o/dummyUser-4.png?alt=media&token=144e3abe-d17f-4fa6-9a7c-8670ad3157db"))
                            ],
                            interests: [
                                Constants.sport[1],
                                Constants.sport[4],
                                Constants.sport[7],
                                Constants.sport[2],
                                Constants.sport[0],
                                Constants.interests[0],
                            ],
                            age: 25
                           )
        ),
        
        
        User(
            id: "4",
            userProfile:
                UserProfile(id: "4",
                            name: "Squidward",
                            birthYear: 1998,
                            height: 176,
                            weight: 78,
                            bio: "저희 3명이고, 테이블 잡음, 술 있음",
                            gender: "male",
                            images: [
                                UserProfileImage(sort: 0, file: File(url: "https://firebasestorage.googleapis.com/v0/b/tinderdemo-497b9.appspot.com/o/person-3.jpeg?alt=media&token=f4910ba0-2842-4b13-a8ed-38a9c098e63c")),
                                UserProfileImage(sort: 0, file: File(url: "https://firebasestorage.googleapis.com/v0/b/tinderdemo-497b9.appspot.com/o/dummyUser-2.png?alt=media&token=52de63e4-cc28-40b3-b987-04c3a80b3fc9")),
                                UserProfileImage(sort: 0, file: File(url: "https://firebasestorage.googleapis.com/v0/b/tinderdemo-497b9.appspot.com/o/dummyUser-3.png?alt=media&token=c8d56ce7-f636-4942-a939-91367052480e")),
                                UserProfileImage(sort: 0, file: File(url: "https://firebasestorage.googleapis.com/v0/b/tinderdemo-497b9.appspot.com/o/dummyUser-4.png?alt=media&token=144e3abe-d17f-4fa6-9a7c-8670ad3157db"))
                            ],
                            interests: [],
                            age: 26
                           )
        ),
        
        User(
            id: "5",
            userProfile:
                UserProfile(id: "5",
                            name: "Sandy Cheeks",
                            birthYear: 1997,
                            height: 176,
                            weight: 78,
                            bio: "저희 3명이고, 테이블 잡음, 술 있음",
                            gender: "female",
                            images: [
                                UserProfileImage(sort: 0, file: File(url: "https://firebasestorage.googleapis.com/v0/b/tinderdemo-497b9.appspot.com/o/person-4.jpeg?alt=media&token=354eecdc-be34-4a26-b7f8-2aff6e5342fb")),
                                UserProfileImage(sort: 0, file: File(url: "https://firebasestorage.googleapis.com/v0/b/tinderdemo-497b9.appspot.com/o/dummyUser-2.png?alt=media&token=52de63e4-cc28-40b3-b987-04c3a80b3fc9")),
                                UserProfileImage(sort: 0, file: File(url: "https://firebasestorage.googleapis.com/v0/b/tinderdemo-497b9.appspot.com/o/dummyUser-3.png?alt=media&token=c8d56ce7-f636-4942-a939-91367052480e")),
                                UserProfileImage(sort: 0, file: File(url: "https://firebasestorage.googleapis.com/v0/b/tinderdemo-497b9.appspot.com/o/dummyUser-4.png?alt=media&token=144e3abe-d17f-4fa6-9a7c-8670ad3157db"))
                            ],
                            interests: [],
                            age: 27
                           )
        ),
        
        User(
            id: "6",
            userProfile:
                UserProfile(id: "6",
                            name: "Eugene Krabs",
                            birthYear: 2000,
                            height: 176,
                            weight: 78,
                            bio: "저희 3명이고, 테이블 잡음, 술 있음",
                            gender: "female",
                            images: [
                                UserProfileImage(sort: 0, file: File(url: "https://firebasestorage.googleapis.com/v0/b/tinderdemo-497b9.appspot.com/o/dummyUser-1.png?alt=media&token=426686d7-5cc7-4c9d-9de8-6a87c0f28a7b")),
                                UserProfileImage(sort: 0, file: File(url: "https://firebasestorage.googleapis.com/v0/b/tinderdemo-497b9.appspot.com/o/dummyUser-2.png?alt=media&token=52de63e4-cc28-40b3-b987-04c3a80b3fc9")),
                                UserProfileImage(sort: 0, file: File(url: "https://firebasestorage.googleapis.com/v0/b/tinderdemo-497b9.appspot.com/o/dummyUser-3.png?alt=media&token=c8d56ce7-f636-4942-a939-91367052480e")),
                                UserProfileImage(sort: 0, file: File(url: "https://firebasestorage.googleapis.com/v0/b/tinderdemo-497b9.appspot.com/o/dummyUser-4.png?alt=media&token=144e3abe-d17f-4fa6-9a7c-8670ad3157db"))
                            ],
                            interests: [],
                            age: 24
                           )
        ),
    ]
    
    static let userProfiles: [UserProfile] = [
        UserProfile(id: "1",
                    name: "Eugene Krabs",
                    birthYear: 2000,
                    height: 176,
                    weight: 78,
                    mbti: mbtiE.INFP.rawValue,
                    education: "사무직",
                    occupation: "학사/박사",
                    bio: "저희 3명이고, 테이블 잡음, 술 있음",
                    gender: "female",
                    images: [
                        UserProfileImage(sort: 0, file: File(url: "https://firebasestorage.googleapis.com/v0/b/tinderdemo-497b9.appspot.com/o/dummyUser-1.png?alt=media&token=426686d7-5cc7-4c9d-9de8-6a87c0f28a7b")),
                        UserProfileImage(sort: 0, file: File(url: "https://firebasestorage.googleapis.com/v0/b/tinderdemo-497b9.appspot.com/o/dummyUser-2.png?alt=media&token=52de63e4-cc28-40b3-b987-04c3a80b3fc9")),
                        UserProfileImage(sort: 0, file: File(url: "https://firebasestorage.googleapis.com/v0/b/tinderdemo-497b9.appspot.com/o/dummyUser-3.png?alt=media&token=c8d56ce7-f636-4942-a939-91367052480e")),
                        UserProfileImage(sort: 0, file: File(url: "https://firebasestorage.googleapis.com/v0/b/tinderdemo-497b9.appspot.com/o/dummyUser-4.png?alt=media&token=144e3abe-d17f-4fa6-9a7c-8670ad3157db"))
                    ],
                    interests: [
                        Constants.sport[1],
                        Constants.sport[4],
                        Constants.sport[7],
                        Constants.sport[2],
                        Constants.sport[0],
                        Constants.interests[0],
                    ],
                    age: 24
                   ),
        UserProfile(id: "2",
                    name: "SpongeBob SquarePants",
                    birthYear: 2001,
                    height: 176,
                    weight: 78,
                    mbti: mbtiE.INFP.rawValue,
                    education: "사무직",
                    occupation: "학사/박사",
                    bio: "저희 3명이고, 테이블 잡음, 술 있음",
                    gender: "male",
                    images: [
                        UserProfileImage(sort: 0, file: File(url: "https://firebasestorage.googleapis.com/v0/b/tinderdemo-497b9.appspot.com/o/person-1.jpeg?alt=media&token=06896c71-dabf-4262-8948-77015fab150e")),
                        UserProfileImage(sort: 0, file: File(url: "https://firebasestorage.googleapis.com/v0/b/tinderdemo-497b9.appspot.com/o/dummyUser-2.png?alt=media&token=52de63e4-cc28-40b3-b987-04c3a80b3fc9")),
                        UserProfileImage(sort: 0, file: File(url: "https://firebasestorage.googleapis.com/v0/b/tinderdemo-497b9.appspot.com/o/dummyUser-3.png?alt=media&token=c8d56ce7-f636-4942-a939-91367052480e")),
                        UserProfileImage(sort: 0, file: File(url: "https://firebasestorage.googleapis.com/v0/b/tinderdemo-497b9.appspot.com/o/dummyUser-4.png?alt=media&token=144e3abe-d17f-4fa6-9a7c-8670ad3157db"))
                    ],
                    interests: [
                        Constants.sport[1],
                        Constants.sport[4],
                        Constants.sport[7],
                        Constants.sport[2],
                        Constants.sport[0],
                        Constants.interests[0],
                    ],
                    age: 23
                    
                   ),
        UserProfile(id: "3",
                    name: "Patric Star",
                    birthYear: 1999,
                    height: 176,
                    weight: 78,
                    mbti: mbtiE.INFP.rawValue,
                    education: "사무직",
                    occupation: "학사/박사",
                    bio: "저희 3명이고, 테이블 잡음, 술 있음",
                    gender: "female",
                    images: [
                        UserProfileImage(sort: 0, file: File(url: "https://firebasestorage.googleapis.com/v0/b/tinderdemo-497b9.appspot.com/o/person-2.jpeg?alt=media&token=5f6f4728-0ddc-4f9d-9991-7b3cb31deff2")),
                        UserProfileImage(sort: 0, file: File(url: "https://firebasestorage.googleapis.com/v0/b/tinderdemo-497b9.appspot.com/o/dummyUser-2.png?alt=media&token=52de63e4-cc28-40b3-b987-04c3a80b3fc9")),
                        UserProfileImage(sort: 0, file: File(url: "https://firebasestorage.googleapis.com/v0/b/tinderdemo-497b9.appspot.com/o/dummyUser-3.png?alt=media&token=c8d56ce7-f636-4942-a939-91367052480e")),
                        UserProfileImage(sort: 0, file: File(url: "https://firebasestorage.googleapis.com/v0/b/tinderdemo-497b9.appspot.com/o/dummyUser-4.png?alt=media&token=144e3abe-d17f-4fa6-9a7c-8670ad3157db"))
                    ],
                    interests: [
                        Constants.sport[1],
                        Constants.sport[4],
                        Constants.sport[7],
                        Constants.sport[2],
                        Constants.sport[0],
                        Constants.interests[0],
                    ],
                    age: 25
                   ),
        UserProfile(id: "4",
                    name: "Squidward",
                    birthYear: 1998,
                    height: 176,
                    weight: 78,
                    bio: "저희 3명이고, 테이블 잡음, 술 있음",
                    gender: "male",
                    images: [
                        UserProfileImage(sort: 0, file: File(url: "https://firebasestorage.googleapis.com/v0/b/tinderdemo-497b9.appspot.com/o/person-3.jpeg?alt=media&token=f4910ba0-2842-4b13-a8ed-38a9c098e63c")),
                        UserProfileImage(sort: 0, file: File(url: "https://firebasestorage.googleapis.com/v0/b/tinderdemo-497b9.appspot.com/o/dummyUser-2.png?alt=media&token=52de63e4-cc28-40b3-b987-04c3a80b3fc9")),
                        UserProfileImage(sort: 0, file: File(url: "https://firebasestorage.googleapis.com/v0/b/tinderdemo-497b9.appspot.com/o/dummyUser-3.png?alt=media&token=c8d56ce7-f636-4942-a939-91367052480e")),
                        UserProfileImage(sort: 0, file: File(url: "https://firebasestorage.googleapis.com/v0/b/tinderdemo-497b9.appspot.com/o/dummyUser-4.png?alt=media&token=144e3abe-d17f-4fa6-9a7c-8670ad3157db"))
                    ],
                    interests: [],
                    age: 26
                   ),
        UserProfile(id: "5",
                    name: "Sandy Cheeks",
                    birthYear: 1997,
                    height: 176,
                    weight: 78,
                    bio: "저희 3명이고, 테이블 잡음, 술 있음",
                    gender: "female",
                    images: [
                        UserProfileImage(sort: 0, file: File(url: "https://firebasestorage.googleapis.com/v0/b/tinderdemo-497b9.appspot.com/o/person-4.jpeg?alt=media&token=354eecdc-be34-4a26-b7f8-2aff6e5342fb")),
                        UserProfileImage(sort: 0, file: File(url: "https://firebasestorage.googleapis.com/v0/b/tinderdemo-497b9.appspot.com/o/dummyUser-2.png?alt=media&token=52de63e4-cc28-40b3-b987-04c3a80b3fc9")),
                        UserProfileImage(sort: 0, file: File(url: "https://firebasestorage.googleapis.com/v0/b/tinderdemo-497b9.appspot.com/o/dummyUser-3.png?alt=media&token=c8d56ce7-f636-4942-a939-91367052480e")),
                        UserProfileImage(sort: 0, file: File(url: "https://firebasestorage.googleapis.com/v0/b/tinderdemo-497b9.appspot.com/o/dummyUser-4.png?alt=media&token=144e3abe-d17f-4fa6-9a7c-8670ad3157db"))
                    ],
                    interests: [],
                    age: 27
                   ),
        UserProfile(id: "6",
                    name: "Eugene Krabs",
                    birthYear: 2000,
                    height: 176,
                    weight: 78,
                    bio: "저희 3명이고, 테이블 잡음, 술 있음",
                    gender: "female",
                    images: [
                        UserProfileImage(sort: 0, file: File(url: "https://firebasestorage.googleapis.com/v0/b/tinderdemo-497b9.appspot.com/o/dummyUser-1.png?alt=media&token=426686d7-5cc7-4c9d-9de8-6a87c0f28a7b")),
                        UserProfileImage(sort: 0, file: File(url: "https://firebasestorage.googleapis.com/v0/b/tinderdemo-497b9.appspot.com/o/dummyUser-2.png?alt=media&token=52de63e4-cc28-40b3-b987-04c3a80b3fc9")),
                        UserProfileImage(sort: 0, file: File(url: "https://firebasestorage.googleapis.com/v0/b/tinderdemo-497b9.appspot.com/o/dummyUser-3.png?alt=media&token=c8d56ce7-f636-4942-a939-91367052480e")),
                        UserProfileImage(sort: 0, file: File(url: "https://firebasestorage.googleapis.com/v0/b/tinderdemo-497b9.appspot.com/o/dummyUser-4.png?alt=media&token=144e3abe-d17f-4fa6-9a7c-8670ad3157db"))
                    ],
                    interests: [],
                    age: 24
                   ),
    ]
}
