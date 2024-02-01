// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class DeleteAllBusinessImagesMutation: GraphQLMutation {
  public static let operationName: String = "DeleteAllBusinessImages"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation DeleteAllBusinessImages($id: ID!) { deleteAllBusinessImages(businessId: $id) }"#
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
      .field("deleteAllBusinessImages", [AmoringAPI.ID]?.self, arguments: ["businessId": .variable("id")]),
    ] }

    public var deleteAllBusinessImages: [AmoringAPI.ID]? { __data["deleteAllBusinessImages"] }
  }
}
