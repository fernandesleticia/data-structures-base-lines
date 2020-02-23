''' 
A Linked List is a linear collection of data elements, called nodes, each pointing to the next node by means of a pointer. 
It is a data structure consisting of a group of nodes which together represent a sequence.

Singly-linked list: linked list in which each node points to the next node and the last node points to null

Doubly-linked list: linked list in which each node has two pointers, p and n, such that p points to the previous node and n points to the next node; the last nodes n pointer points to null

Circular-linked list: linked list in which each node points to the next node and the last node points back to the first node 
'''

# Create an empty list setting the head and tail pointer to nil, and the list length to 0
# O(1)
def initialize
    self.head   = nil
    self.tail   = nil
    self.length = 0
end

# Creates a new node to insert a value into the list. 
# If the list has no nodes, the new node becomes the head of the list; 
# otherwise, it’s appended at the tail of the list.
# O(1)
def insert data
    node = Node.new data
    unless head
        self.head = node
    else
        self.tail.next = node
    end
    self.tail = node
    self.length += 1
end

# Removes the given node from the linked list and adjusts pointers to keep the elements together.
# O(n)
def remove node
    return nil unless node    
    # If the node we have to remove is the head of the list, we need to cover two situations
    if node == head
        # Head is the only node in the list. We set head and tail to nil and we are done.
        if head.next.nil?
            self.head = self.tail = nil
        else
            # There are more elements in the list. 
            # The node that’s next to head becomes the new head 
            # and the original head goes out of scope and gets ready to be “garbage collected”
            self.head = self.head.next
        end
    else
        # If the node we have to remove is not at the head of the list, 
        # we have to traverse the list from head to tail to find the node to be removed and the node that precedes it.
        tmp = self.head
        while tmp && tmp.next != node
            tmp = tmp.next
        end
        # The target node is effectively removed.
        tmp.next = node.next if tmp
    end
    self.length -= 1
end

# Join two lists together setting the next pointer of the tail node to point to the head 
# of the list we want to append and adjust the list length
# O(1)
def cat list
    return nil unless list    
    self.tail.next = list.head
    self.length   += list.length
end

# Removes all elements from the list
# O(n)
def clear
    while self.length > 0                          
        remove self.head
    end
end

# Get the first element of the list that satisfies a given predicate
# O(n)
def find_first &predicate
    return nil unless block_given?    
    current = self.head
    while current
        return current if predicate.call(current)
        current = current.next
    end
end

# Yield items from the list, one at a time, until the list is exhausted.
# The complexity to yield the next item is O(1). The complexity to yield the whole list is O(n).
def each
    return nil unless block_given?    current = self.head
    while current
        yield current
        current = current.next
    end
end

'''
Some Pros and Cons:
Linked Lists allocate memory when program is initiated and therefore can expand in real time without memory overload.
Insertion and deletion is easy and it’s easy to building linear data structures such as stacks and queues with linked lists.

On the other hand, its memory is intensive because each element holds a value and a pointer, its takes longer to access an element
and hard to reverse traverse

Time Complexity:
Access: O(n)
Search: O(n)
Insert: O(1)
Remove: O(1)
'''