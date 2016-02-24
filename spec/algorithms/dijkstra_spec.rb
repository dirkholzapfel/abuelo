require 'spec_helper'

RSpec.describe Abuelo::Algorithms::Dijkstra do
  describe '#initialize(graph, start_node)' do
    it 'raises an error if the start_node is not a Abuelo::Node' do
      expect do
        described_class.new(Abuelo::Graph.new, 'foo')
      end.to raise_error(Abuelo::Exceptions::NoNodeError)
    end
  end

  context 'undirected graph' do
    # This is the example from https://en.wikipedia.org/wiki/Dijkstra%27s_algorithm
    adjacency_matrix = <<-matrix
      0  7  9  0  0 14
      7  0  10 15 0 0
      9  10 0  11 0 2
      0  15 11 0  6 0
      0  0  0  6  0 9
      14 0  2  0  9 0
    matrix
    
    let(:undirected_graph) do
      Abuelo::Graph.new(adjacency_matrix: adjacency_matrix)
    end
    let(:start_node) { undirected_graph.find_node_by_name('node 1') }
    let(:dijkstra)   { described_class.new(undirected_graph, start_node) }

    describe '#shortest_distance_to(node)' do
      it 'is 0 for the start node' do
        expect(dijkstra.shortest_distance_to(start_node)).to eq 0
      end

      it 'is Float::INFINITY for an unreachable node' do
        unreachable_node = Abuelo::Node.new('unreachable node')
        undirected_graph.add_node(unreachable_node)
        expect(dijkstra.shortest_distance_to(unreachable_node)).to eq Float::INFINITY
      end

      it 'is nil when the node is not part of the graph' do
        unknown_node = Abuelo::Node.new('foo')
        expect(dijkstra.shortest_distance_to(unknown_node)).to be nil
      end

      context 'wikipedia example' do
        it 'is 0 for node 1' do
          node = undirected_graph.find_node_by_name('node 1')
          expect(dijkstra.shortest_distance_to(node)).to eq 0
        end

        it 'is 7 for node 2' do
          node = undirected_graph.find_node_by_name('node 2')
          expect(dijkstra.shortest_distance_to(node)).to eq 7
        end

        it 'is 9 for node 3' do
          node = undirected_graph.find_node_by_name('node 3')
          expect(dijkstra.shortest_distance_to(node)).to eq 9
        end

        it 'is 20 for node 4' do
          node = undirected_graph.find_node_by_name('node 4')
          expect(dijkstra.shortest_distance_to(node)).to eq 20
        end

        it 'is 20 for node 5' do
          node = undirected_graph.find_node_by_name('node 5')
          expect(dijkstra.shortest_distance_to(node)).to eq 20
        end

        it 'is 11 for node 6' do
          node = undirected_graph.find_node_by_name('node 6')
          expect(dijkstra.shortest_distance_to(node)).to eq 11
        end
      end
    end

    describe '#shortest_path_to(node)' do
      it 'is nil for the start node' do
        expect(dijkstra.shortest_path_to(start_node)).to be nil
      end

      it 'is nil for an unreachable node' do
        unreachable_node = Abuelo::Node.new('unreachable node')
        undirected_graph.add_node(unreachable_node)
        expect(dijkstra.shortest_path_to(unreachable_node)).to be nil
      end

      it 'is nil when the node is not part of the graph' do
        unknown_node = Abuelo::Node.new('foo')
        expect(dijkstra.shortest_path_to(unknown_node)).to be nil
      end

      context 'wikipedia example' do
        it 'solves the problem for node 1' do
          node = undirected_graph.find_node_by_name('node 1')
          expect(dijkstra.shortest_path_to(node)).to be nil
        end

        it 'solves the problem for node 2' do
          node = undirected_graph.find_node_by_name('node 2')
          shortest_path = ['node 1', 'node 2']
          expect(dijkstra.shortest_path_to(node).map(&:to_s)).to eq shortest_path
        end

        it 'solves the problem for node 3' do
          node = undirected_graph.find_node_by_name('node 3')
          shortest_path = ['node 1', 'node 3']
          expect(dijkstra.shortest_path_to(node).map(&:to_s)).to eq shortest_path
        end

        it 'solves the problem for node 4' do
          node = undirected_graph.find_node_by_name('node 4')
          shortest_path = ['node 1', 'node 3', 'node 4']
          expect(dijkstra.shortest_path_to(node).map(&:to_s)).to eq shortest_path
        end

        it 'solves the problem for node 5' do
          node = undirected_graph.find_node_by_name('node 5')
          shortest_path = ['node 1', 'node 3', 'node 6', 'node 5']
          expect(dijkstra.shortest_path_to(node).map(&:to_s)).to eq shortest_path
        end

        it 'solves the problem for node 6' do
          node = undirected_graph.find_node_by_name('node 6')
          shortest_path = ['node 1', 'node 3', 'node 6']
          expect(dijkstra.shortest_path_to(node).map(&:to_s)).to eq shortest_path
        end
      end
    end
  end

  context 'directed graph' do
    adjacency_matrix = <<-matrix
      0  7 0  0  0 0
      0  0 10 15 0 0
      9  0 0  11 0 2
      0  0 11 0  6 0
      0  0 0  0  0 0
      14 0 0  0  9 0
    matrix
    
    let(:directed_graph) do
      Abuelo::Graph.new(adjacency_matrix: adjacency_matrix, directed: true)
    end
    let(:start_node) { directed_graph.find_node_by_name('node 1') }
    let(:dijkstra)   { described_class.new(directed_graph, start_node) }

    describe '#shortest_distance_to(node)' do
      it 'is 0 for the start node' do
        expect(dijkstra.shortest_distance_to(start_node)).to eq 0
      end

      it 'is Float::INFINITY for an unreachable node' do
        unreachable_node = Abuelo::Node.new('unreachable node')
        directed_graph.add_node(unreachable_node)
        expect(dijkstra.shortest_distance_to(unreachable_node)).to eq Float::INFINITY
      end

      it 'is nil when the node is not part of the graph' do
        unknown_node = Abuelo::Node.new('foo')
        expect(dijkstra.shortest_distance_to(unknown_node)).to be nil
      end

      context 'example' do
        it 'is 0 for node 1' do
          node = directed_graph.find_node_by_name('node 1')
          expect(dijkstra.shortest_distance_to(node)).to eq 0
        end

        it 'is 7 for node 2' do
          node = directed_graph.find_node_by_name('node 2')
          expect(dijkstra.shortest_distance_to(node)).to eq 7
        end

        it 'is 9 for node 3' do
          node = directed_graph.find_node_by_name('node 3')
          expect(dijkstra.shortest_distance_to(node)).to eq 17
        end

        it 'is 20 for node 4' do
          node = directed_graph.find_node_by_name('node 4')
          expect(dijkstra.shortest_distance_to(node)).to eq 22
        end

        it 'is 20 for node 5' do
          node = directed_graph.find_node_by_name('node 5')
          expect(dijkstra.shortest_distance_to(node)).to eq 28
        end

        it 'is 11 for node 6' do
          node = directed_graph.find_node_by_name('node 6')
          expect(dijkstra.shortest_distance_to(node)).to eq 19
        end
      end
    end

    describe '#shortest_path_to(node)' do
      it 'is nil for the start node' do
        expect(dijkstra.shortest_path_to(start_node)).to be nil
      end

      it 'is nil for an unreachable node' do
        unreachable_node = Abuelo::Node.new('unreachable node')
        directed_graph.add_node(unreachable_node)
        expect(dijkstra.shortest_path_to(unreachable_node)).to be nil
      end

      it 'is nil when the node is not part of the graph' do
        unknown_node = Abuelo::Node.new('foo')
        expect(dijkstra.shortest_path_to(unknown_node)).to be nil
      end

      context 'example' do
        it 'solves the problem for node 1' do
          node = directed_graph.find_node_by_name('node 1')
          expect(dijkstra.shortest_path_to(node)).to be nil
        end

        it 'solves the problem for node 2' do
          node = directed_graph.find_node_by_name('node 2')
          shortest_path = ['node 1', 'node 2']
          expect(dijkstra.shortest_path_to(node).map(&:to_s)).to eq shortest_path
        end

        it 'solves the problem for node 3' do
          node = directed_graph.find_node_by_name('node 3')
          shortest_path = ['node 1', 'node 2', 'node 3']
          expect(dijkstra.shortest_path_to(node).map(&:to_s)).to eq shortest_path
        end

        it 'solves the problem for node 4' do
          node = directed_graph.find_node_by_name('node 4')
          shortest_path = ['node 1', 'node 2', 'node 4']
          expect(dijkstra.shortest_path_to(node).map(&:to_s)).to eq shortest_path
        end

        it 'solves the problem for node 5' do
          node = directed_graph.find_node_by_name('node 5')
          shortest_path = ['node 1', 'node 2', 'node 3', 'node 6', 'node 5']
          expect(dijkstra.shortest_path_to(node).map(&:to_s)).to eq shortest_path
        end

        it 'solves the problem for node 6' do
          node = directed_graph.find_node_by_name('node 6')
          shortest_path = ['node 1', 'node 2', 'node 3', 'node 6']
          expect(dijkstra.shortest_path_to(node).map(&:to_s)).to eq shortest_path
        end
      end
    end
  end
end
