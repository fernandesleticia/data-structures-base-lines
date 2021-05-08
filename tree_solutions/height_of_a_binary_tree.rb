#number of edges between the tree's root and its furthest leaf

tree = [5, [2, [5], [4]], [3]]
def height(tree)
    return 0 unless tree.length > 1
    get_height(tree) - 1 
end

def get_height(tree)
    return 0 if tree.nil?
    
    [get_height(tree[1]), get_height(tree[2])].max + 1
end

p height(tree)
