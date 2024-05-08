// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class BusinessDistrictsQuery: GraphQLQuery {
  public static let operationName: String = "BusinessDistricts"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query BusinessDistricts { businessDistricts { __typename ...DistrictFragment } }"#,
      fragments: [DistrictFragment.self]
    ))

  public init() {}

  public struct Data: AmoringAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("businessDistricts", [BusinessDistrict]?.self),
    ] }

    public var businessDistricts: [BusinessDistrict]? { __data["businessDistricts"] }

    /// BusinessDistrict
    ///
    /// Parent Type: `BusinessDistrict`
    public struct BusinessDistrict: AmoringAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.BusinessDistrict }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .fragment(DistrictFragment.self),
      ] }

      public var id: AmoringAPI.ID { __data["id"] }
      public var code: String { __data["code"] }
      public var name: String { __data["name"] }
      public var count: Int { __data["count"] }

      public struct Fragments: FragmentContainer {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public var districtFragment: DistrictFragment { _toFragment() }
      }
    }
  }
}
