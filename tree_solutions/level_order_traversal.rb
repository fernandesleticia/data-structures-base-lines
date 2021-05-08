# Given a pointer to the root of a binary tree, you need to print the level order traversal of this tree. In level-order traversal, nodes are visited level by level from left to right

tree = [1, [], [2, [], [5,[3,[7,[],[]],[4,[],[]]],[6,[9,[],[]],[]]]]]

def level_order(tree)
    print "#{tree[0]}"+" "
    print_nodes(tree)
end

def print_nodes(tree)
    return if tree[0].nil?
    print "#{tree[1][0]}"+" " unless tree[1][0].nil?
    print "#{tree[2][0]}"+" " unless tree[2][0].nil?

    print_nodes(tree[1]) 
    print_nodes(tree[2])
end

level_order(tree)