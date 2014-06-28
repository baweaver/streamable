require 'spec_helper'

include Streamable

describe 'Streamable' do

  describe '#stream' do
    context 'With methods as Symbols' do
      it 'returns 5 after piping through method :plus_two' do
        expect(stream 3, :plus_two).to eq(5)
      end

      it 'returns a float when also passed through :Float' do
        expect(stream 3, :plus_two, :Float).to eq(5)
      end
    end

    context 'With lambdas' do
      it 'returns 5 after piping through a lambda' do
        expect(stream 3, -> i { i + 2}).to eq(5)
      end
    end

    context 'With mixed lambdas and symbols' do
      it 'returns 10 after piping through #plus_two and a lambda' do
        expect(stream 3, :plus_two, -> i { i * 2 }).to eq(10)
      end
    end
  end

  describe '#multistream' do
    context 'With methods as Symbols' do
      it 'returns the two numbers added' do
        expect(multistream data: [1,2], methods: [:add_nums]).to eq(3)
      end
    end

    context 'With lambdas' do
      it 'returns the two numbers multiplied' do
        expect(multistream data: [1,2], methods: [-> (a,b) { a * b }]).to eq(2)
      end
    end
  end
end

def plus_two(i) i + 2 end
def add_nums(a,b) a + b end
