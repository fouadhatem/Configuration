/*
 * Copyright IBM Corporation 2017
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import Foundation

/// Absolute path to the executable
let executableFolderAbsolutePath = URL(fileURLWithPath: CommandLine.arguments[0]).appendingPathComponent("..").standardized.path

func deserialize(data: Data, type: DataType) throws -> Any {
    switch type {
    case .JSON:
        return try JSONSerialization.jsonObject(with: data)
    case .PLIST:
        return try PropertyListSerialization.propertyList(from: data, format: nil)
    }
}

enum DataType {
    case JSON
    case PLIST

    init?(_ fileExtension: String) {
        switch fileExtension.lowercased() {
        case ".json":
            self = .JSON
        case ".plist":
            self = .PLIST
        default:
            return nil
        }
    }
}
