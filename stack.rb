'''
A Stack is a collection of elements, with two principle operations: push, which adds to the collection, and pop, which removes the most recently added element.
Last in, first out data structure (LIFO): the most recently added object is the first to be removed

Stacks are great at managing instruction sequences, parsing expressions, and solving operators precedence.
'''

#t creates an empty stack, 
#sets the head node to nil and the stack’s length to 0
# O(1)
def initialize
    self.head   = nil
    self.length = 0
end

#Creates a new node to insert a value into the stack. 
#The new node moves the element that’s at the head of the list and becomes the new head of the list.
# O(1)
def push data
    node = Node.new data
    if length == 0
        self.tail = node
    end    node.next = self.head
    self.head = node
    self.length += 1
end

# Removes an element from the stack. 
# To remove an element from the stack, we point the head to the node that it’s next to it and set tail to nil if the stack contains just one element.
# O(1)
def pop
    return nil unless self.length > 0
    
    self.head = self.head.next
    self.tail = nil if self.length == 1
    self.length -= 1
end

# Returns the node that’s at the head of the stack without removing it or nil if the stack is empty.
# Since pop doesn’t return the removed element, peek is the way to go if you have to do something with that element.
# O(1)
def peek
    self.head
end

# Pops all elements from the stack. 
# O(n)
def clear
    while self.peek
        pop
    end
end

# This method walks the stack yielding one at a time until it reaches the last element.
# The complexity to yield the next item in the stack is O(1). 
# The complexity to yield the whole stack is O(n).
def each
    return nil unless block_given?    current = self.head
    while current
        yield current
        current = current.next
    end
end

# Print the contents of the stack by walking its items.
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