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
    case "UserProfile": return AmoringAPI.Objects.UserProfile
    case "UserProfileImage": return AmoringAPI.Objects.UserProfileImage
    case "File": return AmoringAPI.Objects.File
    case "Interest": return AmoringAPI.Objects.Interest
    case "InterestCategory": return AmoringAPI.Objects.InterestCategory
    case "Business": return AmoringAPI.Objects.Business
    case "Query": return AmoringAPI.Objects.Query
    case "SignUpResult": return AmoringAPI.Objects.SignUpResult
    case "BusinessImage": return AmoringAPI.Objects.BusinessImage
    default: return nil
    }
  }
}

public enum Objects {}
public enum Interfaces {}
public enum Unions {}