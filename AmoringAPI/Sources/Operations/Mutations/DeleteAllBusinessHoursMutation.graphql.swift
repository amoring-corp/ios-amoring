// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class DeleteAllBusinessHoursMutation: GraphQLMutation {
  public static let operationName: String = "DeleteAllBusinessHours"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation DeleteAllBusinessHours($businessId: ID!) { deleteAllBusinessHours(businessId: $businessId) }"#
    ))

  public var businessId: ID

  public init(businessId: ID) {
    self.businessId = businessId
  }

  public var __variables: Variables? { ["businessId": businessId] }

  public struct Data: AmoringAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("deleteAllBusinessHours", Int.self, arguments: ["businessId": .variable("businessId")]),
    ] }

    public var deleteAllBusinessHours: Int { __data["deleteAllBusinessHours"] }
  }
}
