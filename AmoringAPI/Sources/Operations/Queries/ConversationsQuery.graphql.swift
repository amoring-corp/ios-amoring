// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class ConversationsQuery: GraphQLQuery {
  public static let operationName: String = "Conversations"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query Conversations { conversations { __typename ...ConversationInfo } }"#,
      fragments: [BusinessHoursInfo.self, BusinessInfo.self, ConversationInfo.self, ImageFragment.self, MessageInfo.self, ProfileInfo.self, UserInfo.self]
    ))

  public init() {}

  public struct Data: AmoringAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("conversations", [Conversation].self),
    ] }

    public var conversations: [Conversation] { __data["conversations"] }

    /// Conversation
    ///
    /// Parent Type: `Conversation`
    public struct Conversation: AmoringAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Conversation }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .fragment(ConversationInfo.self),
      ] }

      public var id: AmoringAPI.ID { __data["id"] }
      public var status: GraphQLEnum<AmoringAPI.ConversationStatus> { __data["status"] }
      public var participants: [Participant?] { __data["participants"] }
      public var messages: [Message?] { __data["messages"] }
      public var createdAt: AmoringAPI.DateTime? { __data["createdAt"] }
      public var archivedAt: AmoringAPI.DateTime? { __data["archivedAt"] }
      public var updatedAt: AmoringAPI.DateTime? { __data["updatedAt"] }

      public struct Fragments: FragmentContainer {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public var conversationInfo: ConversationInfo { _toFragment() }
      }

      /// Conversation.Participant
      ///
      /// Parent Type: `User`
      public struct Participant: AmoringAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.User }

        public var id: AmoringAPI.ID { __data["id"] }
        public var email: String? { __data["email"] }
        public var status: GraphQLEnum<AmoringAPI.UserStatus>? { __data["status"] }
        public var role: GraphQLEnum<AmoringAPI.UserRole>? { __data["role"] }
        public var profile: Profile? { __data["profile"] }
        public var business: Business? { __data["business"] }
        public var createdAt: AmoringAPI.DateTime? { __data["createdAt"] }
        public var updatedAt: AmoringAPI.DateTime? { __data["updatedAt"] }

        public struct Fragments: FragmentContainer {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public var userInfo: UserInfo { _toFragment() }
        }

        /// Conversation.Participant.Profile
        ///
        /// Parent Type: `Profile`
        public struct Profile: AmoringAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Profile }

          public var id: AmoringAPI.ID { __data["id"] }
          public var userId: String { __data["userId"] }
          public var name: String? { __data["name"] }
          public var age: Int? { __data["age"] }
          public var birthYear: Int? { __data["birthYear"] }
          public var height: Int? { __data["height"] }
          public var weight: Int? { __data["weight"] }
          public var mbti: String? { __data["mbti"] }
          public var education: String? { __data["education"] }
          public var occupation: String? { __data["occupation"] }
          public var bio: String? { __data["bio"] }
          public var gender: GraphQLEnum<AmoringAPI.Gender>? { __data["gender"] }
          public var images: [Image?]? { __data["images"] }
          public var interests: [Interest?]? { __data["interests"] }
          public var createdAt: AmoringAPI.DateTime? { __data["createdAt"] }
          public var updatedAt: AmoringAPI.DateTime? { __data["updatedAt"] }

          public struct Fragments: FragmentContainer {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public var profileInfo: ProfileInfo { _toFragment() }
          }

          /// Conversation.Participant.Profile.Image
          ///
          /// Parent Type: `ProfileImage`
          public struct Image: AmoringAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.ProfileImage }

            public var id: AmoringAPI.ID { __data["id"] }
            public var file: File { __data["file"] }

            public struct Fragments: FragmentContainer {
              public let __data: DataDict
              public init(_dataDict: DataDict) { __data = _dataDict }

              public var imageFragment: ImageFragment { _toFragment() }
            }

            public typealias File = ImageFragment.File
          }

          public typealias Interest = ProfileInfo.Interest
        }

        /// Conversation.Participant.Business
        ///
        /// Parent Type: `Business`
        public struct Business: AmoringAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Business }

          public var id: AmoringAPI.ID { __data["id"] }
          public var ownerId: String? { __data["ownerId"] }
          public var businessName: String? { __data["businessName"] }
          public var businessType: String? { __data["businessType"] }
          public var businessIndustry: String? { __data["businessIndustry"] }
          public var businessCategory: String? { __data["businessCategory"] }
          public var businessHours: [BusinessHour?]? { __data["businessHours"] }
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
          public var activeCheckIns: [ActiveCheckIn?] { __data["activeCheckIns"] }
          public var latitude: Double? { __data["latitude"] }
          public var longitude: Double? { __data["longitude"] }
          public var createdAt: AmoringAPI.DateTime? { __data["createdAt"] }
          public var updatedAt: AmoringAPI.DateTime? { __data["updatedAt"] }

          public struct Fragments: FragmentContainer {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public var businessInfo: BusinessInfo { _toFragment() }
          }

          /// Conversation.Participant.Business.BusinessHour
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

          public typealias Image = BusinessInfo.Image

          public typealias ActiveCheckIn = BusinessInfo.ActiveCheckIn
        }
      }

      /// Conversation.Message
      ///
      /// Parent Type: `Message`
      public struct Message: AmoringAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Message }

        public var id: AmoringAPI.ID { __data["id"] }
        public var conversationId: String? { __data["conversationId"] }
        public var body: String { __data["body"] }
        public var senderId: String? { __data["senderId"] }
        public var sender: Sender? { __data["sender"] }
        public var createdAt: AmoringAPI.DateTime? { __data["createdAt"] }
        public var updatedAt: AmoringAPI.DateTime? { __data["updatedAt"] }

        public struct Fragments: FragmentContainer {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public var messageInfo: MessageInfo { _toFragment() }
        }

        public typealias Sender = MessageInfo.Sender
      }
    }
  }
}
