//
//  Copyright © 2019 Essential Developer. All rights reserved.
//

import Foundation

public typealias CachedFeed = (feed: [LocalFeedImage], timestamp: Date)

public protocol FeedStore {
    typealias Result = Swift.Result<CachedFeed?, Error>
    typealias DeletionResult = Swift.Result<Void, Error>
    typealias DeletionCompletion = (DeletionResult) -> Void
    typealias InsertionResult = Swift.Result<Void, Error>
	typealias InsertionCompletion = (InsertionResult) -> Void
	typealias RetrievalCompletion = (Result) -> Void
    
	/// The completion handler can be invoked in any thread.
	/// Clients are responsible to dispatch to appropriate threads, if needed.
	func deleteCachedFeed(completion: @escaping DeletionCompletion)
	
	/// The completion handler can be invoked in any thread.
	/// Clients are responsible to dispatch to appropriate threads, if needed.
	func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion)
	
	/// The completion handler can be invoked in any thread.
	/// Clients are responsible to dispatch to appropriate threads, if needed.
	func retrieve(completion: @escaping RetrievalCompletion)
}
