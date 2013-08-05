module Gobbler

  def self.quota; Quota.list; end

  class Quota < Base
    def self.list
      new(::Gobbler.request("v1/quotas"))
    end
  end
end
