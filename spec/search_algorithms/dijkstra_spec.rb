require 'spec_helper'

RSpec.describe Abuelo::SearchAlgorithms::Dijkstra do
  let(:graph) { Abuelo::Graph.new }
  let(:searcher) { described_class.new(graph) }

  context 'example from wiki' do
    let(:nodes) { (1..6).map { |n| Abuelo::Node.new(n) } }
    before do
      nodes.each { |node| graph.add_node node }

      graph.add_edge(Abuelo::Edge.new(nodes[0], nodes[1], 7))
      graph.add_edge(Abuelo::Edge.new(nodes[0], nodes[2], 9))
      graph.add_edge(Abuelo::Edge.new(nodes[0], nodes[5], 14))
      graph.add_edge(Abuelo::Edge.new(nodes[1], nodes[2], 10))
      graph.add_edge(Abuelo::Edge.new(nodes[1], nodes[3], 15))
      graph.add_edge(Abuelo::Edge.new(nodes[2], nodes[5], 2))
      graph.add_edge(Abuelo::Edge.new(nodes[2], nodes[3], 11))
      graph.add_edge(Abuelo::Edge.new(nodes[5], nodes[4], 9))
      graph.add_edge(Abuelo::Edge.new(nodes[3], nodes[4], 6))
    end

    it { expect(searcher.find_path(nodes[0], nodes[1])).to eq 7 }
    it { expect(searcher.find_path(nodes[0], nodes[2])).to eq 9 }
    it { expect(searcher.find_path(nodes[0], nodes[3])).to eq 20 }
    it { expect(searcher.find_path(nodes[0], nodes[4])).to eq 20 }
    it { expect(searcher.find_path(nodes[0], nodes[5])).to eq 11 }
  end
end
