# Abuelo
Abuelo is a graph theory library that allows you to build a representation of a directed graph with its nodes and edges.

## Examples
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

graph.nodes                      # => [node_1, node_2, node_3]
graph.has_node?(node_1)          # => true
graph.has_node_with_name?('foo') # => false
graph.edges                      # => [edge_1, edge_2]
graph.has_edge?(edge_1)          # => true
graph.find_edge(node_1, node_2)  # => edge_1
graph.edges_for_node(node_2)     # => [edge_2]
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

[bitcrowd.net](http://bitcrowd.net)

[Abuelo](http://www.ronabuelopanama.com)
