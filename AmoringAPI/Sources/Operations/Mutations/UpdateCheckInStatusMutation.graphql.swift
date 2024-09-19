// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class UpdateCheckInStatusMutation: GraphQLMutation {
  public static let operationName: String = "UpdateCheckInStatus"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation UpdateCheckInStatus($id: ID!, $hasTable: Boolean!) { updateCheckInStatus(id: $id, status: confirmed, hasTable: $hasTable) { __typename ...CheckInInfo } }"#,
      fragments: [BusinessHoursInfo.self, BusinessInfo.self, CheckInInfo.self]
    ))

  public var id: ID
  public var hasTable: Bool

  public init(
    id: ID,
    hasTable: Bool
  ) {
    self.id = id
    self.hasTable = hasTable
  }

  public var __variables: Variables? { [
    "id": id,
    "hasTable": hasTable
  ] }

  public struct Data: AmoringAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { AmoringAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("updateCheckInStatus", UpdateCheckInStatus?.self, arguments: [
        "id": .variable("id"),
        "status": "confirmed",
        "hasTable": .variable("hasTable")
      ]),
    ] }

    public var updateCheckInStatus: UpdateCheckInStatus? { __data["updateCheckInStatus"] }

    /// UpdateCheckInStatus
    ///
    /// Parent Type: `CheckIn`
    public struct UpdateCheckInStatus: AmoringAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { AmoringAPI.Objects.CheckIn }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .fragment(CheckInInfo.self),
      ] }

      public var id: AmoringAPI.ID { __data["id"] }
      public var businessId: String { __data["businessId"] }
      public var business: Business? { __data["business"] }
      public var profileId: String { __data["profileId"] }
      public var status: GraphQLEnum<AmoringAPI.CheckInStatus> { __data["status"] }
      public var hasTable: Bool { __data["hasTable"] }
      public var checkedInAt: AmoringAPI.DateTime? { __data["checkedInAt"] }
      public var checkedOutAt: AmoringAPI.DateTime? { __data["checkedOutAt"] }
      public var createdAt: AmoringAPI.DateTime { __data["createdAt"] }
      public var updatedAt: AmoringAPI.DateTime { __data["updatedAt"] }

      public struct Fragments: FragmentContainer {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public var checkInInfo: CheckInInfo { _toFragment() }
      }

      public typealias Business = CheckInInfo.Business
    }
  }
}
