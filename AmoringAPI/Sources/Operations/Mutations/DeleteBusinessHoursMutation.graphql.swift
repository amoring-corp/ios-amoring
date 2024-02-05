// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class DeleteBusinessHoursMutation: GraphQLMutation {
  public static let operationName: String = "DeleteBusinessHours"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation DeleteBusinessHours($businessId: ID!, $day: Day!) { deleteBusinessHours(businessId: $businessId, day: $day) }"#
    ))

  public var businessId: ID
  public var day: GraphQLEnum<Day>

  public init(
    businessId: ID,
    day: GraphQLEnum<Day>
  ) {
    self.businessId = businessId
    self.day = day
  }

  public var __variables: Variables? { [
    "businessId": businessId,
    "day": day
  ] }

  public struct Data: AmoringAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("deleteBusinessHours", AmoringAPI.ID.self, arguments: [
        "businessId": .variable("businessId"),
        "day": .variable("day")
      ]),
    ] }

    public var deleteBusinessHours: AmoringAPI.ID { __data["deleteBusinessHours"] }
  }
}
