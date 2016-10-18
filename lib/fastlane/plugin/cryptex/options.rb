require 'fastlane_core'
require 'credentials_manager'

module Fastlane
  module Cryptex
    class Options
      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :git_url,
                                       env_name: "CRYPTEX_GIT_URL",
                                       description: "URL to the git repo containing all the certificates",
                                       optional: false,
                                       short_option: "-r"),
          FastlaneCore::ConfigItem.new(key: :workspace,
                                                                    description: nil,
                                                                    verify_block: proc do |value|
                                                                      unless Helper.test?
                                                                        if value.start_with?("/var/folders") or value.include?("tmp/") or value.include?("temp/")
                                                                          # that's fine
                                                                        else
                                                                          UI.user_error!("Specify the `git_url` instead of the `path`")
                                                                        end
                                                                      end
                                                                    end,
                                                                    optional: true),
          FastlaneCore::ConfigItem.new(key: :git_branch,
                                       env_name: "CRYPTEX_GIT_BRANCH",
                                       description: "Specific git branch to use",
                                       default_value: 'master'),
          FastlaneCore::ConfigItem.new(key: :key,
                                       short_option: "-k",
                                       env_name: "CRYPTEX_FILE_KEY",
                                       description: "The File KEY",
                                       default_value: ""),
          FastlaneCore::ConfigItem.new(key: :in,
                                       short_option: "-i",
                                       env_name: "CRYPTEX_IN",
                                       description: "The File KEY",
                                       default_value: ""),
          FastlaneCore::ConfigItem.new(key: :out,
                                       short_option: "-o",
                                       env_name: "CRYPTEX_OUT",
                                       description: "The File KEY",
                                       default_value: ""),
          FastlaneCore::ConfigItem.new(key: :type,
                                       short_option: "-s",
                                       env_name: "CRYPTEX_TYPE",
                                       description: "Sub-Action Type (export, import, decrypt)",
                                      default_value: "export"),
          FastlaneCore::ConfigItem.new(key: :verbose,
                                       env_name: "CRYPTEX_VERBOSE",
                                       description: "Print out extra information and all commands",
                                       is_string: false,
                                       default_value: false,
                                       verify_block: proc do |value|
                                         $verbose = true if value
                                       end),
          FastlaneCore::ConfigItem.new(key: :shallow_clone,
                                       env_name: "CRYPTEX_SHALLOW_CLONE",
                                       description: "Make a shallow clone of the repository (truncate the history to 1 revision)",
                                       is_string: false,
                                       default_value: false),
          FastlaneCore::ConfigItem.new(key: :skip_docs,
                                       env_name: "CRYPTEX_SKIP_DOCS",
                                       description: "Skip generation of a README.md for the created git repository",
                                       is_string: false,
                                       default_value: false)
        ]
      end
    end
  end
end