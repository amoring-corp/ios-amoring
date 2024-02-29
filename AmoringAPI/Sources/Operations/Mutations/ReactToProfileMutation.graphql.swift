// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class ReactToProfileMutation: GraphQLMutation {
  public static let operationName: String = "ReactToProfile"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation ReactToProfile($profileId: String!, $type: ReactionType!) { reactToProfile(profileId: $profileId, type: $type) { __typename id toProfileId byProfileId isMatched } }"#
    ))

  public var profileId: String
  public var type: GraphQLEnum<ReactionType>

  public init(
    profileId: String,
    type: GraphQLEnum<ReactionType>
  ) {
    self.profileId = profileId
    self.type = type
  }

  public var __variables: Variables? { [
    "profileId": profileId,
    "type": type
  ] }

  public struct Data: AmoringAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("reactToProfile", ReactToProfile?.self, arguments: [
        "profileId": .variable("profileId"),
        "type": .variable("type")
      ]),
    ] }

    /// React to a profile by authenticated user
    public var reactToProfile: ReactToProfile? { __data["reactToProfile"] }

    /// ReactToProfile
    ///
    /// Parent Type: `Reaction`
    public struct ReactToProfile: AmoringAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Reaction }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("id", AmoringAPI.ID.self),
        .field("toProfileId", String.self),
        .field("byProfileId", String.self),
        .field("isMatched", Bool?.self),
      ] }

      public var id: AmoringAPI.ID { __data["id"] }
      public var toProfileId: String { __data["toProfileId"] }
      public var byProfileId: String { __data["byProfileId"] }
      public var isMatched: Bool? { __data["isMatched"] }
    }
  }
}
