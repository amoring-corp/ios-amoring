// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public struct BusinessInfo: AmoringAPI.SelectionSet, Fragment {
  public static var fragmentDefinition: StaticString {
    #"fragment BusinessInfo on Business { __typename id ownerId businessName businessType businessIndustry businessCategory businessHours { __typename ...BusinessHoursInfo } address addressBname addressDetails addressJibun addressSido addressSigungu addressSigunguCode addressSigunguEnglish addressZonecode bio representativeTitle representativeName phoneNumber registrationNumber images { __typename id file { __typename url } } activeCheckIns { __typename profile { __typename id userId name age birthYear height weight mbti education occupation bio gender images { __typename ...ImageFragment } interests { __typename id name } } createdAt updatedAt } latitude longitude createdAt updatedAt }"#
  }

  public let __data: DataDict
  public init(_dataDict: DataDict) { __data = _dataDict }

  public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Business }
  public static var __selections: [ApolloAPI.Selection] { [
    .field("__typename", String.self),
    .field("id", AmoringAPI.ID.self),
    .field("ownerId", String?.self),
    .field("businessName", String?.self),
    .field("businessType", String?.self),
    .field("businessIndustry", String?.self),
    .field("businessCategory", String?.self),
    .field("businessHours", [BusinessHour?]?.self),
    .field("address", String?.self),
    .field("addressBname", String?.self),
    .field("addressDetails", String?.self),
    .field("addressJibun", String?.self),
    .field("addressSido", String?.self),
    .field("addressSigungu", String?.self),
    .field("addressSigunguCode", String?.self),
    .field("addressSigunguEnglish", String?.self),
    .field("addressZonecode", String?.self),
    .field("bio", String?.self),
    .field("representativeTitle", String?.self),
    .field("representativeName", String?.self),
    .field("phoneNumber", String?.self),
    .field("registrationNumber", String?.self),
    .field("images", [Image?]?.self),
    .field("activeCheckIns", [ActiveCheckIn?].self),
    .field("latitude", Double?.self),
    .field("longitude", Double?.self),
    .field("createdAt", AmoringAPI.DateTime?.self),
    .field("updatedAt", AmoringAPI.DateTime?.self),
  ] }

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

  /// BusinessHour
  ///
  /// Parent Type: `BusinessHours`
  public struct BusinessHour: AmoringAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.BusinessHours }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("__typename", String.self),
      .fragment(BusinessHoursInfo.self),
    ] }

    public var openAt: AmoringAPI.LocalTime { __data["openAt"] }
    public var closeAt: AmoringAPI.LocalTime { __data["closeAt"] }
    public var day: GraphQLEnum<AmoringAPI.Day> { __data["day"] }

    public struct Fragments: FragmentContainer {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public var businessHoursInfo: BusinessHoursInfo { _toFragment() }
    }
  }

  /// Image
  ///
  /// Parent Type: `BusinessImage`
  public struct Image: AmoringAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.BusinessImage }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("__typename", String.self),
      .field("id", AmoringAPI.ID.self),
      .field("file", File.self),
    ] }

    public var id: AmoringAPI.ID { __data["id"] }
    public var file: File { __data["file"] }

    /// Image.File
    ///
    /// Parent Type: `File`
    public struct File: AmoringAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.File }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("url", String?.self),
      ] }

      public var url: String? { __data["url"] }
    }
  }

  /// ActiveCheckIn
  ///
  /// Parent Type: `CheckIn`
  public struct ActiveCheckIn: AmoringAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.CheckIn }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("__typename", String.self),
      .field("profile", Profile?.self),
      .field("createdAt", AmoringAPI.DateTime.self),
      .field("updatedAt", AmoringAPI.DateTime.self),
    ] }

    public var profile: Profile? { __data["profile"] }
    public var createdAt: AmoringAPI.DateTime { __data["createdAt"] }
    public var updatedAt: AmoringAPI.DateTime { __data["updatedAt"] }

    /// ActiveCheckIn.Profile
    ///
    /// Parent Type: `Profile`
    public struct Profile: AmoringAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Profile }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("id", AmoringAPI.ID.self),
        .field("userId", String.self),
        .field("name", String?.self),
        .field("age", Int?.self),
        .field("birthYear", Int?.self),
        .field("height", Int?.self),
        .field("weight", Int?.self),
        .field("mbti", String?.self),
        .field("education", String?.self),
        .field("occupation", String?.self),
        .field("bio", String?.self),
        .field("gender", GraphQLEnum<AmoringAPI.Gender>?.self),
        .field("images", [Image?]?.self),
        .field("interests", [Interest?]?.self),
      ] }

      public var id: AmoringAPI.ID { __data["id"] }
      public var userId: String { __data["userId"] }
      public var name: String? { __data["name"] }
      public var age: Int? { __data["age"] }
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

      /// ActiveCheckIn.Profile.Image
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
        public var file: File { __data["file"] }

        public struct Fragments: FragmentContainer {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public var imageFragment: ImageFragment { _toFragment() }
        }

        public typealias File = ImageFragment.File
      }

      /// ActiveCheckIn.Profile.Interest
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
