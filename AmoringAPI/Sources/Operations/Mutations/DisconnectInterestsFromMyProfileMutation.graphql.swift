// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class DisconnectInterestsFromMyProfileMutation: GraphQLMutation {
  public static let operationName: String = "DisconnectInterestsFromMyProfile"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation DisconnectInterestsFromMyProfile($Ids: [ID!]!) { disconnectInterestsFromMyProfile(interestIds: $Ids) { __typename id userId interests { __typename id name categoryId createdAt updatedAt } createdAt updatedAt } }"#
    ))

  public var ids: [ID]

  public init(ids: [ID]) {
    self.ids = ids
  }

  public var __variables: Variables? { ["Ids": ids] }

  public struct Data: AmoringAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("disconnectInterestsFromMyProfile", DisconnectInterestsFromMyProfile.self, arguments: ["interestIds": .variable("Ids")]),
    ] }

    public var disconnectInterestsFromMyProfile: DisconnectInterestsFromMyProfile { __data["disconnectInterestsFromMyProfile"] }

    /// DisconnectInterestsFromMyProfile
    ///
    /// Parent Type: `Profile`
    public struct DisconnectInterestsFromMyProfile: AmoringAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Profile }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("id", AmoringAPI.ID.self),
        .field("userId", Int.self),
        .field("interests", [Interest?]?.self),
        .field("createdAt", AmoringAPI.DateTime?.self),
        .field("updatedAt", AmoringAPI.DateTime?.self),
      ] }

      public var id: AmoringAPI.ID { __data["id"] }
      public var userId: Int { __data["userId"] }
      public var interests: [Interest?]? { __data["interests"] }
      public var createdAt: AmoringAPI.DateTime? { __data["createdAt"] }
      public var updatedAt: AmoringAPI.DateTime? { __data["updatedAt"] }

      /// DisconnectInterestsFromMyProfile.Interest
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
