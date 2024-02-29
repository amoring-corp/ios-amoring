// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class ConversationsQuery: GraphQLQuery {
  public static let operationName: String = "Conversations"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query Conversations { conversations { __typename id status participants { __typename id email status role profile { __typename id name images { __typename id file { __typename url } } } createdAt updatedAt } messages(take: 1, skip: 0) { __typename id body createdAt updatedAt } createdAt archivedAt updatedAt } }"#
    ))

  public init() {}

  public struct Data: AmoringAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("conversations", [Conversation].self),
    ] }

    public var conversations: [Conversation] { __data["conversations"] }

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
          "take": 1,
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
            .field("images", [Image?]?.self),
          ] }

          public var id: AmoringAPI.ID { __data["id"] }
          public var name: String? { __data["name"] }
          public var images: [Image?]? { __data["images"] }

          /// Conversation.Participant.Profile.Image
          ///
          /// Parent Type: `ProfileImage`
          public struct Image: AmoringAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.ProfileImage }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("id", AmoringAPI.ID.self),
              .field("file", File.self),
            ] }

            public var id: AmoringAPI.ID { __data["id"] }
            public var file: File { __data["file"] }

            /// Conversation.Participant.Profile.Image.File
            ///
            /// Parent Type: `File`
            public struct File: AmoringAPI.SelectionSet {
              public let __data: DataDict
              public init(_dataDict: DataDict) { __data = _dataDict }

              public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.File }
              public static var __selections: [ApolloAPI.Selection] { [
                .field("__typename", String.self),
                .field("url", String?.self),
              ] }

              public var url: String? { __data["url"] }
            }
          }
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
          .field("createdAt", AmoringAPI.DateTime?.self),
          .field("updatedAt", AmoringAPI.DateTime?.self),
        ] }

        public var id: AmoringAPI.ID { __data["id"] }
        public var body: String { __data["body"] }
        public var createdAt: AmoringAPI.DateTime? { __data["createdAt"] }
        public var updatedAt: AmoringAPI.DateTime? { __data["updatedAt"] }
      }
    }
  }
}
