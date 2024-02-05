// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class BatchUpsertBusinessHoursMutation: GraphQLMutation {
  public static let operationName: String = "BatchUpsertBusinessHours"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation BatchUpsertBusinessHours($businessId: ID!, $data: [BusinessHoursInput!]!) { batchUpsertBusinessHours(businessId: $businessId, data: $data) { __typename id day openAt closeAt } }"#
    ))

  public var businessId: ID
  public var data: [BusinessHoursInput]

  public init(
    businessId: ID,
    data: [BusinessHoursInput]
  ) {
    self.businessId = businessId
    self.data = data
  }

  public var __variables: Variables? { [
    "businessId": businessId,
    "data": data
  ] }

  public struct Data: AmoringAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("batchUpsertBusinessHours", [BatchUpsertBusinessHour?].self, arguments: [
        "businessId": .variable("businessId"),
        "data": .variable("data")
      ]),
    ] }

    public var batchUpsertBusinessHours: [BatchUpsertBusinessHour?] { __data["batchUpsertBusinessHours"] }

    /// BatchUpsertBusinessHour
    ///
    /// Parent Type: `BusinessHours`
    public struct BatchUpsertBusinessHour: AmoringAPI.SelectionSet {
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
