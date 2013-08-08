module Gobbler

  # Alias for {Gobbler::Dashboard.get}
  # @return [Dashboard] Metrics for your account
  def self.dashboard; Dashboard.get; end

  class Dashboard < Base

    # @return [Dashboard] Metrics for your account
    def self.get
      new(::Gobbler.request "account/dashboard.json")
    end
  end
end
