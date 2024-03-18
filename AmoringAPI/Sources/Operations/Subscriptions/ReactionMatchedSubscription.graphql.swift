// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class ReactionMatchedSubscription: GraphQLSubscription {
  public static let operationName: String = "ReactionMatched"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"subscription ReactionMatched { reactionMatched { __typename ...ReactionInfo } }"#,
      fragments: [ImageFragment.self, ProfileInfo.self, ReactionInfo.self]
    ))

  public init() {}

  public struct Data: AmoringAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Subscription }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("reactionMatched", ReactionMatched?.self),
    ] }

    public var reactionMatched: ReactionMatched? { __data["reactionMatched"] }

    /// ReactionMatched
    ///
    /// Parent Type: `Reaction`
    public struct ReactionMatched: AmoringAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Reaction }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .fragment(ReactionInfo.self),
      ] }

      public var id: AmoringAPI.ID { __data["id"] }
      public var byProfileId: String { __data["byProfileId"] }
      public var byProfile: ByProfile { __data["byProfile"] }
      public var toProfileId: String { __data["toProfileId"] }
      public var toProfile: ToProfile { __data["toProfile"] }
      public var type: GraphQLEnum<AmoringAPI.ReactionType> { __data["type"] }
      public var matchedWithId: String? { __data["matchedWithId"] }
      public var isMatched: Bool? { __data["isMatched"] }
      public var createdAt: AmoringAPI.DateTime { __data["createdAt"] }
      public var updatedAt: AmoringAPI.DateTime { __data["updatedAt"] }

      public struct Fragments: FragmentContainer {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public var reactionInfo: ReactionInfo { _toFragment() }
      }

      /// ReactionMatched.ByProfile
      ///
      /// Parent Type: `Profile`
      public struct ByProfile: AmoringAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Profile }

        public var id: AmoringAPI.ID { __data["id"] }
        public var userId: String { __data["userId"] }
        public var name: String? { __data["name"] }
        public var age: Int? { __data["age"] }
        public var birthYear: Int? { __data["birthYear"] }
        public var height: Int? { __data["height"] }
        public var weight: Int? { __data["weight"] }
        public var mbti: String? { __data["mbti"] }
        public var education: String? { __data["education"] }
        public var occupation: String? { __data["occupation"] }
        public var bio: String? { __data["bio"] }
        public var gender: GraphQLEnum<AmoringAPI.Gender>? { __data["gender"] }
        public var images: [Image?]? { __data["images"] }
        public var interests: [Interest?]? { __data["interests"] }
        public var createdAt: AmoringAPI.DateTime? { __data["createdAt"] }
        public var updatedAt: AmoringAPI.DateTime? { __data["updatedAt"] }

        public struct Fragments: FragmentContainer {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public var profileInfo: ProfileInfo { _toFragment() }
        }

        /// ReactionMatched.ByProfile.Image
        ///
        /// Parent Type: `ProfileImage`
        public struct Image: AmoringAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.ProfileImage }

          public var id: AmoringAPI.ID { __data["id"] }
          public var file: File { __data["file"] }

          public struct Fragments: FragmentContainer {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public var imageFragment: ImageFragment { _toFragment() }
          }

          public typealias File = ImageFragment.File
        }

        public typealias Interest = ProfileInfo.Interest
      }

      public typealias ToProfile = ReactionInfo.ToProfile
    }
  }
}
