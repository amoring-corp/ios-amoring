// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class DeleteMyAccountMutation: GraphQLMutation {
  public static let operationName: String = "DeleteMyAccount"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation DeleteMyAccount { deleteMyAccount }"#
    ))

  public init() {}

  public struct Data: AmoringAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { AmoringAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("deleteMyAccount", Bool.self),
    ] }

    public var deleteMyAccount: Bool { __data["deleteMyAccount"] }
  }
}
