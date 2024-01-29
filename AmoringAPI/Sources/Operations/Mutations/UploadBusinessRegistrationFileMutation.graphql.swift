// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class UploadBusinessRegistrationFileMutation: GraphQLMutation {
  public static let operationName: String = "UploadBusinessRegistrationFile"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation UploadBusinessRegistrationFile($id: ID!, $file: Upload!) { uploadBusinessRegistrationFile(businessId: $id, file: $file) { __typename id name mimetype url } }"#
    ))

  public var id: ID
  public var file: Upload

  public init(
    id: ID,
    file: Upload
  ) {
    self.id = id
    self.file = file
  }

  public var __variables: Variables? { [
    "id": id,
    "file": file
  ] }

  public struct Data: AmoringAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("uploadBusinessRegistrationFile", UploadBusinessRegistrationFile.self, arguments: [
        "businessId": .variable("id"),
        "file": .variable("file")
      ]),
    ] }

    public var uploadBusinessRegistrationFile: UploadBusinessRegistrationFile { __data["uploadBusinessRegistrationFile"] }

    /// UploadBusinessRegistrationFile
    ///
    /// Parent Type: `File`
    public struct UploadBusinessRegistrationFile: AmoringAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.File }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("id", AmoringAPI.ID.self),
        .field("name", String?.self),
        .field("mimetype", String?.self),
        .field("url", String?.self),
      ] }

      public var id: AmoringAPI.ID { __data["id"] }
      public var name: String? { __data["name"] }
      public var mimetype: String? { __data["mimetype"] }
      public var url: String? { __data["url"] }
    }
  }
}
