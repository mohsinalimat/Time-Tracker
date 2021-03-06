//
//  Timespan.swift
//  Time Tracker
//
//  Created by Denis Bystruev on 16/04/2019.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

import Foundation

/// Structure which defines the timespan with start and end time
struct Timespan {
    
    /// Enum which defines the current status of a timespan
    ///
    /// - running: timespan is currently counting
    /// - stopped: timespan not started or alredy finished
    enum Status {
        case running
        case stopped
    }
    
    /// Timespan's current status
    var status: Status
    
    /// Optional name of a timespan
    var name: String?
    
    /// Timespan's start time
    var startTime: Date
    
    /// Timespan's end time
    var endTime: Date
    
    /// True if status is .running
    var isRunning: Bool {
        if case .running = status {
            return true
        } else {
            return false
        }
    }
    
    /// Initialize timespan with current date as start and end time
    ///
    /// - Parameters:
    ///   - status: timespan's status, .stopped by default
    ///   - name: optional name of the timespan's
    init(status: Status = .stopped, name: String? = nil) {
        self.status = status
        self.name = name
        startTime = Date()
        endTime = startTime
    }
    
    /// Start this timespan
    mutating func start() {
        if case .stopped = status {
            startTime = Date()
            status = .running
        }
        endTime = Date()
    }
    
    /// Stop this timespan
    mutating func stop() {
        if case .running = status {
            endTime = Date()
            status = .stopped
        }
    }
}

// MARK: - Formatted Duration
extension Timespan: FormattedDuration {
    /// Current duration of the timespan
    var duration: TimeInterval {
        return endTime.timeIntervalSince(startTime)
    }
}
