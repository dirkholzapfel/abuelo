# Abuelo
[![Build Status](https://travis-ci.org/dirkholzapfel/abuelo.svg?branch=master)](https://travis-ci.org/dirkholzapfel/abuelo)
[![ProjectTalk](http://www.projecttalk.io/images/gh_badge-3e578a9f437f841de7446bab9a49d103.svg?vsn=d)] (http://www.projecttalk.io/boards/dirkholzapfel%2Fabuelo?utm_campaign=gh-badge&utm_medium=badge&utm_source=github)
[![Join the chat at https://gitter.im/dirkholzapfel/abuelo](https://badges.gitter.im/dirkholzapfel/abuelo.svg)](https://gitter.im/dirkholzapfel/abuelo?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

Abuelo is a graph theory library written in Ruby that allows you to build a representation of a graph.

A graph consists of nodes (= vertices, points) and edges (= lines, arcs). The graph may be undirected or directed. For the sake of simplicity Abuelo sticks with the same vocabulary (nodes, edges) for directed and undirected graphs in contrast to theoretical graph theory.

Abuelo supports Ruby >= 2.0.0

## Examples
### Undirected graph
```ruby
graph  = Abuelo::Graph.new

node_1 = Abuelo::Node.new('node 1')
node_2 = Abuelo::Node.new('node 2')
node_3 = Abuelo::Node.new('node 3')
edge_1 = Abuelo::Edge.new(node_1, node_2, 42)
edge_2 = Abuelo::Edge.new(node_2, node_3, 23)

graph.add_node(node_1)
     .add_node(node_2)
     .add_node(node_3)
     .add_edge(edge_1)
     .add_edge(edge_2)

graph.order                       # => 3
graph.size                        # => 2
graph.nodes                       # => [node_1, node_2, node_3]
graph.has_node?(node_1)           # => true
graph.has_node_with_name?('foo')  # => false
graph.find_node_by_name('node 1') # => node_1
graph.edges                       # => [[edge_1, edge_1.symmetric], [edge_2, edge_2.symmetric]]
graph.has_edge?(edge_1)           # => true
graph.has_edge?(edge_1.symmetric) # => true
graph.find_edge(node_1, node_2)   # => edge_1
graph.find_edge(node_2, node_1)   # => edge_1.symmetric
graph.edges_for_node(node_2)      # => [edge_1.symmetric, edge_2]

node_1.edges                      # => [edge_1]
node_1.neighbours                 # => [node_2]
```

### Directed graph
```ruby
graph  = Abuelo::Graph.new(directed: true)

node_1 = Abuelo::Node.new('node 1')
node_2 = Abuelo::Node.new('node 2')
node_3 = Abuelo::Node.new('node 3')
edge_1 = Abuelo::Edge.new(node_1, node_2, 42)
edge_2 = Abuelo::Edge.new(node_2, node_3, 23)

graph.add_node(node_1)
     .add_node(node_2)
     .add_node(node_3)
     .add_edge(edge_1)
     .add_edge(edge_2)

graph.order                       # => 3
graph.size                        # => 2
graph.nodes                       # => [node_1, node_2, node_3]
graph.has_node?(node_1)           # => true
graph.has_node_with_name?('foo')  # => false
graph.find_node_by_name('node 1') # => node_1
graph.edges                       # => [edge_1, edge_2]
graph.has_edge?(edge_1)           # => true
graph.has_edge?(edge_1.symmetric) # => false
graph.find_edge(node_1, node_2)   # => edge_1
graph.find_edge(node_2, node_1)   # => nil
graph.edges_for_node(node_2)      # => [edge_2]

node_1.edges                      # => [edge_1]
node_1.neighbours                 # => [node_2]
```

### Initialize a graph with an adjacency matrix
The above, object oriented way to build graphs is the recommended way to work with this library.
But you can also build a graph with an [adjacency matrix](https://en.wikipedia.org/wiki/Adjacency_matrix).
That is a nice shortcut used in some tests and may be a good alternative if you use Abuelo in the console to play around.

A zero indicates there is no edge between the nodes, an Integer indicates that there is an edge with the given weight between the nodes. The nodes are automatically named, starting with "node 1".
The above example can be built like this:

#### Undirected graphs
Be aware that you have to provide all symmetric edges in an adjacency matrix for an undirected graph - the lib does not add them automatically as it happens with the `.add_edge` method.

```ruby
adjacency_matrix = <<-matrix
   0 42  0
  42  0 23
   0 23  0
  matrix

# The above matrix corresponds to this internal representation
#
#          | node 1 | node 2 | node 3 |
#  ------------------------------------
#  node 1  | 0      | 42     | 0      |
#  node 2  | 42     | 0      | 23     |
#  node 3  | 0      | 23     | 0      |

graph = Abuelo::Graph.new(adjacency_matrix: adjacency_matrix)
node_1 = graph.find_node_by_name('node 1')
node_2 = graph.find_node_by_name('node 2')
graph.find_edge(node_1, node_2).weight # => 42
```
#### Directed graphs
```ruby
adjacency_matrix = <<-matrix
  0 42  0
  0  0 23
  0  0  0
  matrix

# The above matrix corresponds to this internal representation
#
#          | node 1 | node 2 | node 3 |
#  ------------------------------------
#  node 1  | 0      | 42     | 0      |
#  node 2  | 0      | 0      | 23     |
#  node 3  | 0      | 0      | 0      |

graph = Abuelo::Graph.new(adjacency_matrix: adjacency_matrix, directed: true)
```

## Documentation
[YARD](http://yardoc.org) documentation is available at [rubydoc](http://www.rubydoc.info/gems/abuelo).

## Future
* Implement graph algorithms
  * [Kruskal's algorithm](https://en.wikipedia.org/wiki/Kruskal%27s_algorithm)
  * [Prim's algorithm](https://en.wikipedia.org/wiki/Prim%27s_algorithm)
  * [Dijkstra's algorithm](https://en.wikipedia.org/wiki/Dijkstra%27s_algorithm)
* Implement visualization of graph

## Installation
Abuelo is a gem which you can install with:
```
gem install abuelo
```

In Rails 3+, add the following to your ```Gemfile```:
```
gem 'abuelo'
```

## Credits
Dirk Holzapfel

[cachezero.net](http://cachezero.net)

[Abuelo](http://www.ronabuelopanama.com)

### Contributors
[dirkholzapfel](https://github.com/dirkholzapfel),
[mbirman](https://github.com/mbirman),
[sergey-kintsel](https://github.com/sergey-kintsel)
