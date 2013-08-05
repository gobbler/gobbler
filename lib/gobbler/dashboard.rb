module Gobbler
  def self.dashboard; Dashboard.list; end

  class Dashboard < Base
    def self.list
      new(::Gobbler.request "account/dashboard.json")
    end
  end
end
