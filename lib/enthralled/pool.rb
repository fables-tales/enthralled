require "thread"
require "openssl"

module Enthralled
  class BitPool
    def initialize(count)
      @counter = 0
      @bytes_for_trigger = count
      @byte_queue = Queue.new
      @accum = 0
    end

    def consume(byte)
      @accum = (@accum << 8) + byte
      @counter += 1

      produce_bytes if @counter == @bytes_for_trigger
    end

    def next_byte
      begin
        @byte_queue.pop(true)
      rescue ThreadError
        nil
      end
    end

    private

    def produce_bytes
      OpenSSL::Digest::SHA256.digest([@accum].pack("\I")).bytes.each do |byte|
        @byte_queue << byte
      end
    end
  end
end
