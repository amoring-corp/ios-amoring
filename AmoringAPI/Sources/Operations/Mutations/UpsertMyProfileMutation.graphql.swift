// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class UpsertMyProfileMutation: GraphQLMutation {
  public static let operationName: String = "upsertMyProfile"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation upsertMyProfile($data: ProfileUpdateInput!) { upsertMyProfile(data: $data) { __typename ...ProfileInfo } }"#,
      fragments: [ImageFragment.self, ProfileInfo.self]
    ))

  public var data: ProfileUpdateInput

  public init(data: ProfileUpdateInput) {
    self.data = data
  }

  public var __variables: Variables? { ["data": data] }

  public struct Data: AmoringAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("upsertMyProfile", UpsertMyProfile.self, arguments: ["data": .variable("data")]),
    ] }

    public var upsertMyProfile: UpsertMyProfile { __data["upsertMyProfile"] }

    /// UpsertMyProfile
    ///
    /// Parent Type: `Profile`
    public struct UpsertMyProfile: AmoringAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Profile }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .fragment(ProfileInfo.self),
      ] }

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

      /// UpsertMyProfile.Image
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
  }
}
