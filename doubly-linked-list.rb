'''
A Linked List is a linear collection of data elements, called nodes, each pointing to the next node by means of a pointer. 
It is a data structure consisting of a group of nodes which together represent a sequence.

Doubly-linked list: linked list in which each node has two pointers, p and n, such that p points to the previous node and n points to the next node; the last nodes n pointer points to null
'''

# Creates a new node to insert a value into the list. 
# If the list has no nodes, the new node becomes the head of the list; 
# otherwise, it’s appended at the tail of the list.
# O(1)
def insert data
    node = Node.new data
    unless head
        self.head = node
    else
        node.prev = self.tail
        self.tail.next = node
    end
    self.tail = node
    self.length += 1
end

# Removes the given node from the linked list and adjusts pointers to keep the elements together.
#  O(1)
def remove node
    return nil unless node    
    # If the node we have to remove is the head of the list, we need to cover two situations
    if node == head
        # Head is the only node in the list. We set head and tail to nil and we are done
        if head.next.nil?
            self.head = self.tail = nil
        else
            # Head is not the only node in the list. 
            # The node that’s next to head becomes the new head and the original head goes out of scope.
            self.head = self.head.next
        end
    else
        p = node.prev
        n = node.next
        p&.next = n
        n&.prev = p
    end
    self.length -= 1
end

# Join two lists together
# O(1)
def cat list
    return nil unless list    
    
    # Point the previous pointer of the head of the list we are appending to the tail of the current list
    list.head.prev = self.tail
    # Point the next pointer of the tail of the current list to the head of the list we are appending
    self.tail.next = list.head
    # Set the tail of the current list to the tail of the list we are appending
    self.tail = list.tail
    # Adjust current list length
    self.length += list.length
end

# Get the last element of the list that satisfies a given predicate
# O(n)
def find_last &predicate
    return nil unless block_given?    
    current = self.tail
    while current
        return current if predicate.call(current)
        current = current.prev
    end
end

# Traverses the list from tail to head yielding one item at a time until it reaches the end of the list
# The complexity to yield the previous element is O(1)
# The complexity to yield the whole list is O(n)
def reverse_each
    return nil unless block_given?    current = self.tail
    while current
        yield current
        current = current.prev
    end
end

# This method prints the contents of the current list backward.
def reverse_print
    if self.length == 0
        puts "empty"
    else
        self.reverse_each { |item| puts item.data }
    end
end
