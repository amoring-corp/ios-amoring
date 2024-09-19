// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public struct UserInfo: AmoringAPI.SelectionSet, Fragment {
  public static var fragmentDefinition: StaticString {
    #"fragment UserInfo on User { __typename id email status role profile { __typename ...ProfileInfo } business { __typename ...BusinessInfo } createdAt updatedAt usedLikesCount maxLikes likesCredit loungePassExpiredAt invisiblePassExpiredAt visibleReactionsPassExpiredAt isPhoneNumberVerified isEmailVerified activeCoupons { __typename ...ActiveCouponFragment } }"#
  }

  public let __data: DataDict
  public init(_dataDict: DataDict) { __data = _dataDict }

  public static var __parentType: any ApolloAPI.ParentType { AmoringAPI.Objects.User }
  public static var __selections: [ApolloAPI.Selection] { [
    .field("__typename", String.self),
    .field("id", AmoringAPI.ID.self),
    .field("email", String?.self),
    .field("status", GraphQLEnum<AmoringAPI.UserStatus>?.self),
    .field("role", GraphQLEnum<AmoringAPI.UserRole>?.self),
    .field("profile", Profile?.self),
    .field("business", Business?.self),
    .field("createdAt", AmoringAPI.DateTime?.self),
    .field("updatedAt", AmoringAPI.DateTime?.self),
    .field("usedLikesCount", Int.self),
    .field("maxLikes", Int.self),
    .field("likesCredit", Int?.self),
    .field("loungePassExpiredAt", AmoringAPI.DateTime?.self),
    .field("invisiblePassExpiredAt", AmoringAPI.DateTime?.self),
    .field("visibleReactionsPassExpiredAt", AmoringAPI.DateTime?.self),
    .field("isPhoneNumberVerified", Bool?.self),
    .field("isEmailVerified", Bool?.self),
    .field("activeCoupons", [ActiveCoupon?]?.self),
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

  /// Profile
  ///
  /// Parent Type: `Profile`
  public struct Profile: AmoringAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { AmoringAPI.Objects.Profile }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("__typename", String.self),
      .fragment(ProfileInfo.self),
    ] }

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

    public typealias ActiveCheckIn = ProfileInfo.ActiveCheckIn

    public typealias Image = ProfileInfo.Image

    public typealias Interest = ProfileInfo.Interest
  }

  /// Business
  ///
  /// Parent Type: `Business`
  public struct Business: AmoringAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { AmoringAPI.Objects.Business }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("__typename", String.self),
      .fragment(BusinessInfo.self),
    ] }

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

    public typealias BusinessHour = BusinessInfo.BusinessHour

    public typealias ActiveCheckIn = BusinessInfo.ActiveCheckIn

    public typealias Image = BusinessInfo.Image
  }

  /// ActiveCoupon
  ///
  /// Parent Type: `ActiveCoupon`
  public struct ActiveCoupon: AmoringAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { AmoringAPI.Objects.ActiveCoupon }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("__typename", String.self),
      .fragment(ActiveCouponFragment.self),
    ] }

    public var id: String { __data["id"] }
    public var coupon: Coupon { __data["coupon"] }
    public var expiredAt: AmoringAPI.DateTime? { __data["expiredAt"] }

    public struct Fragments: FragmentContainer {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public var activeCouponFragment: ActiveCouponFragment { _toFragment() }
    }

    public typealias Coupon = ActiveCouponFragment.Coupon
  }
}
