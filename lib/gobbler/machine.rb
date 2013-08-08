module Gobbler

  # Alias for {Gobbler::Machine.get}
  # @param guid [String] The guid of the machine
  # @return [Machine]
  def self.machine(guid); Machine.get(guid); end

  # Alias for {Gobbler::Machine.list}
  # @return [Array<Machine>] An array of Folders
  def self.machines(opts = {}); Machine.list(opts); end

  class Machine < Base
    include Mappable

    # @return [Array<Machine>] Machines that have been connected to your account
    def self.list(opts = {})
      opts[:offset] ||= 0
      ::Gobbler.request("client_machine/sync_ask", options: opts)["updates"].map {|machine| new(machine)}
    end

  end
end
