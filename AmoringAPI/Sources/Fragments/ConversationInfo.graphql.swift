// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public struct ConversationInfo: AmoringAPI.SelectionSet, Fragment {
  public static var fragmentDefinition: StaticString {
    #"fragment ConversationInfo on Conversation { __typename id status checkIns { __typename ...CheckInInfo } participants { __typename ...UserInfo } messages(take: 100, skip: 0) { __typename ...MessageInfo } createdAt archivedAt updatedAt }"#
  }

  public let __data: DataDict
  public init(_dataDict: DataDict) { __data = _dataDict }

  public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Conversation }
  public static var __selections: [ApolloAPI.Selection] { [
    .field("__typename", String.self),
    .field("id", AmoringAPI.ID.self),
    .field("status", GraphQLEnum<AmoringAPI.ConversationStatus>.self),
    .field("checkIns", [CheckIn?].self),
    .field("participants", [Participant?].self),
    .field("messages", [Message?].self, arguments: [
      "take": 100,
      "skip": 0
    ]),
    .field("createdAt", AmoringAPI.DateTime?.self),
    .field("archivedAt", AmoringAPI.DateTime?.self),
    .field("updatedAt", AmoringAPI.DateTime?.self),
  ] }

  public var id: AmoringAPI.ID { __data["id"] }
  public var status: GraphQLEnum<AmoringAPI.ConversationStatus> { __data["status"] }
  public var checkIns: [CheckIn?] { __data["checkIns"] }
  public var participants: [Participant?] { __data["participants"] }
  public var messages: [Message?] { __data["messages"] }
  public var createdAt: AmoringAPI.DateTime? { __data["createdAt"] }
  public var archivedAt: AmoringAPI.DateTime? { __data["archivedAt"] }
  public var updatedAt: AmoringAPI.DateTime? { __data["updatedAt"] }

  /// CheckIn
  ///
  /// Parent Type: `CheckIn`
  public struct CheckIn: AmoringAPI.SelectionSet {
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
    public var status: GraphQLEnum<AmoringAPI.CheckInStatus> { __data["status"] }
    public var hasTable: Bool { __data["hasTable"] }
    public var checkedInAt: AmoringAPI.DateTime? { __data["checkedInAt"] }
    public var checkedOutAt: AmoringAPI.DateTime? { __data["checkedOutAt"] }
    public var createdAt: AmoringAPI.DateTime { __data["createdAt"] }
    public var updatedAt: AmoringAPI.DateTime { __data["updatedAt"] }

    public struct Fragments: FragmentContainer {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public var checkInInfo: CheckInInfo { _toFragment() }
    }

    /// CheckIn.Business
    ///
    /// Parent Type: `Business`
    public struct Business: AmoringAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Business }

      public var id: AmoringAPI.ID { __data["id"] }
      public var ownerId: String? { __data["ownerId"] }
      public var businessName: String? { __data["businessName"] }
      public var businessType: BusinessType? { __data["businessType"] }
      public var businessIndustry: String? { __data["businessIndustry"] }
      public var businessCategory: String? { __data["businessCategory"] }
      public var businessHours: [BusinessHour?]? { __data["businessHours"] }
      public var activeCheckIns: [ActiveCheckIn?] { __data["activeCheckIns"] }
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
      public var lat: Double? { __data["lat"] }
      public var lng: Double? { __data["lng"] }
      public var isActive: Bool? { __data["isActive"] }
      public var createdAt: AmoringAPI.DateTime? { __data["createdAt"] }
      public var updatedAt: AmoringAPI.DateTime? { __data["updatedAt"] }

      public struct Fragments: FragmentContainer {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public var businessInfo: BusinessInfo { _toFragment() }
      }

      public typealias BusinessType = BusinessInfo.BusinessType

      /// CheckIn.Business.BusinessHour
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

      public typealias ActiveCheckIn = BusinessInfo.ActiveCheckIn

      public typealias Image = BusinessInfo.Image
    }
  }

  /// Participant
  ///
  /// Parent Type: `User`
  public struct Participant: AmoringAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.User }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("__typename", String.self),
      .fragment(UserInfo.self),
    ] }

    public var id: AmoringAPI.ID { __data["id"] }
    public var email: String? { __data["email"] }
    public var status: GraphQLEnum<AmoringAPI.UserStatus>? { __data["status"] }
    public var role: GraphQLEnum<AmoringAPI.UserRole>? { __data["role"] }
    public var profile: Profile? { __data["profile"] }
    public var business: Business? { __data["business"] }
    public var createdAt: AmoringAPI.DateTime? { __data["createdAt"] }
    public var updatedAt: AmoringAPI.DateTime? { __data["updatedAt"] }
    public var usedLikesCount: Int { __data["usedLikesCount"] }
    public var maxLikes: Int { __data["maxLikes"] }
    public var likesCredit: Int? { __data["likesCredit"] }
    public var loungePassExpiredAt: AmoringAPI.DateTime? { __data["loungePassExpiredAt"] }
    public var invisiblePassExpiredAt: AmoringAPI.DateTime? { __data["invisiblePassExpiredAt"] }
    public var visibleReactionsPassExpiredAt: AmoringAPI.DateTime? { __data["visibleReactionsPassExpiredAt"] }
    public var isPhoneNumberVerified: Bool? { __data["isPhoneNumberVerified"] }
    public var isEmailVerified: Bool? { __data["isEmailVerified"] }
    public var activeCoupons: [ActiveCoupon?]? { __data["activeCoupons"] }

    public struct Fragments: FragmentContainer {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public var userInfo: UserInfo { _toFragment() }
    }

    /// Participant.Profile
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
      public var activeCheckIn: ActiveCheckIn? { __data["activeCheckIn"] }
      public var images: [Image?]? { __data["images"] }
      public var interests: [Interest?]? { __data["interests"] }
      public var createdAt: AmoringAPI.DateTime? { __data["createdAt"] }
      public var updatedAt: AmoringAPI.DateTime? { __data["updatedAt"] }
      @available(*, deprecated, message: "Use field from User instead")
      public var usedLikesCount: Int { __data["usedLikesCount"] }
      @available(*, deprecated, message: "Use field from User instead")
      public var maxLikes: Int { __data["maxLikes"] }
      public var isBlurred: Bool? { __data["isBlurred"] }

      public struct Fragments: FragmentContainer {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public var profileInfo: ProfileInfo { _toFragment() }
      }

      /// Participant.Profile.ActiveCheckIn
      ///
      /// Parent Type: `CheckIn`
      public struct ActiveCheckIn: AmoringAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.CheckIn }

        public var id: AmoringAPI.ID { __data["id"] }
        public var businessId: String { __data["businessId"] }
        public var business: Business? { __data["business"] }
        public var profileId: String { __data["profileId"] }
        public var status: GraphQLEnum<AmoringAPI.CheckInStatus> { __data["status"] }
        public var hasTable: Bool { __data["hasTable"] }
        public var checkedInAt: AmoringAPI.DateTime? { __data["checkedInAt"] }
        public var checkedOutAt: AmoringAPI.DateTime? { __data["checkedOutAt"] }
        public var createdAt: AmoringAPI.DateTime { __data["createdAt"] }
        public var updatedAt: AmoringAPI.DateTime { __data["updatedAt"] }

        public struct Fragments: FragmentContainer {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public var checkInInfo: CheckInInfo { _toFragment() }
        }

        /// Participant.Profile.ActiveCheckIn.Business
        ///
        /// Parent Type: `Business`
        public struct Business: AmoringAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Business }

          public var id: AmoringAPI.ID { __data["id"] }
          public var ownerId: String? { __data["ownerId"] }
          public var businessName: String? { __data["businessName"] }
          public var businessType: BusinessType? { __data["businessType"] }
          public var businessIndustry: String? { __data["businessIndustry"] }
          public var businessCategory: String? { __data["businessCategory"] }
          public var businessHours: [BusinessHour?]? { __data["businessHours"] }
          public var activeCheckIns: [ActiveCheckIn?] { __data["activeCheckIns"] }
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
          public var lat: Double? { __data["lat"] }
          public var lng: Double? { __data["lng"] }
          public var isActive: Bool? { __data["isActive"] }
          public var createdAt: AmoringAPI.DateTime? { __data["createdAt"] }
          public var updatedAt: AmoringAPI.DateTime? { __data["updatedAt"] }

          public struct Fragments: FragmentContainer {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public var businessInfo: BusinessInfo { _toFragment() }
          }

          public typealias BusinessType = BusinessInfo.BusinessType

          /// Participant.Profile.ActiveCheckIn.Business.BusinessHour
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

          public typealias ActiveCheckIn = BusinessInfo.ActiveCheckIn

          public typealias Image = BusinessInfo.Image
        }
      }

      /// Participant.Profile.Image
      ///
      /// Parent Type: `ProfileImage`
      public struct Image: AmoringAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.ProfileImage }

        public var id: AmoringAPI.ID { __data["id"] }
        public var file: File? { __data["file"] }

        public struct Fragments: FragmentContainer {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public var imageFragment: ImageFragment { _toFragment() }
        }

        public typealias File = ImageFragment.File
      }

      public typealias Interest = ProfileInfo.Interest
    }

    /// Participant.Business
    ///
    /// Parent Type: `Business`
    public struct Business: AmoringAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Business }

      public var id: AmoringAPI.ID { __data["id"] }
      public var ownerId: String? { __data["ownerId"] }
      public var businessName: String? { __data["businessName"] }
      public var businessType: BusinessType? { __data["businessType"] }
      public var businessIndustry: String? { __data["businessIndustry"] }
      public var businessCategory: String? { __data["businessCategory"] }
      public var businessHours: [BusinessHour?]? { __data["businessHours"] }
      public var activeCheckIns: [ActiveCheckIn?] { __data["activeCheckIns"] }
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
      public var lat: Double? { __data["lat"] }
      public var lng: Double? { __data["lng"] }
      public var isActive: Bool? { __data["isActive"] }
      public var createdAt: AmoringAPI.DateTime? { __data["createdAt"] }
      public var updatedAt: AmoringAPI.DateTime? { __data["updatedAt"] }

      public struct Fragments: FragmentContainer {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public var businessInfo: BusinessInfo { _toFragment() }
      }

      public typealias BusinessType = BusinessInfo.BusinessType

      /// Participant.Business.BusinessHour
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

      public typealias ActiveCheckIn = BusinessInfo.ActiveCheckIn

      public typealias Image = BusinessInfo.Image
    }

    /// Participant.ActiveCoupon
    ///
    /// Parent Type: `ActiveCoupon`
    public struct ActiveCoupon: AmoringAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.ActiveCoupon }

      public var id: String { __data["id"] }
      public var coupon: Coupon { __data["coupon"] }
      public var expiredAt: AmoringAPI.DateTime? { __data["expiredAt"] }

      public struct Fragments: FragmentContainer {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public var activeCouponFragment: ActiveCouponFragment { _toFragment() }
      }

      /// Participant.ActiveCoupon.Coupon
      ///
      /// Parent Type: `Coupon`
      public struct Coupon: AmoringAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Coupon }

        public var category: String { __data["category"] }
        public var name: String { __data["name"] }
        public var shortDescription: String { __data["shortDescription"] }
        public var description: String { __data["description"] }
        public var validFrom: AmoringAPI.DateTime? { __data["validFrom"] }
        public var validUntil: AmoringAPI.DateTime? { __data["validUntil"] }

        public struct Fragments: FragmentContainer {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public var couponFragment: CouponFragment { _toFragment() }
        }
      }
    }
  }

  /// Message
  ///
  /// Parent Type: `Message`
  public struct Message: AmoringAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Message }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("__typename", String.self),
      .fragment(MessageInfo.self),
    ] }

    public var id: AmoringAPI.ID { __data["id"] }
    public var conversationId: String? { __data["conversationId"] }
    public var body: String { __data["body"] }
    public var senderId: String? { __data["senderId"] }
    public var senderAvatarUrl: String? { __data["senderAvatarUrl"] }
    public var senderName: String? { __data["senderName"] }
    public var sender: Sender? { __data["sender"] }
    public var createdAt: AmoringAPI.DateTime? { __data["createdAt"] }
    public var updatedAt: AmoringAPI.DateTime? { __data["updatedAt"] }

    public struct Fragments: FragmentContainer {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public var messageInfo: MessageInfo { _toFragment() }
    }

    public typealias Sender = MessageInfo.Sender
  }
}
