// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.
/*
 * Copyright (c) Meta Platforms, Inc. and affiliates.
 * All rights reserved.
 *
 * This source code is licensed under the license found in the
 * LICENSE file in the root directory of this source tree.
 */

import Foundation
import PackageDescription

let sdkName = "FBAudienceNetwork"
let sdkVersion = "6.21.1"
let sdkCdnBaseUrl = "https://github.com/hershalle/FBAudienceNetwork/releases/download"
let sdkChecksum = "59f228521a1700a41cfd63f8d4da214b20e957aebf2f3947cfe0f1a60ec12e07"

let package = Package(
  name: sdkName,
  platforms: [.iOS(.v15)],
  products: [
    .ansdk
  ],
  dependencies: [
    .package(url: "https://github.com/facebookincubator/QuickLayout", .branch("main"))
  ],
  targets: [
    .wrapper,
    .ansdk
  ]
)

extension Product {
  static let ansdk = library(name: sdkName, targets: ["\(sdkName)Wrapper"])
}

extension Target {
  static let wrapper = target(
    name: "\(sdkName)Wrapper",
    dependencies: [
      .target(name: "\(sdkName)Binary"),
      .product(name: "QuickLayout", package: "QuickLayout"),
      .product(name: "FastResultBuilder", package: "QuickLayout"),
    ],
    path: "Sources"
  )

  static let ansdk = binaryTarget(
    name: "\(sdkName)Binary",
    url: "\(sdkCdnBaseUrl)/\(sdkVersion)/\(sdkName)-\(sdkVersion)-SPM.zip",
    checksum: sdkChecksum
  )
}