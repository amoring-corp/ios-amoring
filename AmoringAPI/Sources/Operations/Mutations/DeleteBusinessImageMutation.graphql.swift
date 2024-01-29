// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class DeleteBusinessImageMutation: GraphQLMutation {
  public static let operationName: String = "DeleteBusinessImage"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation DeleteBusinessImage($id: ID!) { deleteBusinessImage(id: $id) { __typename id } }"#
    ))

  public var id: ID

  public init(id: ID) {
    self.id = id
  }

  public var __variables: Variables? { ["id": id] }

  public struct Data: AmoringAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("deleteBusinessImage", [DeleteBusinessImage]?.self, arguments: ["id": .variable("id")]),
    ] }

    public var deleteBusinessImage: [DeleteBusinessImage]? { __data["deleteBusinessImage"] }

    /// DeleteBusinessImage
    ///
    /// Parent Type: `BusinessImage`
    public struct DeleteBusinessImage: AmoringAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.BusinessImage }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("id", AmoringAPI.ID.self),
      ] }

      public var id: AmoringAPI.ID { __data["id"] }
    }
  }
}
