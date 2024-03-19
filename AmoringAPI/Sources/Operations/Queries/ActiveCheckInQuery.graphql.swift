// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class ActiveCheckInQuery: GraphQLQuery {
  public static let operationName: String = "ActiveCheckIn"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query ActiveCheckIn { activeCheckIn { __typename ...CheckInInfo } }"#,
      fragments: [BusinessHoursInfo.self, BusinessInfo.self, CheckInInfo.self, ImageFragment.self, ProfileInfo.self]
    ))

  public init() {}

  public struct Data: AmoringAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("activeCheckIn", ActiveCheckIn?.self),
    ] }

    public var activeCheckIn: ActiveCheckIn? { __data["activeCheckIn"] }

    /// ActiveCheckIn
    ///
    /// Parent Type: `CheckIn`
    public struct ActiveCheckIn: AmoringAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.CheckIn }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .fragment(CheckInInfo.self),
      ] }

      public var id: AmoringAPI.ID { __data["id"] }
      public var businessId: String { __data["businessId"] }
      public var business: Business? { __data["business"] }
      public var profileId: String { __data["profileId"] }
      public var profile: Profile? { __data["profile"] }
      public var status: GraphQLEnum<AmoringAPI.CheckInStatus> { __data["status"] }
      public var checkedInAt: AmoringAPI.DateTime? { __data["checkedInAt"] }
      public var checkedOutAt: AmoringAPI.DateTime? { __data["checkedOutAt"] }
      public var createdAt: AmoringAPI.DateTime { __data["createdAt"] }
      public var updatedAt: AmoringAPI.DateTime { __data["updatedAt"] }

      public struct Fragments: FragmentContainer {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public var checkInInfo: CheckInInfo { _toFragment() }
      }

      /// ActiveCheckIn.Business
      ///
      /// Parent Type: `Business`
      public struct Business: AmoringAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Business }

        public var id: AmoringAPI.ID { __data["id"] }
        public var ownerId: String? { __data["ownerId"] }
        public var businessName: String? { __data["businessName"] }
        public var businessType: String? { __data["businessType"] }
        public var businessIndustry: String? { __data["businessIndustry"] }
        public var businessCategory: String? { __data["businessCategory"] }
        public var businessHours: [BusinessHour?]? { __data["businessHours"] }
        public var address: String? { __data["address"] }
        public var addressBname: String? { __data["addressBname"] }
        public var addressDetails: String? { __data["addressDetails"] }
        public var addressJibun: String? { __data["addressJibun"] }
        public var addressSido: String? { __data["addressSido"] }
        public var addressSigungu: String? { __data["addressSigungu"] }
        public var addressSigunguCode: String? { __data["addressSigunguCode"] }
        public var addressSigunguEnglish: String? { __data["addressSigunguEnglish"] }
        public var addressZonecode: String? { __data["addressZonecode"] }
        public var bio: String? { __data["bio"] }
        public var representativeTitle: String? { __data["representativeTitle"] }
        public var representativeName: String? { __data["representativeName"] }
        public var phoneNumber: String? { __data["phoneNumber"] }
        public var registrationNumber: String? { __data["registrationNumber"] }
        public var images: [Image?]? { __data["images"] }
        public var activeCheckIns: [ActiveCheckIn?] { __data["activeCheckIns"] }
        public var latitude: Double? { __data["latitude"] }
        public var longitude: Double? { __data["longitude"] }
        public var createdAt: AmoringAPI.DateTime? { __data["createdAt"] }
        public var updatedAt: AmoringAPI.DateTime? { __data["updatedAt"] }

        public struct Fragments: FragmentContainer {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public var businessInfo: BusinessInfo { _toFragment() }
        }

        /// ActiveCheckIn.Business.BusinessHour
        ///
        /// Parent Type: `BusinessHours`
        public struct BusinessHour: AmoringAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.BusinessHours }

          public var openAt: AmoringAPI.LocalTime { __data["openAt"] }
          public var closeAt: AmoringAPI.LocalTime { __data["closeAt"] }
          public var day: GraphQLEnum<AmoringAPI.Day> { __data["day"] }

          public struct Fragments: FragmentContainer {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public var businessHoursInfo: BusinessHoursInfo { _toFragment() }
          }
        }

        public typealias Image = BusinessInfo.Image

        public typealias ActiveCheckIn = BusinessInfo.ActiveCheckIn
      }

      /// ActiveCheckIn.Profile
      ///
      /// Parent Type: `Profile`
      public struct Profile: AmoringAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Profile }

        public var id: AmoringAPI.ID { __data["id"] }
        public var userId: String { __data["userId"] }
        public var name: String? { __data["name"] }
        public var age: Int? { __data["age"] }
        public var avatarUrl: String? { __data["avatarUrl"] }
        public var birthYear: Int? { __data["birthYear"] }
        public var height: Int? { __data["height"] }
        public var weight: Int? { __data["weight"] }
        public var mbti: String? { __data["mbti"] }
        public var education: String? { __data["education"] }
        public var occupation: String? { __data["occupation"] }
        public var bio: String? { __data["bio"] }
        public var gender: GraphQLEnum<AmoringAPI.Gender>? { __data["gender"] }
        public var images: [Image?]? { __data["images"] }
        public var interests: [Interest?]? { __data["interests"] }
        public var createdAt: AmoringAPI.DateTime? { __data["createdAt"] }
        public var updatedAt: AmoringAPI.DateTime? { __data["updatedAt"] }

        public struct Fragments: FragmentContainer {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public var profileInfo: ProfileInfo { _toFragment() }
        }

        /// ActiveCheckIn.Profile.Image
        ///
        /// Parent Type: `ProfileImage`
        public struct Image: AmoringAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.ProfileImage }

          public var id: AmoringAPI.ID { __data["id"] }
          public var file: File { __data["file"] }

          public struct Fragments: FragmentContainer {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public var imageFragment: ImageFragment { _toFragment() }
          }

          public typealias File = ImageFragment.File
        }

        public typealias Interest = ProfileInfo.Interest
      }
    }
  }
}
