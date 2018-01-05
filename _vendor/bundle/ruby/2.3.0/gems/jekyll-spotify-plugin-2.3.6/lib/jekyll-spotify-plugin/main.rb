require "jekyll"
require "yaml"
require "benchmark"
require "find"
require "fileutils"
require "open-uri"

module Jekyll
  module Spotify
    module Plugin

      # Instance class
      $utils = Utils.new
      $template = Template.new


      class Generator < Jekyll::Generator

        def generate(site)
          @site = site
          @site.static_files.concat static_files
          $utils.copy_sass_manual
        end

        def static_files
           source = File.dirname($utils.assets_path)
            asset_files.map do |file|
            dir = File.dirname(file)
            file_name = File.basename(file)
            Jekyll::StaticFile.new @site, source, dir, file_name
          end
        end


        def asset_files
          asset_files = []
            Find.find($utils.assets_path).each do |path|
            next if File.directory?(path)
            next if path.include?($utils.stylesheets_sass_path)
            asset_files << path.sub($utils.assets_path, 'assets')
          end
          asset_files
        end

      end # Generator

      # class load SASS
      class << self

        def loadSass
          $utils.configure_sass($utils)
          # Jekyll::Spotify::Plugin::@utils.configure_sass(@@utils)
        end

      end # self

      # Implement Jekyll Spotify Plugin in Page
      class Main < Liquid::Tag

        def initialize(tag_name, input, tokens)
          super
            @tag_name = tag_name
            @input = input
        end

        def render(context)

          input_split = $utils.split_params(@input)

          user = $utils.parameter_user(input_split)
          type = $utils.parameter_type(input_split)
          id = $utils.parameter_id(input_split)

          # Customizing Url Spotify
          if not user.empty? and type == "playlist"
            url = "https://embed.spotify.com/?uri=#{@tag_name}:user:#{user}:#{type}:#{id}"
          else
            url = "https://embed.spotify.com/?uri=#{@tag_name}:#{type}:#{id}"
          end

          # Load YML
          yml = $utils.yml_config('_config.yml')

          # Load configuration root of Jekyll Spotify Plugin in _config.yml
          spotify_root = yml["spotify"]

          # Message to report error if the Spotify settings in _config.yml are not found and the Jekyll Spotify Plugin is loaded in _config.yml
          $utils.errors_not_found_jsp_config(spotify_root,"[x] Error: Configuration Jekyll Spotify Plugin not found in  _config.yml")

          # Checks a series of error values in the settings of Jekyll Spotify Plugin in _config.yml
          $utils.errors_value_incorrect(spotify_root["title"]["enable"],true,false,"[x] Error: Variable 'enable' from 'title' is incorrect.")

          $utils.errors_value_incorrect(spotify_root["content"]["enable"],true,false,"[x] Error: Variable 'enable' from 'content' is incorrect.")

          # If found, it loads the variable 'theme' in _config.yml
          spotify_theme = yml["spotify"]["theme"]


          $utils.errors_value_incorrect(spotify_theme,"dark","light","[x] Error: Variable 'theme' in _config.yml it is incorrect.")

          # $utils.

          # Choose which theme (dark or white) will be applied in Spotify frame
          theme_name = $utils.choose_theme(spotify_theme,theme_name)

           # If there are no errors starting the plugin
          $template.content(spotify_root,type,url,theme_name,id)

        end # def render

      end # class Main


    end # module Plugin
  end # module Spotify
end # module Jekyll


# Load files: (SASS)
Jekyll::Spotify::Plugin.loadSass

# Register plugins (tag)
Liquid::Template.register_tag('spotify', Jekyll::Spotify::Plugin::Main)