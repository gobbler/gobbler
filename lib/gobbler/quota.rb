module Gobbler

  # Alias for {Quota.get}
  def self.quota; Quota.get; end

  class Quota < Base

    # @return [Quota] The transfer and storage quota for your account
    def self.get
      new(::Gobbler.request("v1/quotas"))
    end

    # @return [Integer] The total bytes you can sending (note -1 represents unlimted)
    def transfer
      quotas["limits"]["transfer"]
    end

    # @return [Boolean] If your account has unlimited sending
    def unlimited_transfer?
      transfer == -1
    end

    # @return [Integer] The total bytes you can backup (note -1 represents unlimted)
    def storage
      quotas["limits"]["storage"]
    end
  end
end
