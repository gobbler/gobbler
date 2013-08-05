module Gobbler

  def self.volume(guid); Volume.get(guid); end
  def self.volumes(opts = {}); Volume.list(opts); end

  class Volume < Base
    include Mappable

    def self.list(opts = {})
      opts[:offset] ||= 0
      ::Gobbler.request("client_volume/sync_ask", options: opts)["updates"].map {|volume| new(volume)}
    end

    def connected?
      currently_connected
    end
  end
end
