/**
* Copyright (C) 2015 GraphKit, Inc. <http://graphkit.io> and other GraphKit contributors.
*
* This program is free software: you can redistribute it and/or modify
* it under the terms of the GNU Affero General Public License as published
* by the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU Affero General Public License for more details.
*
* You should have received a copy of the GNU Affero General Public License
* along with this program located at the root of the software package
* in a file called LICENSE.  If not, see <http://www.gnu.org/licenses/>.
*/

import CoreData

@objc(GKAction)
public class GKAction : NSObject {
    private let node: GKManagedAction!
    private lazy var graph: GKGraph = GKGraph()

    public var type: String {
        var type: String!
        graph.managedObjectContext.performBlockAndWait({ () -> Void in
            type = self.node.type
        })
        return type
    }

    public var createdDate: NSDate {
        var createdDate: NSDate!
        graph.managedObjectContext.performBlockAndWait({ () -> Void in
            createdDate = self.node.createdDate
        })
        return createdDate
    }

    init(node: GKManagedAction!) {
        super.init()
        self.node = node
    }

    public init(type: String) {
        super.init()
        graph.managedObjectContext.performBlockAndWait({ () -> Void in
            self.node = GKManagedAction(type: type)
        })
    }

    public func archive() {
        graph.managedObjectContext.performBlockAndWait({ () -> Void in
            self.node.archive(self.graph)
        })
    }

    public subscript(property: String) -> AnyObject? {
        get {
            var value: AnyObject?
            graph.managedObjectContext.performBlockAndWait({ () -> Void in
                value = self.node[property]
            })
            return value
        }
        set(value) {
            graph.managedObjectContext.performBlockAndWait({ () -> Void in
                self.node[property] = value
            })
        }
    }
}
