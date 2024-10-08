// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class BlockUserMutation: GraphQLMutation {
  public static let operationName: String = "BlockUser"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation BlockUser($id: ID!) { blockUser(id: $id) }"#
    ))

  public var id: ID

  public init(id: ID) {
    self.id = id
  }

  public var __variables: Variables? { ["id": id] }

  public struct Data: AmoringAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { AmoringAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("blockUser", Bool.self, arguments: ["id": .variable("id")]),
    ] }

    public var blockUser: Bool { __data["blockUser"] }
  }
}
