'''
A Queue is a collection of elements, supporting two principle operations: enqueue, which inserts an element into the queue, and dequeue, which removes an element from the queue.

First in, first out data structure (FIFO): the oldest added object is the first to be removed.
'''

# It creates an empty queue, sets the head node to nil and the queue’s length to 0.
# O(1)
def initialize
    self.head   = nil
    self.length = 0
end

# Creates a new node to insert a value into the queue. If the queue has no nodes, the new node becomes the head of the queue; 
# otherwise, it’s appended at the tail of the queue.
# O(1)
def enqueue data
    node = Node.new data
    unless head
        self.head = node
    else
        self.tail.next = node
    end
    self.tail    = node
    self.length += 1
end

# Removes an element from the head of queue.
# To remove an element from the queue, 
# we point the head to the node that it’s next to it and set tail to nil if the queue contains just one element.
# O(1)
def dequeue
    return nil unless self.length > 0
    self.head = self.head.next
    self.tail = nil if self.length == 1
    self.length -= 1
end

# Returns the node that’s at the head of the queue without removing it or nil if the queue is empty.
# O(1)
def peek
    self.head
end

# Dequeues all elements from the queue.
# O(n)
def clear
    while self.peek
        dequeue
    end
end

# This method walks the queue yielding one at a time until it reaches the last element.
# The complexity to yield the next item in the queue is O(1). The complexity to yield the whole queue is O(n).
def each
    return nil unless block_given?current = self.head
    while current
        yield current
        current = current.next
    end
end

# Print the contents of the queue by walking its items.
# O(n)
def print
    if self.length == 0
        puts "empty"
    else
        self.each { |node| puts node.data }
    end
end

'''
Time Complexity:
Access: O(n)
Search: O(n)
Insert: O(1)
Remove: O(1)
'''