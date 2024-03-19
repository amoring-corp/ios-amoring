// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public struct ProfileInfo: AmoringAPI.SelectionSet, Fragment {
  public static var fragmentDefinition: StaticString {
    #"fragment ProfileInfo on Profile { __typename id userId name age avatarUrl birthYear height weight mbti education occupation bio gender images { __typename ...ImageFragment } interests { __typename id name category { __typename id createdAt interests { __typename id name } name updatedAt } categoryId createdAt updatedAt } createdAt updatedAt }"#
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
    .field("images", [Image?]?.self),
    .field("interests", [Interest?]?.self),
    .field("createdAt", AmoringAPI.DateTime?.self),
    .field("updatedAt", AmoringAPI.DateTime?.self),
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
  public var images: [Image?]? { __data["images"] }
  public var interests: [Interest?]? { __data["interests"] }
  public var createdAt: AmoringAPI.DateTime? { __data["createdAt"] }
  public var updatedAt: AmoringAPI.DateTime? { __data["updatedAt"] }

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
    public var file: File { __data["file"] }

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
