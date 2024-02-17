// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class UpdateCheckInStatusMutation: GraphQLMutation {
  public static let operationName: String = "UpdateCheckInStatus"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation UpdateCheckInStatus($id: ID!) { updateCheckInStatus(id: $id, status: confirmed) { __typename id businessId business { __typename id ownerId businessName createdAt updatedAt } profileId profile { __typename id } status checkedInAt checkedOutAt createdAt updatedAt } }"#
    ))

  public var id: ID

  public init(id: ID) {
    self.id = id
  }

  public var __variables: Variables? { ["id": id] }

  public struct Data: AmoringAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("updateCheckInStatus", UpdateCheckInStatus?.self, arguments: [
        "id": .variable("id"),
        "status": "confirmed"
      ]),
    ] }

    public var updateCheckInStatus: UpdateCheckInStatus? { __data["updateCheckInStatus"] }

    /// UpdateCheckInStatus
    ///
    /// Parent Type: `CheckIn`
    public struct UpdateCheckInStatus: AmoringAPI.SelectionSet {
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

      /// UpdateCheckInStatus.Business
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
          .field("createdAt", AmoringAPI.DateTime?.self),
          .field("updatedAt", AmoringAPI.DateTime?.self),
        ] }

        public var id: AmoringAPI.ID { __data["id"] }
        public var ownerId: Int? { __data["ownerId"] }
        public var businessName: String? { __data["businessName"] }
        public var createdAt: AmoringAPI.DateTime? { __data["createdAt"] }
        public var updatedAt: AmoringAPI.DateTime? { __data["updatedAt"] }
      }

      /// UpdateCheckInStatus.Profile
      ///
      /// Parent Type: `UserProfile`
      public struct Profile: AmoringAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.UserProfile }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", AmoringAPI.ID.self),
        ] }

        public var id: AmoringAPI.ID { __data["id"] }
      }
    }
  }
}
