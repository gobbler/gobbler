module Gobbler

  # Alias for {Referral.list}
  # @return [Array<Referral>] All referrals
  def self.referrals; Referral.list; end

  class Referral < Base

    # @return [Array<Referrals>] All referrals
    def self.list
      ::Gobbler.request("account/referrals.json")["referrals"].map {|ref| new(ref)}
    end
  end
end
