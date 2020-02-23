''' 
A Linked List is a linear collection of data elements, called nodes, each pointing to the next node by means of a pointer. 
It is a data structure consisting of a group of nodes which together represent a sequence.

Circular-linked list: linked list in which each node points to the next node and the last node points back to the first node 
'''

# Create an empty list setting the head to nil and the list length to 0
# O(1)
def initialize
    self.head   = nil
    self.length = 0
end

# Creates a new node to insert a value into the list. 
# If the list has no nodes, the new node becomes the head of the list. 
# Otherwise, it’s appended at the end of the list
# O(n)
def insert data
    return insert_next(nil, data)       if (self.length == 0)
    return insert_next(self.head, data) if (self.length == 1)
    
    # Finds the last node.
    self.current = head
    i = 0;
    while ((i += 1) < self.length)
        move_next
    end    # Inserts the new node right after the last node.
    return insert_next(self.current, data)
end

# Insert next allow you to insert elements in constant time 
# as long as you hold a pointer to the node that will precede the new node.
# O(1)
def insert_next prev_node, data
    new_node = Node.new data
    if self.length == 0
        self.head = new_node.next = new_node
    else
        new_node.next = prev_node.next
        prev_node.next = new_node
    end
    self.length += 1
end

# Removes the given node from the linked list and adjusts pointers to keep the elements together.
# O(n)
def remove node
    return nil unless node
    return nil unless self.length > 0
    
    # head?
    return remove_next node if (self.length == 1)
    
    # Find the precedent node to the node we 
    # want to remove.
    prev = nil
    self.current = self.head
    while ((prev = self.move_next) != node)
    end
    
    remove_next prev
end

# This method allows us to remove elements in constant time 
# as long as we have a pointer to the node that precedes the item to be removed
# O(1)
def remove_next prev_node
    return nil unless self.length > 0    
    
    unless prev_node
        self.head = self.head.next
    else
        # “Capture” the next to the previous node
        if prev_node.next == prev_node
            self.head = nil
        else
            old = prev_node.next
            # Point the next pointer of the captured node to that follows the next pointer of the previous node
            prev_node.next = prev_node.next&.next
            # Check if the node we captured before is the head of the list. 
            # If so, we have to point the head of the list to the node that is next to the captured node
            if (old == self.head)
                self.head = old.next
            end
        end
    end    self.length -= 1
end

# This method removes all elements from the list. Since we have to walk the whole list
# O(n)
def clear
    while self.length > 0
        remove self.head
    end
end

# Points the current node to the node that follows it in the list
# O(1)
def move_next
    self.current = self.current&.next
end

# It traverses all elements in the list without wrapping around
# O(n)
def full_scan
    return nil unless block_given?    self.current = self.head
    loop do
        yield self.current
        break if (move_next == self.head)
    end
end