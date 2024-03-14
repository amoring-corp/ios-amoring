// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class UpsertUserDeviceMutation: GraphQLMutation {
  public static let operationName: String = "UpsertUserDevice"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation UpsertUserDevice($deviceToken: String!, $deviceOs: String) { upsertUserDevice(deviceToken: $deviceToken, deviceOs: $deviceOs) { __typename id deviceToken deviceOs } }"#
    ))

  public var deviceToken: String
  public var deviceOs: GraphQLNullable<String>

  public init(
    deviceToken: String,
    deviceOs: GraphQLNullable<String>
  ) {
    self.deviceToken = deviceToken
    self.deviceOs = deviceOs
  }

  public var __variables: Variables? { [
    "deviceToken": deviceToken,
    "deviceOs": deviceOs
  ] }

  public struct Data: AmoringAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("upsertUserDevice", UpsertUserDevice?.self, arguments: [
        "deviceToken": .variable("deviceToken"),
        "deviceOs": .variable("deviceOs")
      ]),
    ] }

    public var upsertUserDevice: UpsertUserDevice? { __data["upsertUserDevice"] }

    /// UpsertUserDevice
    ///
    /// Parent Type: `UserDevice`
    public struct UpsertUserDevice: AmoringAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.UserDevice }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("id", AmoringAPI.ID.self),
        .field("deviceToken", String.self),
        .field("deviceOs", String?.self),
      ] }

      public var id: AmoringAPI.ID { __data["id"] }
      public var deviceToken: String { __data["deviceToken"] }
      public var deviceOs: String? { __data["deviceOs"] }
    }
  }
}
