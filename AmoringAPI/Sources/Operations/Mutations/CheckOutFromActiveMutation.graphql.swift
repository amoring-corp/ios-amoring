// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class CheckOutFromActiveMutation: GraphQLMutation {
  public static let operationName: String = "CheckOutFromActive"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation CheckOutFromActive { checkOutFromActive { __typename ...CheckInInfo } }"#,
      fragments: [BusinessHoursInfo.self, BusinessInfo.self, CheckInInfo.self]
    ))

  public init() {}

  public struct Data: AmoringAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { AmoringAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("checkOutFromActive", CheckOutFromActive?.self),
    ] }

    public var checkOutFromActive: CheckOutFromActive? { __data["checkOutFromActive"] }

    /// CheckOutFromActive
    ///
    /// Parent Type: `CheckIn`
    public struct CheckOutFromActive: AmoringAPI.SelectionSet {
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
