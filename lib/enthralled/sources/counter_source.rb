module Enthralled
  class CounterSource

    DESIRED_BITS = 8

    def initialize(pool, period=0.0001, tap_bits=8)
      @bits_to_tap = tap_bits
      @period = period
      @currently_tapped_bits = 0
      @powered_up = true
      @counter = 0
      @accum = 0
      @pool = pool

      start_counter_thread
      start_timer_thread
    end

    def start_counter_thread
      Thread.new do
        @counter = 0
        while @powered_up
          @counter += 1
        end
      end
    end

    def start_timer_thread
      Thread.new do
        while @powered_up
          sleep @period
          tap_bits
        end
      end
    end

    def shutdown
      @powered_up = false
    end

    private

    def tap_bits
      @accum = (@accum << @bits_to_tap) + masked_counter
      @counter = 0
      @currently_tapped_bits += @bits_to_tap
      if @currently_tapped_bits == DESIRED_BITS
        b = [@accum & ((1 << DESIRED_BITS)-1)].pack("\I").bytes.first
        @pool.consume(b)
        @currently_tapped_bits = 0
        @accum = 0
      end
    end

    def masked_counter
      @counter & ((1 << @bits_to_tap) - 1)
    end
  end
end
