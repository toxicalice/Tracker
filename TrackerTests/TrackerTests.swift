//
//  TrackerTests.swift
//  TrackerTests
//
//  Created by Алиса Долматова on 26.05.2023.
//

import XCTest
@testable import Tracker
import SnapshotTesting

final class TrackerTests: XCTestCase {

        func testViewController() {
            let vc = TrackersViewController()
            
            assertSnapshot(matching: vc, as: .image)
        }

}
