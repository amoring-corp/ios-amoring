// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class ConversationQuery: GraphQLQuery {
  public static let operationName: String = "Conversation"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query Conversation($id: ID!) { conversation(id: $id) { __typename id status participants { __typename id email status role profile { __typename id name } createdAt updatedAt } messages(take: 10, skip: 0) { __typename id body senderId sender { __typename id profile { __typename name } } createdAt updatedAt } createdAt archivedAt updatedAt } }"#
    ))

  public var id: ID

  public init(id: ID) {
    self.id = id
  }

  public var __variables: Variables? { ["id": id] }

  public struct Data: AmoringAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("conversation", Conversation?.self, arguments: ["id": .variable("id")]),
    ] }

    public var conversation: Conversation? { __data["conversation"] }

    /// Conversation
    ///
    /// Parent Type: `Conversation`
    public struct Conversation: AmoringAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Conversation }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("id", AmoringAPI.ID.self),
        .field("status", GraphQLEnum<AmoringAPI.ConversationStatus>.self),
        .field("participants", [Participant?].self),
        .field("messages", [Message?].self, arguments: [
          "take": 10,
          "skip": 0
        ]),
        .field("createdAt", AmoringAPI.DateTime?.self),
        .field("archivedAt", AmoringAPI.DateTime?.self),
        .field("updatedAt", AmoringAPI.DateTime?.self),
      ] }

      public var id: AmoringAPI.ID { __data["id"] }
      public var status: GraphQLEnum<AmoringAPI.ConversationStatus> { __data["status"] }
      public var participants: [Participant?] { __data["participants"] }
      public var messages: [Message?] { __data["messages"] }
      public var createdAt: AmoringAPI.DateTime? { __data["createdAt"] }
      public var archivedAt: AmoringAPI.DateTime? { __data["archivedAt"] }
      public var updatedAt: AmoringAPI.DateTime? { __data["updatedAt"] }

      /// Conversation.Participant
      ///
      /// Parent Type: `User`
      public struct Participant: AmoringAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.User }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", AmoringAPI.ID.self),
          .field("email", String?.self),
          .field("status", GraphQLEnum<AmoringAPI.UserStatus>?.self),
          .field("role", GraphQLEnum<AmoringAPI.UserRole>?.self),
          .field("profile", Profile?.self),
          .field("createdAt", AmoringAPI.DateTime?.self),
          .field("updatedAt", AmoringAPI.DateTime?.self),
        ] }

        public var id: AmoringAPI.ID { __data["id"] }
        public var email: String? { __data["email"] }
        public var status: GraphQLEnum<AmoringAPI.UserStatus>? { __data["status"] }
        public var role: GraphQLEnum<AmoringAPI.UserRole>? { __data["role"] }
        public var profile: Profile? { __data["profile"] }
        public var createdAt: AmoringAPI.DateTime? { __data["createdAt"] }
        public var updatedAt: AmoringAPI.DateTime? { __data["updatedAt"] }

        /// Conversation.Participant.Profile
        ///
        /// Parent Type: `Profile`
        public struct Profile: AmoringAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Profile }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("id", AmoringAPI.ID.self),
            .field("name", String?.self),
          ] }

          public var id: AmoringAPI.ID { __data["id"] }
          public var name: String? { __data["name"] }
        }
      }

      /// Conversation.Message
      ///
      /// Parent Type: `Message`
      public struct Message: AmoringAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Message }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", AmoringAPI.ID.self),
          .field("body", String.self),
          .field("senderId", String?.self),
          .field("sender", Sender?.self),
          .field("createdAt", AmoringAPI.DateTime?.self),
          .field("updatedAt", AmoringAPI.DateTime?.self),
        ] }

        public var id: AmoringAPI.ID { __data["id"] }
        public var body: String { __data["body"] }
        public var senderId: String? { __data["senderId"] }
        public var sender: Sender? { __data["sender"] }
        public var createdAt: AmoringAPI.DateTime? { __data["createdAt"] }
        public var updatedAt: AmoringAPI.DateTime? { __data["updatedAt"] }

        /// Conversation.Message.Sender
        ///
        /// Parent Type: `User`
        public struct Sender: AmoringAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.User }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("id", AmoringAPI.ID.self),
            .field("profile", Profile?.self),
          ] }

          public var id: AmoringAPI.ID { __data["id"] }
          public var profile: Profile? { __data["profile"] }

          /// Conversation.Message.Sender.Profile
          ///
          /// Parent Type: `Profile`
          public struct Profile: AmoringAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Profile }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("name", String?.self),
            ] }

            public var name: String? { __data["name"] }
          }
        }
      }
    }
  }
}
