'''
A Graph is an ordered pair of G = (V, E) comprising a set V of vertices or nodes together with a set E of edges or arcs, which are 2-element subsets of V (i.e. an edge is associated with two vertices, and that association takes the form of the unordered pair comprising those two vertices)

Undirected Graph: a graph in which the adjacency relation is symmetric. So if there exists an edge from node u to node v (u -> v), then it is also the case that there exists an edge from node v to node u (v -> u)

Directed Graph: a graph in which the adjacency relation is not symmetric. So if there exists an edge from node u to node v (u -> v), this does not imply that there exists an edge from node v to node u (v -> u)
'''

# Initialize the list of vertices.
# O(1)
def initialize
    @vertices = LinkedList.new
end

# Finds a vertex based on its key
# O(n)
def find_vertex key
    @vertices.find_first { |v| v.data.key == key }
end

# Adds a vertex to the graph
# O(n)
def insert_vertex key
    return if find_vertex keyvertex = Vertex.new key
    @vertices.insert vertex
end

# Connects two nodes by adding an edge to the graph
# O(n)
def insert_edge key1, key2
    # The graph must contains vertices.
    v1 = find_vertex key1
    return unless v1v2 = find_vertex key2
    return unless v2v1.data.edges.insert v2.data.key
end

# Removes a vertex from the graph
# O(n + e)
def remove_vertex key
    found  = false
    target = nil
    # look for the vertex that matches the key that we want to remove
    prev   = nil@vertices.each do |v|
        return if v.data.edges.contains? key
        if v.data.key == key
            found  = true
            target = v.data
        end
        prev = v unless found
    end
    return unless found
    # We have to make sure that it doesn’t contain references to other vertices. 
    # If the node contains references, we can’t remove it
    return unless target.edges.length == 0
    @vertices.remove_next prev
end

# This method removes the edge that connects the specified nodes from the graph.
# O(n)
def remove_edge key1, key2
    # Search for the vertex that matches the first key
    vertex = find_vertex(key1)&.data
    # If we found it, we remove the second key form its edges collection
    return unless vertexvertex.edges.remove key2
end

# This method tells if two vertices (nodes) are adjacent or not
# O(n)
def adjacent? key1, key2
    # Search for the vertex that matches the first key
    vertex = find_vertex(key1)&.data
    # We check if its edges collection contains the second key
    return true if vertex&.edges.contains? key2
    return false
end