// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public struct UserProfileImageInput: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    sort: GraphQLNullable<Int> = nil,
    file: Upload
  ) {
    __data = InputDict([
      "sort": sort,
      "file": file
    ])
  }

  public var sort: GraphQLNullable<Int> {
    get { __data["sort"] }
    set { __data["sort"] = newValue }
  }

  public var file: Upload {
    get { __data["file"] }
    set { __data["file"] = newValue }
  }
}
