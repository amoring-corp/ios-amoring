// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class CreateCheckInByTokenMutation: GraphQLMutation {
  public static let operationName: String = "CreateCheckInByToken"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation CreateCheckInByToken($token: String!) { createCheckInByToken(token: $token) { __typename id businessId business { __typename id ownerId businessName } profileId profile { __typename id } status checkedInAt checkedOutAt createdAt updatedAt } }"#
    ))

  public var token: String

  public init(token: String) {
    self.token = token
  }

  public var __variables: Variables? { ["token": token] }

  public struct Data: AmoringAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("createCheckInByToken", CreateCheckInByToken?.self, arguments: ["token": .variable("token")]),
    ] }

    public var createCheckInByToken: CreateCheckInByToken? { __data["createCheckInByToken"] }

    /// CreateCheckInByToken
    ///
    /// Parent Type: `CheckIn`
    public struct CreateCheckInByToken: AmoringAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.CheckIn }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("id", AmoringAPI.ID.self),
        .field("businessId", Int.self),
        .field("business", Business.self),
        .field("profileId", Int.self),
        .field("profile", Profile.self),
        .field("status", GraphQLEnum<AmoringAPI.CheckInStatus>.self),
        .field("checkedInAt", AmoringAPI.DateTime?.self),
        .field("checkedOutAt", AmoringAPI.DateTime?.self),
        .field("createdAt", AmoringAPI.DateTime.self),
        .field("updatedAt", AmoringAPI.DateTime.self),
      ] }

      public var id: AmoringAPI.ID { __data["id"] }
      public var businessId: Int { __data["businessId"] }
      public var business: Business { __data["business"] }
      public var profileId: Int { __data["profileId"] }
      public var profile: Profile { __data["profile"] }
      public var status: GraphQLEnum<AmoringAPI.CheckInStatus> { __data["status"] }
      public var checkedInAt: AmoringAPI.DateTime? { __data["checkedInAt"] }
      public var checkedOutAt: AmoringAPI.DateTime? { __data["checkedOutAt"] }
      public var createdAt: AmoringAPI.DateTime { __data["createdAt"] }
      public var updatedAt: AmoringAPI.DateTime { __data["updatedAt"] }

      /// CreateCheckInByToken.Business
      ///
      /// Parent Type: `Business`
      public struct Business: AmoringAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Business }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", AmoringAPI.ID.self),
          .field("ownerId", Int?.self),
          .field("businessName", String?.self),
        ] }

        public var id: AmoringAPI.ID { __data["id"] }
        public var ownerId: Int? { __data["ownerId"] }
        public var businessName: String? { __data["businessName"] }
      }

      /// CreateCheckInByToken.Profile
      ///
      /// Parent Type: `Profile`
      public struct Profile: AmoringAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Profile }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", AmoringAPI.ID.self),
        ] }

        public var id: AmoringAPI.ID { __data["id"] }
      }
    }
  }
}
