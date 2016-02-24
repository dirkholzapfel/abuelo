module Abuelo
  #
  # Class Graph provides a representation of a graph.
  #
  # A graph consists of nodes (= vertices, points) and edges (= lines, arcs).
  # The graph may be undirected or directed. For the sake of simplicity Abuelo sticks
  # with the same vocabulary (nodes, edges) for directed and undirected graphs in
  # contrast to theoretical graph theory.
  #
  # @author Dirk Holzapfel <cache.zero@mailbox.org>
  #
  class Graph
    #
    # @param [Hash] opts the options to create a graph with
    # @option opts [Boolean] :directed defines if the graph is directed or undirected.
    #                        (defaults to false == undirected)
    # @option opts [String] :adjacency_matrix a representation of the graph in form
    #                       of an adjacency matrix
    #
    # @example Build a graph with the help of an adjacency matrix
    #  adjacency_matrix = <<-matrix
    #     0 42  0
    #    42  0 23
    #     0 23  0
    #    matrix
    #  graph = Abuelo::Graph.new(adjacency_matrix: adjacency_matrix)
    #
    def initialize(opts = {})
      @nodes = {} # @nodes = { node_name => node_object }
      @edges = {} # @edges = { node_object => { node_object => edge }}
      @directed = opts.fetch(:directed, false)
      init_by_adjacency_matrix(opts[:adjacency_matrix]) if opts[:adjacency_matrix]
    end

    #
    # @return [Boolean] true if the graph is directed, false if it is undirected
    #
    def directed?
      @directed
    end

    #
    # @return [Boolean] true if the graph is undirected, false if it is directed
    #
    def undirected?
      !directed?
    end

    #
    # @return [Integer] the order of the graph == the number of nodes
    #
    def order
      nodes.count
    end

    #
    # @return [Integer] the size of the graph == the number of edges
    #
    def size
      edges.count
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
      !find_node_by_name(name).nil?
    end

    #
    # Returns the node with the given name if it is contained in the graph.
    #
    # @param [String] name of the node
    #
    # @return [Abuelo::Node, nil] the node if found, otherwise nil
    #
    def find_node_by_name(name)
      @nodes[name]
    end

    #
    # @return [Array<Abuelo::Edge>, Array<Array(Abuelo::Edge, Abuelo::Edge)>]
    #   list of edges of the graph if directed,
    #   list of list of symmetric pairs of edges of the graph if undirected
    #
    # @example directed graph
    #  "graph.edges" #=> [edge_from_node_1_to_node_2]
    #
    # @example undirected graph
    #  "graph.edges" #=> [[edge_from_node_1_to_node_2, edge_from_node_2_to_node_1]]
    #
    def edges
      edges = @edges.keys.flat_map { |key| @edges[key].values }

      if directed?
        edges
      else
        edges.each_slice(2).to_a
      end
    end

    #
    # Adds an edge to the graph.
    # Auto-adds the symmetric counterpart if graph is undirected.
    #
    # @param [Abuelo::Edge] edge to add
    #
    # @return [Abuelo::Graph] the graph
    #
    # @raise [Abuelo::Exceptions::EdgeAlreadyExistsError] if the edge is
    #   already contained in the graph
    #
    def add_edge(edge, opts = {})
      raise Abuelo::Exceptions::EdgeAlreadyExistsError if has_edge?(edge)

      @edges[edge.node_1] ||= {}
      @edges[edge.node_1][edge.node_2] = edge

      if undirected? && !opts[:symmetric]
        add_edge(edge.symmetric, symmetric: true)
      end

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
      !find_edge(edge.node_1, edge.node_2).nil?
    end

    #
    # Returns the edge if there is one between the two given nodes.
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
      Hash(@edges[node]).values
    end


    private

    def init_by_adjacency_matrix(adjacency_matrix)
      nodes = {}
      1.upto(adjacency_matrix.lines.count) do |i|
        node = Abuelo::Node.new("node #{i}")
        nodes[i] = node
        add_node(node)
      end

      adjacency_matrix.split(/\r?\n/).each_with_index do |row, row_index|
        row.split(' ').map(&:to_i).each_with_index do |weight, column_index|
          if weight != 0
            edge = Abuelo::Edge.new(nodes[row_index+1], nodes[column_index+1], weight)
            add_edge(edge, symmetric: true)
          end
        end
      end
    end
  end
end
