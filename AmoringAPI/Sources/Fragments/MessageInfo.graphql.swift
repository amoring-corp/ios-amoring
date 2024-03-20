// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public struct MessageInfo: AmoringAPI.SelectionSet, Fragment {
  public static var fragmentDefinition: StaticString {
    #"fragment MessageInfo on Message { __typename id conversationId body senderId senderAvatarUrl senderName sender { __typename id profile { __typename name images { __typename file { __typename url } } } } createdAt updatedAt }"#
  }

  public let __data: DataDict
  public init(_dataDict: DataDict) { __data = _dataDict }

  public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Message }
  public static var __selections: [ApolloAPI.Selection] { [
    .field("__typename", String.self),
    .field("id", AmoringAPI.ID.self),
    .field("conversationId", String?.self),
    .field("body", String.self),
    .field("senderId", String?.self),
    .field("senderAvatarUrl", String?.self),
    .field("senderName", String?.self),
    .field("sender", Sender?.self),
    .field("createdAt", AmoringAPI.DateTime?.self),
    .field("updatedAt", AmoringAPI.DateTime?.self),
  ] }

  public var id: AmoringAPI.ID { __data["id"] }
  public var conversationId: String? { __data["conversationId"] }
  public var body: String { __data["body"] }
  public var senderId: String? { __data["senderId"] }
  public var senderAvatarUrl: String? { __data["senderAvatarUrl"] }
  public var senderName: String? { __data["senderName"] }
  public var sender: Sender? { __data["sender"] }
  public var createdAt: AmoringAPI.DateTime? { __data["createdAt"] }
  public var updatedAt: AmoringAPI.DateTime? { __data["updatedAt"] }

  /// Sender
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

    /// Sender.Profile
    ///
    /// Parent Type: `Profile`
    public struct Profile: AmoringAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Profile }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("name", String?.self),
        .field("images", [Image?]?.self),
      ] }

      public var name: String? { __data["name"] }
      public var images: [Image?]? { __data["images"] }

      /// Sender.Profile.Image
      ///
      /// Parent Type: `ProfileImage`
      public struct Image: AmoringAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.ProfileImage }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("file", File?.self),
        ] }

        public var file: File? { __data["file"] }

        /// Sender.Profile.Image.File
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
}
