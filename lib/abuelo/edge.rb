module Abuelo
  #
  # Class Edge provides a representation of an edge.
  # An edge connects two nodes(start-node and end-node) and has a weight.
  #
  # @author Dirk Holzapfel <cache.zero@mailbox.org>
  #
  class Edge
    # @return [Abuelo::Node] start-node
    attr_reader :node_1

    # @return [Abuelo::Node] end-node
    attr_reader :node_2

    # @return [Numeric] weight
    attr_reader :weight

    #
    # Initialiazises the edge with its two nodes and its weight.
    #
    # @param [Abuelo::Node] node_1 start-node
    # @param [Abuelo::Node] node_2 end-node
    # @param [Numeric] weight of the edge
    #
    def initialize(node_1, node_2, weight = 1)
      @node_1 = node_1
      @node_2 = node_2
      @weight = weight
    end

    #
    # @return [Abuelo::Edge] a new edge with same weight but reversed start- and end-node.
    #
    def symmetric
      Abuelo::Edge.new(node_2, node_1, weight)
    end

    #
    # Comparison based on weight.
    #
    # @param [Abuelo::Edge] other
    #
    # @return [-1, 0, +1]
    #
    def <=>(other)
      weight <=> other.weight
    end

    #
    # Equality check.
    #
    # @param [Abuelo::Edge] other
    #
    # @return [Boolean] true if start-, end-node and weight of both edges are equal
    #
    def ==(other)
      node_1 == other.node_1 &&
        node_2 == other.node_2 &&
        weight == other.weight
    end

    #
    # @return [String] human readable representation of edge
    #
    def to_s
      "#{node_1} -> #{node_2} with weight #{weight}"
    end
  end
end
