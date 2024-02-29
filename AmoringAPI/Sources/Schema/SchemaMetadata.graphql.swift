// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public typealias ID = String

public protocol SelectionSet: ApolloAPI.SelectionSet & ApolloAPI.RootSelectionSet
where Schema == AmoringAPI.SchemaMetadata {}

public protocol InlineFragment: ApolloAPI.SelectionSet & ApolloAPI.InlineFragment
where Schema == AmoringAPI.SchemaMetadata {}

public protocol MutableSelectionSet: ApolloAPI.MutableRootSelectionSet
where Schema == AmoringAPI.SchemaMetadata {}

public protocol MutableInlineFragment: ApolloAPI.MutableSelectionSet & ApolloAPI.InlineFragment
where Schema == AmoringAPI.SchemaMetadata {}

public enum SchemaMetadata: ApolloAPI.SchemaMetadata {
  public static let configuration: ApolloAPI.SchemaConfiguration.Type = SchemaConfiguration.self

  public static func objectType(forTypename typename: String) -> ApolloAPI.Object? {
    switch typename {
    case "Mutation": return AmoringAPI.Objects.Mutation
    case "SignInResult": return AmoringAPI.Objects.SignInResult
    case "User": return AmoringAPI.Objects.User
    case "Profile": return AmoringAPI.Objects.Profile
    case "ProfileImage": return AmoringAPI.Objects.ProfileImage
    case "File": return AmoringAPI.Objects.File
    case "Interest": return AmoringAPI.Objects.Interest
    case "InterestCategory": return AmoringAPI.Objects.InterestCategory
    case "Business": return AmoringAPI.Objects.Business
    case "Query": return AmoringAPI.Objects.Query
    case "CheckIn": return AmoringAPI.Objects.CheckIn
    case "BusinessImage": return AmoringAPI.Objects.BusinessImage
    case "BusinessHours": return AmoringAPI.Objects.BusinessHours
    case "Conversation": return AmoringAPI.Objects.Conversation
    case "Message": return AmoringAPI.Objects.Message
    case "SignUpResult": return AmoringAPI.Objects.SignUpResult
    case "CheckInToken": return AmoringAPI.Objects.CheckInToken
    case "Reaction": return AmoringAPI.Objects.Reaction
    case "Report": return AmoringAPI.Objects.Report
    default: return nil
    }
  }
}

public enum Objects {}
public enum Interfaces {}
public enum Unions {}
