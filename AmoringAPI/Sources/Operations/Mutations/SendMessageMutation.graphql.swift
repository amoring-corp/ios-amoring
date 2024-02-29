// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class SendMessageMutation: GraphQLMutation {
  public static let operationName: String = "SendMessage"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation SendMessage($body: String!, $conversationId: ID!) { sendMessage(body: $body, conversationId: $conversationId) { __typename id body senderId createdAt updatedAt } }"#
    ))

  public var body: String
  public var conversationId: ID

  public init(
    body: String,
    conversationId: ID
  ) {
    self.body = body
    self.conversationId = conversationId
  }

  public var __variables: Variables? { [
    "body": body,
    "conversationId": conversationId
  ] }

  public struct Data: AmoringAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("sendMessage", SendMessage.self, arguments: [
        "body": .variable("body"),
        "conversationId": .variable("conversationId")
      ]),
    ] }

    public var sendMessage: SendMessage { __data["sendMessage"] }

    /// SendMessage
    ///
    /// Parent Type: `Message`
    public struct SendMessage: AmoringAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Message }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("id", AmoringAPI.ID.self),
        .field("body", String.self),
        .field("senderId", String?.self),
        .field("createdAt", AmoringAPI.DateTime?.self),
        .field("updatedAt", AmoringAPI.DateTime?.self),
      ] }

      public var id: AmoringAPI.ID { __data["id"] }
      public var body: String { __data["body"] }
      public var senderId: String? { __data["senderId"] }
      public var createdAt: AmoringAPI.DateTime? { __data["createdAt"] }
      public var updatedAt: AmoringAPI.DateTime? { __data["updatedAt"] }
    }
  }
}
