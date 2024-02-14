// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public struct MakeReportInput: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    email: GraphQLNullable<String> = nil,
    subject: GraphQLNullable<String> = nil,
    body: GraphQLNullable<String> = nil,
    type: GraphQLNullable<GraphQLEnum<ReportType>> = nil
  ) {
    __data = InputDict([
      "email": email,
      "subject": subject,
      "body": body,
      "type": type
    ])
  }

  public var email: GraphQLNullable<String> {
    get { __data["email"] }
    set { __data["email"] = newValue }
  }

  public var subject: GraphQLNullable<String> {
    get { __data["subject"] }
    set { __data["subject"] = newValue }
  }

  public var body: GraphQLNullable<String> {
    get { __data["body"] }
    set { __data["body"] = newValue }
  }

  public var type: GraphQLNullable<GraphQLEnum<ReportType>> {
    get { __data["type"] }
    set { __data["type"] = newValue }
  }
}
