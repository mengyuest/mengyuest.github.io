module Jekyll
  module Spotify
    module Plugin
      class Utils

        def gem_path
          @gem_path ||= File.expand_path '../..', File.dirname(__FILE__)
        end

        def assets_path
          File.join gem_path, 'assets'
        end

        def iframe
          File.join gem_path, 'template/frame.html'
        end

        def stylesheets_sass_path
          File.join assets_path, 'stylesheets/sass'
        end

        def stylesheets_sass_manual_path
          File.join assets_path, 'stylesheets/sass/manual'
        end

        def javascripts_path
          File.join assets_path, 'javascripts'
        end

        def copy_sass_manual
          yml = yml_config('_config.yml')
          return false if yml["spotify"]["sass"].nil? ||  yml["spotify"]["sass"]["dir"].nil?
          use_sass_jekyll = yml["spotify"]["sass"]["jekyll"]
          dir_copy = File.join yml["spotify"]["sass"]["dir"], 'jekyll_spotify_plugin'
           if use_sass_jekyll == false
            if not File.directory?(dir_copy)
              FileUtils::mkdir_p "#{dir_copy}"
            end
            FileUtils.copy_entry stylesheets_sass_manual_path, dir_copy
          end
        end

        def parameter_user(input_split)
          input_split[0].strip
        end

        def parameter_type(input_split)
          input_split[1].strip
        end

        def parameter_id(input_split)
          input_split[2].strip
        end

        def yml_config(yml)
          YAML::load_file(File.join(yml))
        end

        def split_params(params)
          params.split("/")
        end

        def errors_not_found_jsp_config(verify,message)
          if not verify
            raise RuntimeError, "#{message}"
            fail
          end
        end

        def errors_value_incorrect(value_incorrect,value1,value2,message)
          if not value_incorrect == value1 and  not value_incorrect == value2
            # Message for error details
            raise RuntimeError, "#{message}"
            fail
            # Message for error simple
            # puts "#{message}".red
            # exit
          end
        end

        def choose_theme(receive,theme_name)
           receive == "light" ? theme_name = "white" : theme_name = "dark"
        end

        def configure_sass(utils)
          require "sass"
          require "bootstrap-sass"
          # Inspired by bootstrap-sass
          ::Sass.load_paths << utils.stylesheets_sass_path
          ::Sass::Script::Number.precision = [8, ::Sass::Script::Number.precision].max
        end

      end # class Utils
    end # module Plugin
  end # module Spotify
end # module Jekyll