// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class DisconnectUserDeviceMutation: GraphQLMutation {
  public static let operationName: String = "DisconnectUserDevice"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation DisconnectUserDevice($deviceToken: String!) { disconnectUserDevice(deviceToken: $deviceToken) }"#
    ))

  public var deviceToken: String

  public init(deviceToken: String) {
    self.deviceToken = deviceToken
  }

  public var __variables: Variables? { ["deviceToken": deviceToken] }

  public struct Data: AmoringAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("disconnectUserDevice", Bool?.self, arguments: ["deviceToken": .variable("deviceToken")]),
    ] }

    public var disconnectUserDevice: Bool? { __data["disconnectUserDevice"] }
  }
}
