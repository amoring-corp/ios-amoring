// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class BusinessHoursQuery: GraphQLQuery {
  public static let operationName: String = "BusinessHours"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query BusinessHours($businessId: ID!) { businessHours(businessId: $businessId) { __typename id day openAt closeAt } }"#
    ))

  public var businessId: ID

  public init(businessId: ID) {
    self.businessId = businessId
  }

  public var __variables: Variables? { ["businessId": businessId] }

  public struct Data: AmoringAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("businessHours", [BusinessHour?].self, arguments: ["businessId": .variable("businessId")]),
    ] }

    public var businessHours: [BusinessHour?] { __data["businessHours"] }

    /// BusinessHour
    ///
    /// Parent Type: `BusinessHours`
    public struct BusinessHour: AmoringAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.BusinessHours }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("id", AmoringAPI.ID.self),
        .field("day", GraphQLEnum<AmoringAPI.Day>.self),
        .field("openAt", AmoringAPI.LocalTime.self),
        .field("closeAt", AmoringAPI.LocalTime.self),
      ] }

      public var id: AmoringAPI.ID { __data["id"] }
      public var day: GraphQLEnum<AmoringAPI.Day> { __data["day"] }
      public var openAt: AmoringAPI.LocalTime { __data["openAt"] }
      public var closeAt: AmoringAPI.LocalTime { __data["closeAt"] }
    }
  }
}
