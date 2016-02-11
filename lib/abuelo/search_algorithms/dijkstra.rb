module Abuelo
  module SearchAlgorithms
    class Dijkstra
      attr_accessor :graph

      def initialize(graph)
        @graph = graph
        @visited_nodes = []
      end

      def find_path(node_1, node_2)
        set_infinities
        @path_lengths[node_1] = 0 # path to itself has to be 0
        nodes = [node_1]
        @visited_nodes = []
        while nodes.any?
          node = nodes.shift
          node.edges.each do |edge|
            next if visited?(edge.node_2) || !valid_edge_weight?(edge)

            @path_lengths[edge.node_2] = edge.weight + @path_lengths[node] if @path_lengths[edge.node_2] > edge.weight + @path_lengths[node]

            nodes << edge.node_2
          end
          @visited_nodes << node
        end

        @visited_nodes = []
        @path_lengths[node_2]
      end

      def set_infinities
        @path_lengths = {}
        graph.nodes.each do |node|
          @path_lengths[node] = Float::INFINITY
        end
      end

      def visited?(node)
        @visited_nodes.include?(node)
      end

      def valid_edge_weight?(edge)
        edge.weight && edge.weight > 0
      end
    end
  end
end
