module Abuelo
  #
  # Class Node provides a representation of a node.
  # A node has a name. Any object may be attached on initialization.
  #
  # @author Dirk Holzapfel <dirk@bitcrowd.net>
  #
  class Node
    # @return [String] name
    attr_reader :name

    # @return [Object] attached object
    attr_reader :object

    # @return [Abuelo::Graph] associated graph
    attr_accessor :graph

    #
    # Initialiazises the node with its name.
    #
    # @param [String] name of the node
    # @param [Object] object to attach to the node.
    #  This is useful on some algorithm implementations.
    #
    def initialize(name, object = nil)
      @name   = name
      @object = object
    end

    #
    # @return [Array<Abuelo::Edge>] list of edges starting from the node
    #
    def edges
      graph.edges_for_node(self) if graph
    end

    #
    # @return [String] human readable representation of node
    #
    def to_s
      @name
    end

    #
    # Equality check.
    #
    # @param [Abuelo::Node] other_node
    #
    # @return [Boolean] true if name is equal
    #
    def ==(other_node)
      name == other_node.name
    end
  end
end
