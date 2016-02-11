require 'spec_helper'

RSpec.describe Abuelo::Edge do
  let(:node_1) { Abuelo::Node.new('node 1') }
  let(:node_2) { Abuelo::Node.new('node 2') }

  let(:edge) { described_class.new(node_1, node_2, 3) }

  context 'initialization' do
    it 'sets the weight to 0 if not given' do
      expect(described_class.new(node_1, node_2).weight).to eq 0
    end
  end

  context 'accessors' do
    it 'has following getters' do
      expect(edge.respond_to?(:node_1)).to be true
      expect(edge.respond_to?(:node_2)).to be true
      expect(edge.respond_to?(:weight)).to be true
    end
  end

  describe '#symmetric' do
    it 'returns an edge object with the same weight, but reversed nodes' do
      symmetric = edge.symmetric
      expect(symmetric.node_1).to eq edge.node_2
      expect(symmetric.node_2).to eq edge.node_1
      expect(symmetric.weight).to eq edge.weight
    end
  end

  describe '#to_s' do
    it 'is human readable' do
      expect(edge.to_s).to eq 'node 1 -> node 2 with weight 3'
    end
  end

  describe '#==(other)' do
    it 'is true when the nodes and weight match' do
      other = Abuelo::Edge.new(node_1, node_2, 3)
      expect(edge == other).to be true
    end

    it 'is false when the nodes do not match' do
      other = Abuelo::Edge.new(node_2, node_1, 3)
      expect(edge == other).to be false
    end

    it 'is false when the weight does not match' do
      other = Abuelo::Edge.new(node_1, node_2, 1)
      expect(edge == other).to be false
    end
  end

  context 'order' do
    it 'is sorted by its weight' do
      edge_1 = described_class.new(node_1, node_2, 1)
      edge_2 = described_class.new(node_1, node_2, 2)
      edge_3 = described_class.new(node_1, node_2, 3)

      edges = [edge_3, edge_1, edge_2]

      expect(edges.sort).to eq [edge_1, edge_2, edge_3]
    end
  end
end
