module Gobbler
  module Mappable
    def self.included(base)
      base.extend(Gobbler::Mappable::ClassMethods)
    end

    def city; last_location["city"] unless last_location.nil?; end
    def lat; last_location["lat"]   unless last_location.nil?; end
    def lng; last_location["lng"]   unless last_location.nil?; end
    def coordinates; [lat, lng]; end
    def zip; last_location["zip"]   unless last_location.nil?; end

    module ClassMethods
      def valid_locations; list.collect(&:coordinates).reject {|c| c == [nil,nil] || c == [0.0,0.0]}; end

      def google_maps_url(opts = {})
        opts[:size] ||= "1500x1200"
        opts[:sensor] ||= "true"
        url = "http://maps.googleapis.com/maps/api/staticmap?size=#{opts[:size]}"
        url += "&" + valid_locations.map {|c| "markers=color:green%7Clabel:X%7C#{c[0]},#{c[1]}"}.join("&")
        url += "&sensor=#{opts[:sensor]}"
      end

      def open_map!(opts = {})
        system "open '#{google_maps_url(opts)}'"
      end
    end
  end
end
