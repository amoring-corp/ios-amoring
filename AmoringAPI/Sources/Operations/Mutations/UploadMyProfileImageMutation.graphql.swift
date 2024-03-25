// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class UploadMyProfileImageMutation: GraphQLMutation {
  public static let operationName: String = "uploadMyProfileImage"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation uploadMyProfileImage($image: Upload!, $sort: Int!) { uploadMyProfileImage(data: { sort: $sort, file: $image }) { __typename ...ImageFragment } }"#,
      fragments: [ImageFragment.self]
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
        .fragment(ImageFragment.self),
      ] }

      public var id: AmoringAPI.ID { __data["id"] }
      public var file: File? { __data["file"] }

      public struct Fragments: FragmentContainer {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public var imageFragment: ImageFragment { _toFragment() }
      }

      public typealias File = ImageFragment.File
    }
  }
}
