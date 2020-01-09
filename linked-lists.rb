''' Linked Lists is a data structure where each element is 
a node containing two pieces of information (for a single linked list)→ 
1) its data 
2) a reference to the next piece of data in the list. 
For a doubly linked list it holds 3 pieces of information → 
1) a reference to the previous piece of data in the list 
2) its data 
3) a reference to the next piece of data in the list. 
The entry point to the linked list is the head, 
and the only way to get through the list is by iterating 
until you find the item you want'''

class Node    
    attr_accessor :value, :next

    def initialize(value, next_node)
        @value = value
        @next = next_node
    end
end

class LinkedList
    def initialize(value)
        @head = Node.new(value, nil)
    end

    def add_to_list(value)
        current_node = @head
        while current_node.next != nil
            current_node = current_node.next
        end
        current_node.next = Node.new(value, nil)
    end

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
end
