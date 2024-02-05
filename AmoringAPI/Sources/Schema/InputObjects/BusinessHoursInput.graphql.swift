// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public struct BusinessHoursInput: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    day: GraphQLEnum<Day>,
    openAt: LocalTime,
    closeAt: LocalTime
  ) {
    __data = InputDict([
      "day": day,
      "openAt": openAt,
      "closeAt": closeAt
    ])
  }

  public var day: GraphQLEnum<Day> {
    get { __data["day"] }
    set { __data["day"] = newValue }
  }

  public var openAt: LocalTime {
    get { __data["openAt"] }
    set { __data["openAt"] = newValue }
  }

  public var closeAt: LocalTime {
    get { __data["closeAt"] }
    set { __data["closeAt"] = newValue }
  }
}
