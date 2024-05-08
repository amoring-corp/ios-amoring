// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public struct BusinessSortBy: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    field: GraphQLEnum<BusinessSortField>,
    order: GraphQLEnum<SortOrder>
  ) {
    __data = InputDict([
      "field": field,
      "order": order
    ])
  }

  public var field: GraphQLEnum<BusinessSortField> {
    get { __data["field"] }
    set { __data["field"] = newValue }
  }

  public var order: GraphQLEnum<SortOrder> {
    get { __data["order"] }
    set { __data["order"] = newValue }
  }
}
