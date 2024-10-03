// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class ReportUserMutation: GraphQLMutation {
  public static let operationName: String = "ReportUser"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation ReportUser($userId: ID!) { reportUser(userId: $userId) { __typename id } }"#
    ))

  public var userId: ID

  public init(userId: ID) {
    self.userId = userId
  }

  public var __variables: Variables? { ["userId": userId] }

  public struct Data: AmoringAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { AmoringAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("reportUser", ReportUser?.self, arguments: ["userId": .variable("userId")]),
    ] }

    public var reportUser: ReportUser? { __data["reportUser"] }

    /// ReportUser
    ///
    /// Parent Type: `Report`
    public struct ReportUser: AmoringAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { AmoringAPI.Objects.Report }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("id", AmoringAPI.ID.self),
      ] }

      public var id: AmoringAPI.ID { __data["id"] }
    }
  }
}
