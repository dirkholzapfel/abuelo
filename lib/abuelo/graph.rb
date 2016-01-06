module Abuelo
  #
  # Class Graph provides a representation of a directed graph.
  # A graph consists of nodes (= vertices, points) and edges (= lines, arcs).
  #
  # @author Dirk Holzapfel <dirk@bitcrowd.net>
  #
  class Graph

    def initialize
      @nodes = {} # @nodes = { node_name => node_object }
      @edges = {} # @edges = { node_object => { node_object => edge }}
    end


    #
    # @return [Array<Abuelo::Node>] list of nodes of the graph
    #
    def nodes
      @nodes.values
    end

    #
    # Adds a node to the graph.
    #
    # @param [Abuelo::Node] node to add
    #
    # @return [Abuelo::Graph] the graph
    #
    # @raise [Abuelo::Exceptions::NodeAlreadyExistsError] if the node is
    #   already contained in the graph
    # 
    def add_node(node)
      raise Abuelo::Exceptions::NodeAlreadyExistsError if has_node?(node)

      @nodes[node.name] = node
      node.graph = self
      self
    end

    #
    # Checks if the given node is contained in the graph.
    #
    # @param [Abuelo::Node] node
    #
    # @return [Boolean]
    # 
    def has_node?(node)
      has_node_with_name?(node.name)
    end

    #
    # Checks if a node with the given name is contained in the graph.
    #
    # @param [String] name of the node
    #
    # @return [Boolean]
    # 
    def has_node_with_name?(name)
      @nodes[name] ? true : false
    end


    #
    # @return [Array<Abuelo::Edge>] list of edges of the graph
    # 
    def edges
      edges = @edges.keys.map { |key| @edges[key].values }
      edges.flatten
    end

    #
    # Adds an edge to the graph.
    #
    # @param [Abuelo::Edge] edge to add
    #
    # @return [Abuelo::Graph] the graph
    #
    # @raise [Abuelo::Exceptions::EdgeAlreadyExistsError] if the edge is
    #   already contained in the graph
    # 
    def add_edge(edge)
      raise Abuelo::Exceptions::EdgeAlreadyExistsError if has_edge?(edge)

      @edges[edge.node_1] ||= {}
      @edges[edge.node_1][edge.node_2] = edge
      self
    end

    #
    # Checks if the given edge is contained in the graph.
    #
    # @param [Abuelo::Edge] edge
    #
    # @return [Boolean]
    # 
    def has_edge?(edge)
      find_edge(edge.node_1, edge.node_2) ? true : false
    end

    #
    # Checks if there is an edge between the two given nodes.
    #
    # @param [Abuelo::Node] node_1
    # @param [Abuelo::Node] node_2
    #
    # @return [Abuelo::Edge, nil] the edge if found, otherwise nil
    # 
    def find_edge(node_1, node_2)
      @edges[node_1][node_2] if @edges[node_1]
    end

    #
    # Returns all edges that start from the given node.
    #
    # @param [Abuelo::Node] node <description>
    #
    # @return [Array<Abuelo::Edge>] list of edges that start from the given node
    # 
    def edges_for_node(node)
      edges = []
      edges += @edges[node].values.to_a if @edges[node]
      edges
    end

  end
end
