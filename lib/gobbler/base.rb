module Gobbler
  class Base
    attr_accessor :json

    def self.get(guid)
      list.find {|p| p.guid == guid}
    end

    def initialize(json)
      @json = json
    end

    def base_attr; json; end

    def method_missing(method, *args, &block)
      if base_attr.keys.include?(method.to_s) || method == :assets
        if method == :assets && base_attr.keys.include?("assets_packed")
          ::Gobbler.unpack(base_attr["assets_packed"])
        else
          base_attr[method.to_s]
        end
      else
        super(method, *args, &block)
      end
    end
  end
end
