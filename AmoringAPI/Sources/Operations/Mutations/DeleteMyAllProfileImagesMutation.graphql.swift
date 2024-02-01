// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class DeleteMyAllProfileImagesMutation: GraphQLMutation {
  public static let operationName: String = "DeleteMyAllProfileImages"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation DeleteMyAllProfileImages { deleteMyAllProfileImages }"#
    ))

  public init() {}

  public struct Data: AmoringAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("deleteMyAllProfileImages", [AmoringAPI.ID?].self),
    ] }

    public var deleteMyAllProfileImages: [AmoringAPI.ID?] { __data["deleteMyAllProfileImages"] }
  }
}
