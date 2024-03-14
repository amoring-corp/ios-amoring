// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class ReportConversationMutation: GraphQLMutation {
  public static let operationName: String = "ReportConversation"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation ReportConversation($id: ID!) { reportConversation(id: $id) { __typename id } }"#
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
      .field("reportConversation", ReportConversation.self, arguments: ["id": .variable("id")]),
    ] }

    public var reportConversation: ReportConversation { __data["reportConversation"] }

    /// ReportConversation
    ///
    /// Parent Type: `Conversation`
    public struct ReportConversation: AmoringAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Conversation }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("id", AmoringAPI.ID.self),
      ] }

      public var id: AmoringAPI.ID { __data["id"] }
    }
  }
}
