module Abuelo
  module Algorithms
    #
    # Class Dijkstra implements Dijkstra's algorithm for finding shortest paths between
    # nodes in a graph.
    #
    # See https://en.wikipedia.org/wiki/Dijkstra%27s_algorithm
    #
    # Possible improvement: use a priority queue to improve runtime.
    #
    # @author Dirk Holzapfel <cache.zero@mailbox.org>
    #
    class Dijkstra
      #
      # @param [Abuelo::Graph] graph
      # @param [Abuelo::Node] start_node
      #
      # @raise [Abuelo::Exceptions::NoNodeError] if the start_node is
      #   not a Abuelo::Node
      #
      def initialize(graph, start_node)
        if !start_node.is_a?(Abuelo::Node)
          raise Abuelo::Exceptions::NoNodeError.new('start_node is not a Abuelo::Node')
        end

        @graph          = graph
        @start_node     = start_node
        @distances      = {}
        @previous_nodes = {}
        init
        process
      end

      #
      # Calculates the shortest distance from the start_node to the given node.
      #
      # @param [Abuelo::Node] node
      #
      # @return [Numeric, nil] the distance to the node or nil if node is unreachable
      #
      def shortest_distance_to(node)
        @distances[node]
      end

      #
      # Calculates the shortest path from the start_node to the given node.
      #
      # @param [Abuelo::Node] node
      #
      # @return [Array<Abuelo::Node>, nil] list of nodes from start_node to the given node
      #  that are a possible solution for the shortest path. Nil if node is unreachable.
      #
      def shortest_path_to(node)
        return nil if @previous_nodes[node].nil?

        nodes = [node]
        while previous_node = @previous_nodes[nodes[0]] do
          nodes.unshift(previous_node)
        end

        nodes
      end


      private

      def init
        @graph.nodes.each do |node|
          @distances[node] = Float::INFINITY
          @previous_nodes[node] = nil
        end

        @distances[@start_node] = 0
      end

      def process
        unvisited_nodes = @graph.nodes

        until unvisited_nodes.empty? do
          node = unvisited_nodes.min_by { |node| @distances[node] }
          unvisited_nodes.delete(node)

          unvisited_neighbours = unvisited_nodes & node.neighbours
          unvisited_neighbours.each do |neighbour|
            new_edge_weight = @graph.find_edge(node, neighbour).weight
            alternative_distance = @distances[node] + new_edge_weight
            if alternative_distance < @distances[neighbour]
              @distances[neighbour] = alternative_distance
              @previous_nodes[neighbour] = node
            end
          end
        end
      end
    end
  end
end
