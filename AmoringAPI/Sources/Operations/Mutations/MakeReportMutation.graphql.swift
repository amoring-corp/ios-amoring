// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class MakeReportMutation: GraphQLMutation {
  public static let operationName: String = "MakeReport"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation MakeReport($data: MakeReportInput!) { makeReport(data: $data) { __typename id byUserId email subject body type byUser { __typename id email status role createdAt updatedAt } createdAt updatedAt } }"#
    ))

  public var data: MakeReportInput

  public init(data: MakeReportInput) {
    self.data = data
  }

  public var __variables: Variables? { ["data": data] }

  public struct Data: AmoringAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("makeReport", MakeReport.self, arguments: ["data": .variable("data")]),
    ] }

    public var makeReport: MakeReport { __data["makeReport"] }

    /// MakeReport
    ///
    /// Parent Type: `Report`
    public struct MakeReport: AmoringAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Report }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("id", AmoringAPI.ID.self),
        .field("byUserId", Int.self),
        .field("email", String?.self),
        .field("subject", String?.self),
        .field("body", String?.self),
        .field("type", GraphQLEnum<AmoringAPI.ReportType>?.self),
        .field("byUser", ByUser.self),
        .field("createdAt", AmoringAPI.DateTime?.self),
        .field("updatedAt", AmoringAPI.DateTime?.self),
      ] }

      public var id: AmoringAPI.ID { __data["id"] }
      public var byUserId: Int { __data["byUserId"] }
      public var email: String? { __data["email"] }
      public var subject: String? { __data["subject"] }
      public var body: String? { __data["body"] }
      public var type: GraphQLEnum<AmoringAPI.ReportType>? { __data["type"] }
      public var byUser: ByUser { __data["byUser"] }
      public var createdAt: AmoringAPI.DateTime? { __data["createdAt"] }
      public var updatedAt: AmoringAPI.DateTime? { __data["updatedAt"] }

      /// MakeReport.ByUser
      ///
      /// Parent Type: `User`
      public struct ByUser: AmoringAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.User }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", AmoringAPI.ID.self),
          .field("email", String?.self),
          .field("status", GraphQLEnum<AmoringAPI.UserStatus>?.self),
          .field("role", GraphQLEnum<AmoringAPI.UserRole>?.self),
          .field("createdAt", AmoringAPI.DateTime?.self),
          .field("updatedAt", AmoringAPI.DateTime?.self),
        ] }

        public var id: AmoringAPI.ID { __data["id"] }
        public var email: String? { __data["email"] }
        public var status: GraphQLEnum<AmoringAPI.UserStatus>? { __data["status"] }
        public var role: GraphQLEnum<AmoringAPI.UserRole>? { __data["role"] }
        public var createdAt: AmoringAPI.DateTime? { __data["createdAt"] }
        public var updatedAt: AmoringAPI.DateTime? { __data["updatedAt"] }
      }
    }
  }
}
