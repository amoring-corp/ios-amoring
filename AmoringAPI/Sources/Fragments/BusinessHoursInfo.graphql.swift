// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public struct BusinessHoursInfo: AmoringAPI.SelectionSet, Fragment {
  public static var fragmentDefinition: StaticString {
    #"fragment BusinessHoursInfo on BusinessHours { __typename openAt closeAt day }"#
  }

  public let __data: DataDict
  public init(_dataDict: DataDict) { __data = _dataDict }

  public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.BusinessHours }
  public static var __selections: [ApolloAPI.Selection] { [
    .field("__typename", String.self),
    .field("openAt", AmoringAPI.LocalTime.self),
    .field("closeAt", AmoringAPI.LocalTime.self),
    .field("day", GraphQLEnum<AmoringAPI.Day>.self),
  ] }

  public var openAt: AmoringAPI.LocalTime { __data["openAt"] }
  public var closeAt: AmoringAPI.LocalTime { __data["closeAt"] }
  public var day: GraphQLEnum<AmoringAPI.Day> { __data["day"] }
}
