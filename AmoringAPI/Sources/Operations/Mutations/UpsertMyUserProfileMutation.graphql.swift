// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class UpsertMyUserProfileMutation: GraphQLMutation {
  public static let operationName: String = "upsertMyUserProfile"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation upsertMyUserProfile($data: UserProfileUpdateInput!) { upsertMyUserProfile(data: $data) { __typename id userId name age birthYear height weight mbti education occupation bio gender createdAt updatedAt } }"#
    ))

  public var data: UserProfileUpdateInput

  public init(data: UserProfileUpdateInput) {
    self.data = data
  }

  public var __variables: Variables? { ["data": data] }

  public struct Data: AmoringAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("upsertMyUserProfile", UpsertMyUserProfile.self, arguments: ["data": .variable("data")]),
    ] }

    public var upsertMyUserProfile: UpsertMyUserProfile { __data["upsertMyUserProfile"] }

    /// UpsertMyUserProfile
    ///
    /// Parent Type: `UserProfile`
    public struct UpsertMyUserProfile: AmoringAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.UserProfile }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("id", AmoringAPI.ID.self),
        .field("userId", Int.self),
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
        .field("createdAt", AmoringAPI.DateTime?.self),
        .field("updatedAt", AmoringAPI.DateTime?.self),
      ] }

      public var id: AmoringAPI.ID { __data["id"] }
      public var userId: Int { __data["userId"] }
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
      public var createdAt: AmoringAPI.DateTime? { __data["createdAt"] }
      public var updatedAt: AmoringAPI.DateTime? { __data["updatedAt"] }
    }
  }
}
