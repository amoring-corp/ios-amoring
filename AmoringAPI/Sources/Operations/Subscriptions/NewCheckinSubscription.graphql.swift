// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class NewCheckinSubscription: GraphQLSubscription {
  public static let operationName: String = "NewCheckin"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"subscription NewCheckin { checkIn { __typename id ...CheckInInfo } }"#,
      fragments: [BusinessHoursInfo.self, BusinessInfo.self, CheckInInfo.self]
    ))

  public init() {}

  public struct Data: AmoringAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { AmoringAPI.Objects.Subscription }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("checkIn", CheckIn?.self),
    ] }

    public var checkIn: CheckIn? { __data["checkIn"] }

    /// CheckIn
    ///
    /// Parent Type: `CheckIn`
    public struct CheckIn: AmoringAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { AmoringAPI.Objects.CheckIn }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("id", AmoringAPI.ID.self),
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
