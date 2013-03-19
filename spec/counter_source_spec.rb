require "spec_helper"
require "enthralled/sources/counter_source"
require "enthralled/pool"

describe Enthralled::CounterSource do
  it "generates bits in the pool" do
    p = Enthralled::BitPool.new(1)
    cs = Enthralled::CounterSource.new(p)
    sleep(0.002)
    expect(p.next_byte).not_to eq(nil)
    cs.shutdown
  end
end
