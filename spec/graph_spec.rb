require 'spec_helper'

RSpec.describe Abuelo::Graph do

  let(:node_1) { Abuelo::Node.new('node 1') }
  let(:node_2) { Abuelo::Node.new('node 2') }
  let(:node_3) { Abuelo::Node.new('node 3') }
  let(:edge_1) { Abuelo::Edge.new(node_1, node_2, 42) }
  let(:edge_2) { Abuelo::Edge.new(node_2, node_3, 23) }

  let(:directed_graph) do
    described_class.new(directed: true)
      .add_node(node_1)
      .add_node(node_2)
      .add_node(node_3)
      .add_edge(edge_1)
      .add_edge(edge_2)
  end

  let(:undirected_graph) do
    described_class.new
      .add_node(node_1)
      .add_node(node_2)
      .add_node(node_3)
      .add_edge(edge_1)
      .add_edge(edge_2)
  end

  context 'directed graph' do
    describe '#undirected?' do
      it 'is false' do
        expect(directed_graph.undirected?).to be false
      end
    end

    describe '#directed?' do
      it 'is true' do
        expect(directed_graph.directed?).to be true
      end
    end

    describe 'order' do
      it 'returns the count of nodes' do
        expect(directed_graph.order).to eq 3
      end
    end

    describe 'size' do
      it 'returns the count of edges' do
        expect(directed_graph.size).to eq 2
      end
    end

    context 'nodes' do
      describe '#nodes' do
        it 'returns the nodes of the graph' do
          expect(directed_graph.nodes).to match_array [node_1, node_2, node_3]
        end
      end

      describe '#add_node(node)' do
        it 'adds the node to the graph' do
          new_node = Abuelo::Node.new('node 4')

          expect{
            directed_graph.add_node(new_node)
          }.to change{ directed_graph.nodes.count }.by 1

          expect(directed_graph.has_node?(new_node)).to be true
        end

        it 'raises an error if a node with the same name in the graph exists' do
          new_node = Abuelo::Node.new('node 1')

          expect{
            directed_graph.add_node(new_node)
          }.to raise_error(Abuelo::Exceptions::NodeAlreadyExistsError)
        end

        it 'sets the graph of the node to itself' do
          new_node = Abuelo::Node.new('node 4')

          expect{
            directed_graph.add_node(new_node)
          }.to change{ new_node.graph }.to(directed_graph)
        end
      end

      describe '#has_node?(node)' do
        it 'returns true if node is in the graph. checks object name' do
          expect(directed_graph.has_node?(node_1)).to be true
        end

        it 'returns false if node is not in the graph. checks object name' do
          new_node = Abuelo::Node.new('node 99')
          expect(directed_graph.has_node?(new_node)).to be false
        end
      end

      describe '#has_node_with_name?(name)' do
        it 'returns true if a node with the given name is in the graph' do
          expect(directed_graph.has_node_with_name?('node 1')).to be true
        end

        it 'returns false if no node with the given name is in the graph' do
          expect(directed_graph.has_node_with_name?('foo')).to be false
        end
      end
    end


    context 'edges' do
      describe '#edges' do
        it 'returns the edges of the graph' do
          expect(directed_graph.edges).to match_array [edge_1, edge_2]
        end
      end

      describe '#add_edge(edge)' do
        it 'adds the edge to the graph' do
          new_edge = Abuelo::Edge.new(node_2, node_1, 23)

          expect{
            directed_graph.add_edge(new_edge)
          }.to change{ directed_graph.edges.count }.by 1

          expect(directed_graph.has_edge?(new_edge)).to be true
        end

        it 'raises an error if an edge with the same name nodes in the graph exists' do
          new_edge = Abuelo::Edge.new(node_1, node_2, 23)

          expect{
            directed_graph.add_edge(new_edge)
          }.to raise_error(Abuelo::Exceptions::EdgeAlreadyExistsError)
        end
      end

      describe '#edges_for_node(node)' do
        it 'returns all edges that start from the given node' do
          expect(directed_graph.edges_for_node(node_1)).to eq [edge_1]
          expect(directed_graph.edges_for_node(node_2)).to eq [edge_2]
          expect(directed_graph.edges_for_node(node_3)).to eq []
        end
      end

      describe '#has_edge?(edge)' do
        it 'returns true if there is an edge with similiar nodes in the graph' do
          expect(directed_graph.has_edge?(edge_1)).to be true
        end

        it 'does not have a symmetric edge automatically' do
          expect(directed_graph.has_edge?(edge_1.symmetric)).to be false
        end

        it 'returns false if there is no edge with similiar nodes in the graph' do
          other_edge = Abuelo::Edge.new(node_2, node_1, 23)
          expect(directed_graph.has_edge?(other_edge)).to be false
        end
      end

      describe '#find_edge(node_1, node_2)' do
        it 'returns the edge if it can be found in the graph' do
          expect(directed_graph.find_edge(node_1, node_2)).to eq edge_1
        end

        it 'returns nil if the edge cannot be found in the graph' do
          expect(directed_graph.find_edge(node_2, node_1)).to be nil
        end
      end
    end
  end

  context 'undirected graph' do
    describe '#undirected?' do
      it 'is true' do
        expect(undirected_graph.undirected?).to be true
      end
    end

    describe '#directed?' do
      it 'is false' do
        expect(undirected_graph.directed?).to be false
      end
    end

    describe 'order' do
      it 'returns the count of nodes' do
        expect(undirected_graph.order).to eq 3
      end
    end

    describe 'size' do
      it 'returns the count of edges' do
        expect(undirected_graph.size).to eq 2
      end
    end

    context 'nodes' do
      describe '#nodes' do
        it 'returns the nodes of the graph' do
          expect(undirected_graph.nodes).to match_array [node_1, node_2, node_3]
        end
      end

      describe '#add_node(node)' do
        it 'adds the node to the graph' do
          new_node = Abuelo::Node.new('node 4')

          expect{
            undirected_graph.add_node(new_node)
          }.to change{ undirected_graph.nodes.count }.by 1

          expect(undirected_graph.has_node?(new_node)).to be true
        end

        it 'raises an error if a node with the same name in the graph exists' do
          new_node = Abuelo::Node.new('node 1')

          expect{
            undirected_graph.add_node(new_node)
          }.to raise_error(Abuelo::Exceptions::NodeAlreadyExistsError)
        end

        it 'sets the graph of the node to itself' do
          new_node = Abuelo::Node.new('node 4')

          expect{
            undirected_graph.add_node(new_node)
          }.to change{ new_node.graph }.to(undirected_graph)
        end
      end

      describe '#has_node?(node)' do
        it 'returns true if node is in the graph. checks object name' do
          expect(undirected_graph.has_node?(node_1)).to be true
        end

        it 'returns false if node is not in the graph. checks object name' do
          new_node = Abuelo::Node.new('node 4')
          expect(undirected_graph.has_node?(new_node)).to be false
        end
      end

      describe '#has_node_with_name?(name)' do
        it 'returns true if a node with the given name is in the graph' do
          expect(undirected_graph.has_node_with_name?('node 1')).to be true
        end

        it 'returns false if no node with the given name is in the graph' do
          expect(undirected_graph.has_node_with_name?('foo')).to be false
        end
      end
    end


    context 'edges' do
      describe '#edges' do
        it 'returns the edges of the graph' do
          edges = [[edge_1, edge_1.symmetric], [edge_2, edge_2.symmetric]]
          expect(undirected_graph.edges).to match_array edges
        end
      end

      describe '#add_edge(edge)' do
        it 'adds the edge to the graph' do
          new_edge = Abuelo::Edge.new(node_1, node_3, 23)

          expect{
            undirected_graph.add_edge(new_edge)
          }.to change{ undirected_graph.edges.count }.by 1

          expect(undirected_graph.has_edge?(new_edge)).to be true
          expect(undirected_graph.has_edge?(new_edge.symmetric)).to be true
        end

        it 'raises an error if an edge with the same name nodes in the graph exists' do
          new_edge = Abuelo::Edge.new(node_1, node_2, 23)

          expect{
            undirected_graph.add_edge(new_edge)
          }.to raise_error(Abuelo::Exceptions::EdgeAlreadyExistsError)
        end
      end

      describe '#edges_for_node(node)' do
        it 'returns all edges that start from the given node' do
          expect(undirected_graph.edges_for_node(node_1)).to eq [edge_1]
          expect(undirected_graph.edges_for_node(node_2)).to eq [edge_1.symmetric, edge_2]
          expect(undirected_graph.edges_for_node(node_3)).to eq [edge_2.symmetric]
        end
      end

      describe '#has_edge?(edge)' do
        it 'returns true if there is an edge with similiar nodes in the graph' do
          expect(undirected_graph.has_edge?(edge_1)).to be true
          expect(undirected_graph.has_edge?(edge_1.symmetric)).to be true
        end

        it 'returns false if there is no edge with similiar nodes in the graph' do
          other_edge = Abuelo::Edge.new(node_1, node_3, 23)
          expect(undirected_graph.has_edge?(other_edge)).to be false
        end
      end

      describe '#find_edge(node_1, node_2)' do
        it 'returns the edge if it can be found in the graph' do
          expect(undirected_graph.find_edge(node_1, node_2)).to eq edge_1
          expect(undirected_graph.find_edge(node_2, node_1)).to eq edge_1.symmetric
        end

        it 'returns nil if the edge cannot be found in the graph' do
          expect(undirected_graph.find_edge(node_1, node_3)).to be nil
        end
      end
    end
  end

end
