// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class DeleteConversationMutation: GraphQLMutation {
  public static let operationName: String = "DeleteConversation"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation DeleteConversation($id: ID!) { deleteConversation(id: $id) { __typename id } }"#
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
      .field("deleteConversation", DeleteConversation.self, arguments: ["id": .variable("id")]),
    ] }

    public var deleteConversation: DeleteConversation { __data["deleteConversation"] }

    /// DeleteConversation
    ///
    /// Parent Type: `Conversation`
    public struct DeleteConversation: AmoringAPI.SelectionSet {
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
