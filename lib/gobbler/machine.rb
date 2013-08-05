module Gobbler

  def self.machine(guid); Machine.get(guid); end
  def self.machines(opts = {}); Machine.list(opts); end

  class Machine < Base
    include Mappable

    def self.list(opts = {})
      opts[:offset] ||= 0
      ::Gobbler.request("client_machine/sync_ask", options: opts)["updates"].map {|machine| new(machine)}
    end

  end
end
