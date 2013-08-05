module Gobbler

  def self.referrals; Referral.list; end

  class Referral < Base
    def self.list
      ::Gobbler.request("account/referrals.json")["referrals"].map {|ref| new(ref)}
    end
  end
end
