module Abuelo
  #
  # Class Edge provides a representation of an edge.
  # An edge connects two nodes(start-node and end-node) and has a weight.
  #
  # @author Dirk Holzapfel <dirk@bitcrowd.net>
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
    def initialize(node_1, node_2, weight = 0)
      @node_1 = node_1
      @node_2 = node_2
      @weight = weight
    end

    #
    # @return [Abuelo::Edge] a new edge with same weight but reversed start- and end-node.
    # 
    def opposite
      Abuelo::Edge.new(node_2, node_1, weight)
    end

    #
    # Comparison based on weight.
    #
    # @param [Abuelo::Edge] other_edge
    #
    # @return [-1, 0, +1 or ni]
    # 
    def <=>(other_edge)
      self.weight <=> other_edge.weight
    end

    #
    # Equality check.
    #
    # @param [Abuelo::Edge] other_edge
    #
    # @return [Boolean] true if start-, end-node and weight of both edges are equal
    # 
    def ==(other_edge)
      self.node_1 == other_edge.node_1 &&
      self.node_2 == other_edge.node_2 &&
      self.weight == other_edge.weight
    end

    #
    # @return [String] human readable representation of edge
    # 
    def to_s
      "#{node_1.to_s} -> #{node_2.to_s} with weight #{weight}"
    end

  end
end
