module Gobbler
  class Checkpoint < Base

    # Gets the checkpoint for a project
    #
    # @option opts [String] :project_id The id of the project to get
    # @option opts [Integer] :checkpoint The number of the checkpoint
    # @return [Checkpoint] the checkpoint
    def self.get(opts)
      raise unless opts[:project_id] && opts[:checkpoint]
      new(::Gobbler.request("v1/projects/#{opts[:project_id]}/checkpoints/#{opts[:checkpoint]}"))
    end

    # @return [Project] The {Project} that this is a checkpoint for
    def project
      ::Gobbler::Project.get(json["project"])
    end

    # Email this version of the project to a list of recipieints
    # @param recipieints [String] A comma-separated list of email addresses
    # @return [Hash] The sevrer response
    def email_to(recipients, opts = {})
      opts[:checkpoint] = num
      project.email_to(recipients, opts)
    end

    private

    def base_attr; json["checkpoint"]; end
  end
end
