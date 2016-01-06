require 'spec_helper'

RSpec.describe Abuelo::Graph do

  let(:node_1) { Abuelo::Node.new('node 1') }
  let(:node_2) { Abuelo::Node.new('node 2') }
  let(:edge)   { Abuelo::Edge.new(node_1, node_2, 42) }

  let(:graph) do 
    graph = described_class.new
    graph.add_node(node_1)
    graph.add_node(node_2)
    graph.add_edge(edge)
  end

  context 'nodes' do
    describe '#nodes' do
      it 'returns the nodes of the graph' do
        expect(graph.nodes).to match_array [node_1, node_2]
      end
    end

    describe '#add_node(node)' do
      it 'adds the node to the graph' do
        new_node = Abuelo::Node.new('node 3')

        expect{
          graph.add_node(new_node)
        }.to change{ graph.nodes.count }.by 1

        expect(graph.has_node?(new_node)).to be true
      end

      it 'raises an error if a node with the same name in the graph exists' do
        new_node = Abuelo::Node.new('node 1')

        expect{
          graph.add_node(new_node)
        }.to raise_error(Abuelo::Exceptions::NodeAlreadyExistsError)
      end

      it 'sets the graph of the node to itself' do
        new_node = Abuelo::Node.new('node 3')

        expect{
          graph.add_node(new_node)
        }.to change{ new_node.graph }.to(graph)
      end
    end

    describe '#has_node?(node)' do
      it 'returns true if node is in the graph. checks object name' do
        expect(graph.has_node?(node_1)).to be true
      end

      it 'returns false if node is not in the graph. checks object name' do
        new_node = Abuelo::Node.new('node 3')
        expect(graph.has_node?(new_node)).to be false
      end
    end

    describe '#has_node_with_name?(name)' do
      it 'returns true if a node with the given name is in the graph' do
        expect(graph.has_node_with_name?('node 1')).to be true
      end

      it 'returns fale if no node with the given name is in the graph' do
        expect(graph.has_node_with_name?('foo')).to be false
      end
    end
  end


  context 'edges' do
    describe '#edges' do
      it 'returns the edges of the graph' do
        expect(graph.edges).to match_array [edge]
      end
    end

    describe '#add_edge(edge)' do
      it 'adds the edge to the graph' do
        new_edge = Abuelo::Edge.new(node_2, node_1, 23)

        expect{
          graph.add_edge(new_edge)
        }.to change{ graph.edges.count }.by 1

        expect(graph.has_edge?(new_edge)).to be true
      end

      it 'raises an error if an edge with the same name nodes in the graph exists' do
        new_edge = Abuelo::Edge.new(node_1, node_2, 23)

        expect{
          graph.add_edge(new_edge)
        }.to raise_error(Abuelo::Exceptions::EdgeAlreadyExistsError)
      end
    end

    describe '#edges_for_node(node)' do
      it 'returns all edges that start from the given node' do
        expect(graph.edges_for_node(node_1)).to eq [edge]
        expect(graph.edges_for_node(node_2)).to eq []
      end
    end

    describe '#has_edge?(edge)' do
      it 'returns true if there is an edge with similiar nodes in the graph' do
        expect(graph.has_edge?(edge)).to be true
      end

      it 'returns false if there is no edge with similiar nodes in the graph' do
        other_edge = Abuelo::Edge.new(node_2, node_1, 23)
        expect(graph.has_edge?(other_edge)).to be false
      end
    end

    describe '#find_edge(node_1, node_2)' do
      it 'returns the edge if it can be found in the graph' do
        expect(graph.find_edge(node_1, node_2)).to eq edge
      end

      it 'returns nil if the edge cannot be found in the graph' do
        expect(graph.find_edge(node_2, node_1)).to be nil
      end
    end
  end

end
