// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public struct BusinessUpdateInput: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    ownerId: GraphQLNullable<String> = nil,
    businessName: GraphQLNullable<String> = nil,
    businessType: GraphQLNullable<String> = nil,
    businessIndustry: GraphQLNullable<String> = nil,
    businessCategory: GraphQLNullable<String> = nil,
    address: GraphQLNullable<String> = nil,
    addressJibun: GraphQLNullable<String> = nil,
    addressSido: GraphQLNullable<String> = nil,
    addressSigungu: GraphQLNullable<String> = nil,
    addressSigunguCode: GraphQLNullable<String> = nil,
    addressSigunguEnglish: GraphQLNullable<String> = nil,
    addressBname: GraphQLNullable<String> = nil,
    addressZonecode: GraphQLNullable<String> = nil,
    addressDetails: GraphQLNullable<String> = nil,
    representativeTitle: GraphQLNullable<String> = nil,
    representativeName: GraphQLNullable<String> = nil,
    phoneNumber: GraphQLNullable<String> = nil,
    registrationNumber: GraphQLNullable<String> = nil,
    category: GraphQLNullable<String> = nil,
    bio: GraphQLNullable<String> = nil,
    latitude: GraphQLNullable<Double> = nil,
    longitude: GraphQLNullable<Double> = nil
  ) {
    __data = InputDict([
      "ownerId": ownerId,
      "businessName": businessName,
      "businessType": businessType,
      "businessIndustry": businessIndustry,
      "businessCategory": businessCategory,
      "address": address,
      "addressJibun": addressJibun,
      "addressSido": addressSido,
      "addressSigungu": addressSigungu,
      "addressSigunguCode": addressSigunguCode,
      "addressSigunguEnglish": addressSigunguEnglish,
      "addressBname": addressBname,
      "addressZonecode": addressZonecode,
      "addressDetails": addressDetails,
      "representativeTitle": representativeTitle,
      "representativeName": representativeName,
      "phoneNumber": phoneNumber,
      "registrationNumber": registrationNumber,
      "category": category,
      "bio": bio,
      "latitude": latitude,
      "longitude": longitude
    ])
  }

  public var ownerId: GraphQLNullable<String> {
    get { __data["ownerId"] }
    set { __data["ownerId"] = newValue }
  }

  public var businessName: GraphQLNullable<String> {
    get { __data["businessName"] }
    set { __data["businessName"] = newValue }
  }

  public var businessType: GraphQLNullable<String> {
    get { __data["businessType"] }
    set { __data["businessType"] = newValue }
  }

  public var businessIndustry: GraphQLNullable<String> {
    get { __data["businessIndustry"] }
    set { __data["businessIndustry"] = newValue }
  }

  public var businessCategory: GraphQLNullable<String> {
    get { __data["businessCategory"] }
    set { __data["businessCategory"] = newValue }
  }

  public var address: GraphQLNullable<String> {
    get { __data["address"] }
    set { __data["address"] = newValue }
  }

  public var addressJibun: GraphQLNullable<String> {
    get { __data["addressJibun"] }
    set { __data["addressJibun"] = newValue }
  }

  public var addressSido: GraphQLNullable<String> {
    get { __data["addressSido"] }
    set { __data["addressSido"] = newValue }
  }

  public var addressSigungu: GraphQLNullable<String> {
    get { __data["addressSigungu"] }
    set { __data["addressSigungu"] = newValue }
  }

  public var addressSigunguCode: GraphQLNullable<String> {
    get { __data["addressSigunguCode"] }
    set { __data["addressSigunguCode"] = newValue }
  }

  public var addressSigunguEnglish: GraphQLNullable<String> {
    get { __data["addressSigunguEnglish"] }
    set { __data["addressSigunguEnglish"] = newValue }
  }

  public var addressBname: GraphQLNullable<String> {
    get { __data["addressBname"] }
    set { __data["addressBname"] = newValue }
  }

  public var addressZonecode: GraphQLNullable<String> {
    get { __data["addressZonecode"] }
    set { __data["addressZonecode"] = newValue }
  }

  public var addressDetails: GraphQLNullable<String> {
    get { __data["addressDetails"] }
    set { __data["addressDetails"] = newValue }
  }

  public var representativeTitle: GraphQLNullable<String> {
    get { __data["representativeTitle"] }
    set { __data["representativeTitle"] = newValue }
  }

  public var representativeName: GraphQLNullable<String> {
    get { __data["representativeName"] }
    set { __data["representativeName"] = newValue }
  }

  public var phoneNumber: GraphQLNullable<String> {
    get { __data["phoneNumber"] }
    set { __data["phoneNumber"] = newValue }
  }

  public var registrationNumber: GraphQLNullable<String> {
    get { __data["registrationNumber"] }
    set { __data["registrationNumber"] = newValue }
  }

  public var category: GraphQLNullable<String> {
    get { __data["category"] }
    set { __data["category"] = newValue }
  }

  public var bio: GraphQLNullable<String> {
    get { __data["bio"] }
    set { __data["bio"] = newValue }
  }

  public var latitude: GraphQLNullable<Double> {
    get { __data["latitude"] }
    set { __data["latitude"] = newValue }
  }

  public var longitude: GraphQLNullable<Double> {
    get { __data["longitude"] }
    set { __data["longitude"] = newValue }
  }
}
