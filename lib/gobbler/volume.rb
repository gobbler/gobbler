module Gobbler

  # Alias for {Volume.get}
  # @param guid [String] The guid of the volume
  # @return [Volume]
  def self.volume(guid); Volume.get(guid); end

  # Alias for {Volume.list}
  # @return [Array<Volume>] An array of Volumes
  def self.volumes(opts = {}); Volume.list(opts); end

  class Volume < Base
    include Mappable

    # @option opts [Integer] :limit The number of records to return
    # @option opts [Integer] :offset The number of records to offset the
    #   results (useful for paging)
    # @return [Array<Volume>] an array of volumes
    def self.list(opts = {})
      opts[:offset] ||= 0
      ::Gobbler.request("client_volume/sync_ask", options: opts)["updates"].map {|volume| new(volume)}
    end

    # @return [Boolean] If the volume is currently connected to a machine
    def connected?
      currently_connected
    end
  end
end
