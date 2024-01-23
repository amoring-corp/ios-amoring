// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class UploadBusinessImageMutation: GraphQLMutation {
  public static let operationName: String = "UploadBusinessImage"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation UploadBusinessImage($businessId: ID!, $image: Upload!, $sort: Int!) { uploadBusinessImage( businessId: $businessId data: { sort: $sort, file: $image } ) { __typename id businessId fileId sort file { __typename id name mimetype url path width height createdAt updatedAt } } }"#
    ))

  public var businessId: ID
  public var image: Upload
  public var sort: Int

  public init(
    businessId: ID,
    image: Upload,
    sort: Int
  ) {
    self.businessId = businessId
    self.image = image
    self.sort = sort
  }

  public var __variables: Variables? { [
    "businessId": businessId,
    "image": image,
    "sort": sort
  ] }

  public struct Data: AmoringAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("uploadBusinessImage", UploadBusinessImage.self, arguments: [
        "businessId": .variable("businessId"),
        "data": [
          "sort": .variable("sort"),
          "file": .variable("image")
        ]
      ]),
    ] }

    public var uploadBusinessImage: UploadBusinessImage { __data["uploadBusinessImage"] }

    /// UploadBusinessImage
    ///
    /// Parent Type: `BusinessImage`
    public struct UploadBusinessImage: AmoringAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.BusinessImage }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("id", AmoringAPI.ID.self),
        .field("businessId", Int.self),
        .field("fileId", Int.self),
        .field("sort", Int.self),
        .field("file", File.self),
      ] }

      public var id: AmoringAPI.ID { __data["id"] }
      public var businessId: Int { __data["businessId"] }
      public var fileId: Int { __data["fileId"] }
      public var sort: Int { __data["sort"] }
      public var file: File { __data["file"] }

      /// UploadBusinessImage.File
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
