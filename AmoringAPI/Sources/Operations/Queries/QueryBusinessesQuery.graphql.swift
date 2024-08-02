// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class QueryBusinessesQuery: GraphQLQuery {
  public static let operationName: String = "QueryBusinesses"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query QueryBusinesses($near: NearLocationInput, $districts: [String!], $sort: BusinessSortBy, $typeId: [String!], $nearByOnly: Boolean!, $take: Int, $skip: Int) { businesses( near: $near districts: $districts sort: $sort typeId: $typeId nearByOnly: $nearByOnly take: $take skip: $skip ) { __typename items { __typename ...BusinessInfo } total } }"#,
      fragments: [BusinessHoursInfo.self, BusinessInfo.self]
    ))

  public var near: GraphQLNullable<NearLocationInput>
  public var districts: GraphQLNullable<[String]>
  public var sort: GraphQLNullable<BusinessSortBy>
  public var typeId: GraphQLNullable<[String]>
  public var nearByOnly: Bool
  public var take: GraphQLNullable<Int>
  public var skip: GraphQLNullable<Int>

  public init(
    near: GraphQLNullable<NearLocationInput>,
    districts: GraphQLNullable<[String]>,
    sort: GraphQLNullable<BusinessSortBy>,
    typeId: GraphQLNullable<[String]>,
    nearByOnly: Bool,
    take: GraphQLNullable<Int>,
    skip: GraphQLNullable<Int>
  ) {
    self.near = near
    self.districts = districts
    self.sort = sort
    self.typeId = typeId
    self.nearByOnly = nearByOnly
    self.take = take
    self.skip = skip
  }

  public var __variables: Variables? { [
    "near": near,
    "districts": districts,
    "sort": sort,
    "typeId": typeId,
    "nearByOnly": nearByOnly,
    "take": take,
    "skip": skip
  ] }

  public struct Data: AmoringAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("businesses", Businesses.self, arguments: [
        "near": .variable("near"),
        "districts": .variable("districts"),
        "sort": .variable("sort"),
        "typeId": .variable("typeId"),
        "nearByOnly": .variable("nearByOnly"),
        "take": .variable("take"),
        "skip": .variable("skip")
      ]),
    ] }

    public var businesses: Businesses { __data["businesses"] }

    /// Businesses
    ///
    /// Parent Type: `BusinessesList`
    public struct Businesses: AmoringAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.BusinessesList }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("items", [Item].self),
        .field("total", Int.self),
      ] }

      public var items: [Item] { __data["items"] }
      public var total: Int { __data["total"] }

      /// Businesses.Item
      ///
      /// Parent Type: `Business`
      public struct Item: AmoringAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Business }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .fragment(BusinessInfo.self),
        ] }

        public var id: AmoringAPI.ID { __data["id"] }
        public var ownerId: String? { __data["ownerId"] }
        public var businessName: String? { __data["businessName"] }
        public var businessType: BusinessType? { __data["businessType"] }
        public var businessIndustry: String? { __data["businessIndustry"] }
        public var businessCategory: String? { __data["businessCategory"] }
        public var businessHours: [BusinessHour?]? { __data["businessHours"] }
        public var activeCheckIns: [ActiveCheckIn?] { __data["activeCheckIns"] }
        public var address: String? { __data["address"] }
        public var addressBname: String? { __data["addressBname"] }
        public var addressDetails: String? { __data["addressDetails"] }
        public var addressJibun: String? { __data["addressJibun"] }
        public var addressSido: String? { __data["addressSido"] }
        public var addressSigungu: String? { __data["addressSigungu"] }
        public var addressSigunguCode: String? { __data["addressSigunguCode"] }
        public var addressSigunguEnglish: String? { __data["addressSigunguEnglish"] }
        public var addressZonecode: String? { __data["addressZonecode"] }
        public var bio: String? { __data["bio"] }
        public var representativeTitle: String? { __data["representativeTitle"] }
        public var representativeName: String? { __data["representativeName"] }
        public var phoneNumber: String? { __data["phoneNumber"] }
        public var registrationNumber: String? { __data["registrationNumber"] }
        public var images: [Image?]? { __data["images"] }
        public var lat: Double? { __data["lat"] }
        public var lng: Double? { __data["lng"] }
        public var isActive: Bool? { __data["isActive"] }
        public var createdAt: AmoringAPI.DateTime? { __data["createdAt"] }
        public var updatedAt: AmoringAPI.DateTime? { __data["updatedAt"] }

        public struct Fragments: FragmentContainer {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public var businessInfo: BusinessInfo { _toFragment() }
        }

        public typealias BusinessType = BusinessInfo.BusinessType

        /// Businesses.Item.BusinessHour
        ///
        /// Parent Type: `BusinessHours`
        public struct BusinessHour: AmoringAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.BusinessHours }

          public var openAt: AmoringAPI.LocalTime { __data["openAt"] }
          public var closeAt: AmoringAPI.LocalTime { __data["closeAt"] }
          public var day: GraphQLEnum<AmoringAPI.Day> { __data["day"] }

          public struct Fragments: FragmentContainer {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public var businessHoursInfo: BusinessHoursInfo { _toFragment() }
          }
        }

        public typealias ActiveCheckIn = BusinessInfo.ActiveCheckIn

        public typealias Image = BusinessInfo.Image
      }
    }
  }
}
