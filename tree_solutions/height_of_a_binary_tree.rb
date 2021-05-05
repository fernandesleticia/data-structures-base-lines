#number of edges between the tree's root and its furthest leaf

tree = [5, [2,3]]

def height(tree)
    return 0 unless tree.length > 1


end

def get_height(tree, count_left=0, count_right=0)
    count_left+=1
    count_right+=1
    
    get_height(tree[1][0])
    get_height(tree[1][1])
end

p height(tree)
