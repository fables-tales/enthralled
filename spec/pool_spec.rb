require "spec_helper"
require "enthralled/pool"

describe Enthralled::BitPool do

  context "with a flush count of 2" do
    it "does not flush when given a single byte" do
      p = Enthralled::BitPool.new(2)
      p.consume(0)
      expect(p.next_byte).to eq(nil)
    end

    it "does flush when given two bytes" do
      p = Enthralled::BitPool.new(2)
      p.consume(0)
      p.consume(0)
      expect(p.next_byte).not_to eq(nil)
    end
  end

  context "with a flush count of 1" do
    it "gives at least 1 byte of output when given 1 byte of input" do
      p = Enthralled::BitPool.new(1)
      p.consume(0)
      p.next_byte.should_not be_nil
    end

    it "gives nil when given no input" do
      p = Enthralled::BitPool.new(1)
      p.next_byte.should be_nil
    end

    it "should not give the same byte stream twice" do
      p = Enthralled::BitPool.new(1)
      p.consume(0)
      stream = []
      b = p.next_byte
      while b != nil
        stream << b
        b = p.next_byte
      end

      p.consume(0)
      stream2 = []
      b = p.next_byte
      while b != nil
        stream2 << b
        b = p.next_byte
      end

      expect { stream }.not_to eq(stream2)
    end
  end
end
