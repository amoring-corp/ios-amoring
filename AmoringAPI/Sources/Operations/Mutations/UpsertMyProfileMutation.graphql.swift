// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class UpsertMyProfileMutation: GraphQLMutation {
  public static let operationName: String = "upsertMyProfile"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation upsertMyProfile($data: ProfileUpdateInput!) { upsertMyProfile(data: $data) { __typename id userId name age birthYear height weight mbti education occupation bio gender createdAt updatedAt } }"#
    ))

  public var data: ProfileUpdateInput

  public init(data: ProfileUpdateInput) {
    self.data = data
  }

  public var __variables: Variables? { ["data": data] }

  public struct Data: AmoringAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("upsertMyProfile", UpsertMyProfile.self, arguments: ["data": .variable("data")]),
    ] }

    public var upsertMyProfile: UpsertMyProfile { __data["upsertMyProfile"] }

    /// UpsertMyProfile
    ///
    /// Parent Type: `Profile`
    public struct UpsertMyProfile: AmoringAPI.SelectionSet {
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
        .field("createdAt", AmoringAPI.DateTime?.self),
        .field("updatedAt", AmoringAPI.DateTime?.self),
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
      public var createdAt: AmoringAPI.DateTime? { __data["createdAt"] }
      public var updatedAt: AmoringAPI.DateTime? { __data["updatedAt"] }
    }
  }
}
