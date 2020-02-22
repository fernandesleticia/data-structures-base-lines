'''
Hashing is used to map data of an arbitrary size to data of a fixed size. 
The values returned by a hash function are called hash values, hash codes, or simply hashes. If two keys map to the same value, a collision occurs

Hash Map: a hash map is a structure that can map keys to values. A hash map uses a hash function to compute an index into an array of buckets or slots, 
from which the desired value can be found.

Separate Chaining: in separate chaining, each bucket is independent, and contains a list of entries for each index. The time for hash map operations is the time to find the bucket (constant time),
plus the time to iterate through the list.

Open Addressing: in open addressing, when a new entry is inserted, the buckets are examined, 
starting with the hashed-to-slot and proceeding in some sequence, until an unoccupied slot is found. 
The name open addressing refers to the fact that the location of an item is not always determined by its hash value
'''

# This method is the hash table constructor and the one in charge of proper initialization.
# O(m)
def initialize
    # Set the initial number of slots to 5
    @slots    = 5 
    # Initialize all of the slots with nil values.
    fill_table @slots 
    # Set up auxiliary functions, h1 and h2
    @h1       = -> (k) { k % @slots }
    @h2       = -> (k) { 1 + (k % (@slots - 1)) }
    # Set size (occupied positions) to 0.
    self.size = 0
    # Set the number of rebuilds to zero. (If the table grows past certain threshold we have to rebuild it.)
    @rebuilds = 0
end

# This method inserts a new entry into the table or updates an existing one.
# O(1)
def upsert key, value
    # Check if there is already an entry for the given key. If there is one, we have to update the value and return.
    if (slot = find_slot(key))
        slot.value = value
        return
    end    
    
    #If the entry does not exist, we have to check if there is enough room to add it to the table. 
    # If the number of slots is too small, 
    # we have to trigger a rebuild operation to ensure that the new entry fits into the internal storage
    rebuild if self.size > (@slots / 2)

    # Once we are sure that there is enough space, we have to hash the key and map it to a position into the internal storage. 
    # In our case, we do that by double hashing the key’s hash code until we find an empty slot or run out of positions
    0.upto(@slots - 1) do |i|
        index = double_hash key.hash, i
        slot  = @table[index]
        if slot.nil? || slot.vacated 
            # Once we successfully mapped a key to a position in the internal array, we increase the table size and return
            @table[index] = Slot.new key, value
            self.size += 1
            return
        end
    end
    raise "Weak hash function."
end

# Returns an entry’s value or nil if the entry doesn’t exist
# O(1)
def get key
    0.upto(@slots - 1) do |i|
        # applies double hashing to map a key to an index into the internal array
        index = double_hash key.hash, i
        slot  = @table[index]
        return nil  if slot.nil? || slot.vacated
        return slot.value if slot.key == key
    end
    nil
end

# This method searches a slot that matches the given key and marks it as free if it finds it
# O(1)
def delete key
    find_slot(key)&.free
end

# almost identical to get but instead of returning the entry’s value returns the entry itself.
# O(1)
def find_slot key
    0.upto(@slots - 1) do |i|
        index = double_hash key.hash, i
        slot  = @table[index]
        return nil  if slot.nil?
        return slot if slot.key == key
    end
    nil
end

# Prints the contents of the hash table.
# O(m)
def print
    @table.each do |e|
        if e
            puts "#{e.key}: #{e.value}"
        else
            puts "empty"
        end
    end
end


PRIMES = [13, 31, 61, 127, 251, 509]
MAX_REBUILDS = 6 # Utmost equal to PRIMES.count

# Rebuild the internal storage when the table needs to make room for new entries
# O(m)
def rebuild
    raise "Too many entries." if @rebuilds >= MAX_REBUILDS    old   = @table
    @slots = PRIMES[@rebuilds]
    self.size = 0
    fill_table @slots
    old.each do |e|
        upsert e.key, e.value if e
    end
    @rebuilds += 1
end