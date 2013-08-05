module Gobbler
  class Checkpoint < Base
    def self.get(opts)
      raise unless opts[:project_id] && opts[:checkpoint]
      new(::Gobbler.request("v1/projects/#{opts[:project_id]}/checkpoints/#{opts[:checkpoint]}"))
    end

    def project
      ::Gobbler::Project.get(json["project"])
    end

    def email_to(recipients, opts = {})
      opts[:checkpoint] = num
      project.email_to(recipients, opts)
    end

    def base_attr; json["checkpoint"]; end
  end
end
