'''
A Heap is a specialized tree based structure data structure that satisfies the heap property: 
if A is a parent node of B, then the key (the value) of node A is ordered with respect to the key of 
node B with the same ordering applying across the entire heap. 

A heap can be classified further as either a "max heap" or a "min heap". 
In a max heap, the keys of parent nodes are always greater than or equal to those 
of the children and the highest key is in the root node. 
In a min heap, 
the keys of parent nodes are less than or equal to those of the children and the lowest key is in the root node
'''

def initialize(compare_symbol = :<, heap_storage = [])
  @heap = heap_storage
  @size = 0
  initialize_compare(compare_symbol)
end

attr_reader :size

def empty?
  size == 0
end

def peak
  @heap[0]
end

def add(element)
  @heap[@size] = element
  
  after_add_adjust
  
  self
end

def replace(element)
  @heap[0] = element
  rebalance_down(0)
end

def pop
  result = peak
  
  after_pop_adjust

  result
end

private

def initialize_compare(symbol)
  @compare = if symbol == :< or symbol.nil?
    lambda{|a, b| a < b}
  elsif symbol == :>
    lambda{|a, b| a > b}
  else
    raise ArgumentError.new("The comparison symbol must be provided correctly ( :> or :< )")
  end  
end

def after_pop_adjust
  if size > 1
    @size -= 1
    @heap[0] = @heap[@size]
    rebalance_down(0)
  else
    @size = 0 
  end 
end

def after_add_adjust
  @size += 1
  rebalance_up(size - 1)
end

def rebalance_down(i)
  left_i = left(i)
  right_i = right(i)

  if has_left(i) and compare(@heap[left_i], @heap[i]) and (not has_right(i) or compare(@heap[left_i], @heap[right_i]))
    @heap[i], @heap[left_i] = @heap[left_i], @heap[i]
    rebalance_down(left_i)
  elsif has_right(i) and compare(@heap[right_i], @heap[i])
    @heap[i], @heap[right_i] = @heap[right_i], @heap[i]
    rebalance_down(right_i)
  end 
end

def rebalance_up(i)
  parent_i = parent(i)

  if has_parent(i) and compare(@heap[i], @heap[parent_i])
    @heap[i], @heap[parent_i] = @heap[parent_i], @heap[i]
    rebalance_up(parent_i)
  end
end

def left(index)
  index * 2 + 1
end

def right(index)
  index * 2 + 2
end

def has_left(index)
  left(index) < size
end

def has_right(index)
  right(index) < size
end

def has_parent(i)
  i >= 1
end

def parent(i)
  ((i - 1) / 2).floor
end