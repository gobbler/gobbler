require 'json'
require 'net/http'
require 'uri'
require 'base64'


module Gobbler

  require 'gobbler/base'
  require 'gobbler/mappable'

  require 'gobbler/checkpoint'
  require 'gobbler/client_version'
  require 'gobbler/dashboard'
  require 'gobbler/folder'
  require 'gobbler/machine'
  require 'gobbler/volume'
  require 'gobbler/project'
  require 'gobbler/quota'
  require 'gobbler/referral'

  class << self

    @@api_server = "api.gobbler.com"
    @@client_version = "dev"
    @@machine_serial = "api"
    @@config = {}
    @@keys = {}

    # Set the configuration
    # 
    # Options are passed as a Hash of symbols
    # @option opts [String] :email Email of Gobbler account
    # @option opts [String] :password Password of Gobbler account
    def config(opts)
      opts.each {|k,v| opts[k.to_sym] ||= opts[k]}
      @@config = opts
      @@api_server = opts[:api_server] if opts[:api_server]
      @@client_version = opts[:client_version] if opts[:client_version]
      @@machine_serial = opts[:machine_serial] if opts[:machine_serial]
      login! if opts[:email] && opts[:password]
    end

    # @return [Boolean] Login successful, will raise an error if it was not
    def login!
      raise "No credentials" if @@config[:email].nil? || @@config[:password].nil?

      authentication = {
        machine_info: { serial: @@machine_serial },
        authentication: {
          provider: "gobbler",
          credentials: {
            email: @@config[:email],
            password: @@config[:password] 
          }
        }
      }

      response = request("client_user/login", authentication)
      @@keys[:cookie] = response[:http_response]["Set-Cookie"].split('; ')[0]
      @@keys[:client_key] = response["client_key"]

      raise "Can't Login" if @@keys[:client_key].nil?

      return true
    end

    # @return [Hash] Hash from the JSON API server response
    def request(uri, body = nil)
      uri = URI.parse("https://#{api_server}/#{uri}")
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      if body
        request = Net::HTTP::Post.new(uri.request_uri)
        request.body = body.to_json unless body.nil?
      else
        request = Net::HTTP::Get.new(uri.request_uri)
      end

      request["Content-type"] = "application/json"
      request["Cookie"] = cookie
      request["x-mam-client-version"] = client_version
      request["x-mam-client-key"] = client_key

      response = http.request(request)
      raise unless response.code == "200"
      JSON.parse(response.body).merge(http_response: response)
    end

    # @return [Hash] The unpacked JSON string
    def unpack(str)
      return [] if str.nil? || str == ""
      decoded = Base64.decode64(str)
      unzipped = Zlib::GzipReader.new(StringIO.new(decoded)).read
      JSON.parse(unzipped)
    end

    # @return [Boolean] If you are currently signed into the Gobbler API
    def signed_in?
      !client_key.nil? && client_key != ""
    end

    private

    def api_server; @@api_server; end
    def client_key; @@keys[:client_key]; end
    def client_version; @@client_version; end
    def cookie; @@keys[:cookie]; end
    def machine_serial; @@machine_serial; end
  end

end
