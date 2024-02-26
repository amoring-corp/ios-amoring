// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class UploadMyProfileImageMutation: GraphQLMutation {
  public static let operationName: String = "uploadMyProfileImage"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation uploadMyProfileImage($image: Upload!, $sort: Int!) { uploadMyProfileImage(data: { sort: $sort, file: $image }) { __typename id profileId fileId sort file { __typename id name mimetype url path width height createdAt updatedAt } createdAt updatedAt } }"#
    ))

  public var image: Upload
  public var sort: Int

  public init(
    image: Upload,
    sort: Int
  ) {
    self.image = image
    self.sort = sort
  }

  public var __variables: Variables? { [
    "image": image,
    "sort": sort
  ] }

  public struct Data: AmoringAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("uploadMyProfileImage", UploadMyProfileImage.self, arguments: ["data": [
        "sort": .variable("sort"),
        "file": .variable("image")
      ]]),
    ] }

    public var uploadMyProfileImage: UploadMyProfileImage { __data["uploadMyProfileImage"] }

    /// UploadMyProfileImage
    ///
    /// Parent Type: `ProfileImage`
    public struct UploadMyProfileImage: AmoringAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.ProfileImage }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("id", AmoringAPI.ID.self),
        .field("profileId", String.self),
        .field("fileId", String.self),
        .field("sort", Int.self),
        .field("file", File.self),
        .field("createdAt", AmoringAPI.DateTime?.self),
        .field("updatedAt", AmoringAPI.DateTime?.self),
      ] }

      public var id: AmoringAPI.ID { __data["id"] }
      public var profileId: String { __data["profileId"] }
      public var fileId: String { __data["fileId"] }
      public var sort: Int { __data["sort"] }
      public var file: File { __data["file"] }
      public var createdAt: AmoringAPI.DateTime? { __data["createdAt"] }
      public var updatedAt: AmoringAPI.DateTime? { __data["updatedAt"] }

      /// UploadMyProfileImage.File
      ///
      /// Parent Type: `File`
      public struct File: AmoringAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.File }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", AmoringAPI.ID.self),
          .field("name", String?.self),
          .field("mimetype", String?.self),
          .field("url", String?.self),
          .field("path", String?.self),
          .field("width", Int?.self),
          .field("height", Int?.self),
          .field("createdAt", AmoringAPI.DateTime?.self),
          .field("updatedAt", AmoringAPI.DateTime?.self),
        ] }

        public var id: AmoringAPI.ID { __data["id"] }
        public var name: String? { __data["name"] }
        public var mimetype: String? { __data["mimetype"] }
        public var url: String? { __data["url"] }
        public var path: String? { __data["path"] }
        public var width: Int? { __data["width"] }
        public var height: Int? { __data["height"] }
        public var createdAt: AmoringAPI.DateTime? { __data["createdAt"] }
        public var updatedAt: AmoringAPI.DateTime? { __data["updatedAt"] }
      }
    }
  }
}
