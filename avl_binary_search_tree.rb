'''
A Binary Tree is a tree data structure in which each node has at most two children, which are referred to as the left child and right child

Full Tree: a tree in which every node has either 0 or 2 children
Perfect Binary Tree: a binary tree in which all interior nodes have two children and all leave have the same depth
Complete Tree: a binary tree in which every level except possibly the last is full and all nodes in the last level are as far left as possible

Binary search trees, or BTSs for short, are data structures designed to perform fast lookups on large datasets. The subject of this post is AVL trees, a special kind of self-balancing BST named after its creators Adelson-Velskii and Landis where the height difference between the left and right subtrees (the balance factor) is always in the range (-1..1) giving us O(log2 n) lookups.

On AVL trees nodes arranged in descendant order, and they can’t contain duplicate keys. These properties are important because most of its methods rely on them.
'''

# Adds a new node to the tree and reset its root
# O(log2 n)
def insert key, data = nil
    @root = insert_and_balance(@root, key, data)
end

# This method looks recursively to find the right spot for the given key. 
# Once the spot is found and the new node is inserted, 
# it calls the balance method to ensure that the tree remains balanced
# O(log2 n)
def insert_and_balance node, key, data = nil
    return Node.new key, data unless node    
    
    if (key < node.key) 
        node.left = insert_and_balance(node.left, key, data)
    elsif(key > node.key) 
        node.right = insert_and_balance(node.right, key, data)
    else 
        node.data    = data
        node.deleted = false
    end    
    
    balance(node)
end

# This method balances the subtree rooted at the specified node
# O(log2 n)
def balance node
    set_height node
    if (height(node.left) - height(node.right) == 2) 
        if (height(node.left.right) > height(node.left.left)) 
            #return rotate_left_right(node.left) <- Wrong.
            return rotate_left_right(node)
        end
        return rotate_right(node)
    elsif (height(node.right) - height(node.left) == 2) 
        if (height(node.right.left) > height(node.right.right)) 
            #return rotate_right_left(node.right) <- Also wrong.
            return rotate_right_left(node)
        end
        return rotate_left(node)
    end
    return node
end

# This method finds the node to be removed and marks it as deleted
# O(log2 n)
def remove key
    search(key)&.deleted = true
end

# This method starts a top-down recursive descendant search from the current tree’s root node
# O(log2 n)
def search key
    node = search_rec @root, key
    return node unless node&.deleted
end

# Searches for a key in the subtree that starts at the provided node. 
# This method starts the search at a given node and descends (recursively) moving left or 
# right based on the key’s values until it finds the key or gets to the end of the subtree
# O(log2 n)
def search_rec node, key
    return nil unless node
    return search_rec(node.left, key)  if (key < node.key)
    return search_rec(node.right, key) if (key > node.key)
    return node        
end

# This method calculates and sets the height for the specified node based on 
# the heights of their left and right subtrees
# O(1)
def set_height node
    lh  = height node&.left
    rh  = height node&.right
    max = lh > rh ? lh : rh    node.height = 1 + max
end

# This method performs a right rotation
# O(1)
def rotate_right p
    q       = p.left
    p.left  = q.right
    q.right = p    set_height p
    set_height q    return q
end

# This method performs a left rotation
# O(1)
def rotate_left p
    q       = p.right
    p.right = q.left
    q.left  = p    set_height p
    set_height q    return q
end

# This method points the left subtree of the given node to the result of rotating that subtree 
# to the left and then rotates the specified node to the right. 
# The last rotation it’s also its return value
# O(1)
def rotate_left_right node
    node.left = rotate_left(node.left)
    return rotate_right(node)
end

# This method points the right subtree of the given node to the result of rotating that subtree 
# to the right and then rotates the specified node to the left. 
# The last rotation it’s also its return value
# O(1)
def rotate_right_left node
    node.right = rotate_right(node.right)
    return rotate_left(node)
end

# This method prints the contents of a tree
# O(n)
def print
    print_rec @root, 0
end

def print_rec node, indent
    unless node
        puts "x".rjust(indent * 4, " ")
        return
    end    

    puts_key node, indent
    print_rec node.left, indent + 1
    print_rec node.right, indent + 1
end

def puts_key node, indent
    txt = node.key.to_s
    if node.deleted
        txt += " (D)" 
        puts txt.rjust(indent * 8, " ")
    else
        puts txt.rjust(indent * 4, " ")
    end
end

