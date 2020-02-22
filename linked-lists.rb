''' Linked Lists is a data structure where each element is 
a node containing two pieces of information (for a single linked list):
1) its data 
2) a reference to the next piece of data in the list

For a doubly linked list it holds 3 pieces of information:
1) a reference to the previous piece of data in the list 
2) its data 
3) a reference to the next piece of data in the list. 

The entry point to the linked list is the head, 
and the only way to get through the list is by iterating 
until you find the item you want '''


# This class creates a node object with a value and a next which will point to the next node 
# (originally it starts as nil, and when a new node is created nill will be replaced with that value)
class Node    
    attr_accessor :value, :next

    def initialize(value, next_node)
        @value = value
        @next = next_node
    end
end

class LinkedList

    # creates a list by creating a head node with a value and a next pointer being nil
    def initialize(value)
        @head = Node.new(value, nil)
    end

    # starts by finding the last node, by looping through the nodes until the next one is nil, 
    # then it makes nil be replaced by a new node object
    def add_to_list(value)
        current_node = @head
        while current_node.next != nil
            current_node = current_node.next
        end
        current_node.next = Node.new(value, nil)
    end

    # starts by saying if the value to delete is the head, just make @head equal to the next node, 
    # otherwise loop through the nodes until the next node is the value to delete. 
    # Once that one is found replace the next node with the next next node
    def delete(value)
        current_node.next = @head
        if current_node.value = value
            @head = current_node.next
        else
            while (current_node.next != nil) && (current_node.next.val != val)
                current_node = current_node.next
            end
            unless current_node.next == nil
                current_node.next = current_node.next.next
            end
    end

    # pushes each node into an array so that you can show the list in array form
    def return_list
        elements = []
        current_node = @head
        while current_node.next != nil
            elements << current_node
            current_node = current_node.next
        end
        elements << current
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