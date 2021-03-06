//
//  Job.swift
//  Time Tracker
//
//  Created by Denis Bystruev on 16/04/2019.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

import Foundation

/// Structure which defines a single job with multiple timespans
struct Job {
    /// Job's name
    var name: String
    
    /// Collection of job's timespans
    var timespans: [Timespan]
    
    /// True if at least one timespan is running
    var isRunning: Bool {
        return timespans.reduce(false) { $0 || $1.isRunning }
    }
    
    /// Returns indexes of running timespans
    var indexesOfRunningTimespans: [Int] {
        let indexes = timespans.enumerated().filter({ $0.element.isRunning }).map { $0.offset }
        return indexes
    }
    
    init(name: String, timespans: [Timespan] = []) {
        self.name = name
        self.timespans = timespans
    }
    
    /// Start new timespan
    mutating func startNewTimespan() {
        // stop all timespans and create new timespan
        stop()
        let timespan = Timespan(status: .running)
        timespans.append(timespan)
    }
    
    /// Stop this job
    mutating func stop() {
        // stop all timespans
        for index in 0 ..< timespans.count {
            timespans[index].stop()
        }
    }
}

// MARK: - Formatted Duration
extension Job: FormattedDuration {
    /// Current duration of the job = sum of durations of the timespans
    var duration: TimeInterval {
        return timespans.reduce(0) { $0 + $1.duration }
    }
}

// MARK: - extension [Job]
extension Array where Element == Job {
    /// True if at least one job is running
    var areRunning: Bool {
        return reduce(false) { $0 || $1.isRunning }
    }
    
    /// Create and start a new job
    mutating func startNewJob() {
        // stop all jobs, create and start a new one
        stop()
        var job = Job(name: "Job # \(count + 1)")
        job.startNewTimespan()
        append(job)
    }
    
    /// Stop all jobs
    mutating func stop() {
        for index in 0 ..< count {
            self[index].stop()
        }
    }
}
