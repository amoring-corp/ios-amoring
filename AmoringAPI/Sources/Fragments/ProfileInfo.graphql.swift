// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public struct ProfileInfo: AmoringAPI.SelectionSet, Fragment {
  public static var fragmentDefinition: StaticString {
    #"fragment ProfileInfo on Profile { __typename id userId name age avatarUrl birthYear height weight mbti education occupation bio gender activeCheckIn { __typename ...CheckInInfo } images { __typename ...ImageFragment } interests { __typename id name category { __typename id createdAt interests { __typename id name } name updatedAt } categoryId createdAt updatedAt } createdAt updatedAt usedLikesCount maxLikes }"#
  }

  public let __data: DataDict
  public init(_dataDict: DataDict) { __data = _dataDict }

  public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Profile }
  public static var __selections: [ApolloAPI.Selection] { [
    .field("__typename", String.self),
    .field("id", AmoringAPI.ID.self),
    .field("userId", String.self),
    .field("name", String?.self),
    .field("age", Int?.self),
    .field("avatarUrl", String?.self),
    .field("birthYear", Int?.self),
    .field("height", Int?.self),
    .field("weight", Int?.self),
    .field("mbti", String?.self),
    .field("education", String?.self),
    .field("occupation", String?.self),
    .field("bio", String?.self),
    .field("gender", GraphQLEnum<AmoringAPI.Gender>?.self),
    .field("activeCheckIn", ActiveCheckIn?.self),
    .field("images", [Image?]?.self),
    .field("interests", [Interest?]?.self),
    .field("createdAt", AmoringAPI.DateTime?.self),
    .field("updatedAt", AmoringAPI.DateTime?.self),
    .field("usedLikesCount", Int.self),
    .field("maxLikes", Int.self),
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
      public var createdAt: AmoringAPI.DateTime? { __data["createdAt"] }
      public var updatedAt: AmoringAPI.DateTime? { __data["updatedAt"] }

      public struct Fragments: FragmentContainer {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public var businessInfo: BusinessInfo { _toFragment() }
      }

      public typealias BusinessType = BusinessInfo.BusinessType

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

      public typealias ActiveCheckIn = BusinessInfo.ActiveCheckIn

      public typealias Image = BusinessInfo.Image
    }
  }

  /// Image
  ///
  /// Parent Type: `ProfileImage`
  public struct Image: AmoringAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.ProfileImage }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("__typename", String.self),
      .fragment(ImageFragment.self),
    ] }

    public var id: AmoringAPI.ID { __data["id"] }
    public var file: File? { __data["file"] }

    public struct Fragments: FragmentContainer {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public var imageFragment: ImageFragment { _toFragment() }
    }

    public typealias File = ImageFragment.File
  }

  /// Interest
  ///
  /// Parent Type: `Interest`
  public struct Interest: AmoringAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Interest }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("__typename", String.self),
      .field("id", AmoringAPI.ID.self),
      .field("name", String?.self),
      .field("category", Category?.self),
      .field("categoryId", String.self),
      .field("createdAt", AmoringAPI.DateTime?.self),
      .field("updatedAt", AmoringAPI.DateTime?.self),
    ] }

    public var id: AmoringAPI.ID { __data["id"] }
    public var name: String? { __data["name"] }
    public var category: Category? { __data["category"] }
    public var categoryId: String { __data["categoryId"] }
    public var createdAt: AmoringAPI.DateTime? { __data["createdAt"] }
    public var updatedAt: AmoringAPI.DateTime? { __data["updatedAt"] }

    /// Interest.Category
    ///
    /// Parent Type: `InterestCategory`
    public struct Category: AmoringAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.InterestCategory }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("id", AmoringAPI.ID.self),
        .field("createdAt", AmoringAPI.DateTime?.self),
        .field("interests", [Interest?]?.self),
        .field("name", String?.self),
        .field("updatedAt", AmoringAPI.DateTime?.self),
      ] }

      public var id: AmoringAPI.ID { __data["id"] }
      public var createdAt: AmoringAPI.DateTime? { __data["createdAt"] }
      public var interests: [Interest?]? { __data["interests"] }
      public var name: String? { __data["name"] }
      public var updatedAt: AmoringAPI.DateTime? { __data["updatedAt"] }

      /// Interest.Category.Interest
      ///
      /// Parent Type: `Interest`
      public struct Interest: AmoringAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Interest }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", AmoringAPI.ID.self),
          .field("name", String?.self),
        ] }

        public var id: AmoringAPI.ID { __data["id"] }
        public var name: String? { __data["name"] }
      }
    }
  }
}
