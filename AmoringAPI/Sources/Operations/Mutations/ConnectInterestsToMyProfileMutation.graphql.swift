// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class ConnectInterestsToMyProfileMutation: GraphQLMutation {
  public static let operationName: String = "ConnectInterestsToMyProfile"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation ConnectInterestsToMyProfile($interestIds: [ID!]!) { connectInterestsToMyProfile(interestIds: $interestIds) { __typename id userId name birthYear height weight mbti education occupation bio gender images { __typename id profileId fileId sort createdAt updatedAt } interests { __typename id name categoryId createdAt updatedAt } age createdAt updatedAt } }"#
    ))

  public var interestIds: [ID]

  public init(interestIds: [ID]) {
    self.interestIds = interestIds
  }

  public var __variables: Variables? { ["interestIds": interestIds] }

  public struct Data: AmoringAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("connectInterestsToMyProfile", ConnectInterestsToMyProfile.self, arguments: ["interestIds": .variable("interestIds")]),
    ] }

    public var connectInterestsToMyProfile: ConnectInterestsToMyProfile { __data["connectInterestsToMyProfile"] }

    /// ConnectInterestsToMyProfile
    ///
    /// Parent Type: `UserProfile`
    public struct ConnectInterestsToMyProfile: AmoringAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.UserProfile }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("id", AmoringAPI.ID.self),
        .field("userId", Int.self),
        .field("name", String?.self),
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
        .field("age", Int?.self),
        .field("createdAt", AmoringAPI.DateTime?.self),
        .field("updatedAt", AmoringAPI.DateTime?.self),
      ] }

      public var id: AmoringAPI.ID { __data["id"] }
      public var userId: Int { __data["userId"] }
      public var name: String? { __data["name"] }
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
      public var age: Int? { __data["age"] }
      public var createdAt: AmoringAPI.DateTime? { __data["createdAt"] }
      public var updatedAt: AmoringAPI.DateTime? { __data["updatedAt"] }

      /// ConnectInterestsToMyProfile.Image
      ///
      /// Parent Type: `UserProfileImage`
      public struct Image: AmoringAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.UserProfileImage }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", AmoringAPI.ID.self),
          .field("profileId", Int.self),
          .field("fileId", Int.self),
          .field("sort", Int.self),
          .field("createdAt", AmoringAPI.DateTime?.self),
          .field("updatedAt", AmoringAPI.DateTime?.self),
        ] }

        public var id: AmoringAPI.ID { __data["id"] }
        public var profileId: Int { __data["profileId"] }
        public var fileId: Int { __data["fileId"] }
        public var sort: Int { __data["sort"] }
        public var createdAt: AmoringAPI.DateTime? { __data["createdAt"] }
        public var updatedAt: AmoringAPI.DateTime? { __data["updatedAt"] }
      }

      /// ConnectInterestsToMyProfile.Interest
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
          .field("categoryId", Int.self),
          .field("createdAt", AmoringAPI.DateTime?.self),
          .field("updatedAt", AmoringAPI.DateTime?.self),
        ] }

        public var id: AmoringAPI.ID { __data["id"] }
        public var name: String? { __data["name"] }
        public var categoryId: Int { __data["categoryId"] }
        public var createdAt: AmoringAPI.DateTime? { __data["createdAt"] }
        public var updatedAt: AmoringAPI.DateTime? { __data["updatedAt"] }
      }
    }
  }
}
