'''
A set is an unordered sequence of unique elements (called members) grouped because they related to each other in some way. 
Sets can contain other sets, can be empty, but they can’t contain duplicate members.
'''

# Initialize the set’s internal storage
# O(1)
def initialize
    @list = LinkedList.new
end

# Inserts a new member into the set. Since sets can’t contain duplicates, 
# the first this method does is to check if the member is not already there. 
# If it’s not, it inserts the new member otherwise it does nothing.
# O(n)
def insert member
    return if contains? member
    @list.insert member
end

# This method removes a member from the current set, 
# or it does nothing if the element doesn’t exist.
# O(n)
def remove member
    node = @list.find { |nd| nd.value == member }
    @list.remove node if node
end

# This method returns a set that contains all members of the current and the other set.
# O(mn)
def union other
    res = Set.new
    @list.each { |nd| res.insert(nd.value) }
    other.each { |nd| res.insert(nd.value) }
    res
end

# Returns the intersection of the current set with the other set.
# O(mn)
def intersect other
    res = Set.new
    @list.each do |nd| 
        res.insert(nd.value) if other.contains?(nd.value)
    end
    res
end

# Returns a set that contains all of the elements that are present in the current set but not in the other.
# O(mn)
def diff other
    res = Set.new
    @list.each do |nd| 
        res.insert(nd.value) unless other.contains?(nd.value)
    end
    res
end

# This method returns true if the set includes the given member. 
# To find a member this method walks the internal list and check each node data until 
# it finds the member or the list runs out of nodes.
# O(n)
def contains? member
    @list.find_first { |nd| nd.data == member }
end

# This method returns true if the current set is a subset of the other set and false otherwise
# O(mn)
def subset? other
    return false if self.count > other.count@list.each do |nd|
        return false unless other.contains(nd.value)
    end
    true
end

# Returns true if the current set is equal to the other set and false otherwise.
# O(mn)
def equal? other
    return false if self.count != other.count
    subset? other
end

# Returns the number of elements in the current set
# O(1)
def count
    @list.length
end

# This method walks the members in the current set yielding them one a time.
# O(n)
def each
    return nil unless block_given?current = @list.head
    while current
        yield current&.data
        current = current.next
    end
end

# Prints the contents of the current set
# O(n)
def print
    @list.print
end