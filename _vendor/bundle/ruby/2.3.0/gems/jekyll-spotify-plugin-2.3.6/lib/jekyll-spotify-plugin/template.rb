module Jekyll
  module Spotify
    module Plugin
      class Template

        $year = Time.new

        def content(spotify_root,type,url,theme_name,id)

          url_jsp = "https://williamcanin.github.io/jekyll-spotify-plugin"

          wrapper_text = spotify_root["title"]["enable"] == false and spotify_root["content"]["enable"] == false ? wrapper_text = "none" : wrapper_text = "block"

          title = spotify_root["title"]["enable"] == true ? title = "block" : title = "none"

          content = spotify_root["content"]["enable"] == true ? content = "block" : content = "none"

          type == "album" || type == "playlist" || type == "artist" ? height = 380 : height = 80

          open_track = spotify_root["open"] == true ? open_track = "in" : open_track = "in-not"

          text_button = spotify_root["open"] == true ? text_button = "Hide" : text_button = "Show"

          enable_spotify = spotify_root["enable"]

          if enable_spotify == true
              %(<div class="jsp-theme-base jsp-theme-#{spotify_root["theme"]} jsp-theme-custom">
                  <nav class="navbar navbar-default navbar-default-jsp" role="navigation">
                    <div class="container-fluid">
                      <div class="navbar-header">
                        <p class="navbar-text navbar-left navbar-text-jsp">
                          &nbsp;&copy; #{$year.strftime("%Y")} -
                            <a href="#{url_jsp}" target="_blank" class="navbar-link navbar-link-jsp">
                              Jekyll Spotify Plugin
                            </a>
                        </p>
                        <button type="button" class="btn btn-default navbar-btn navbar-btn-jsp" data-toggle="collapse" data-target="#jsp-content-#{id}"> #{text_button} </button>
                      </div>
                    </div>
                  </nav>
                  <main class="collapse #{open_track} navbar-jsp-collapse jsp-content" id="jsp-content-#{id}">
                    <div class="container-fluid">
                      <div class="wrapper-txt" style="display: #{wrapper_text}">
                        <h1 style="display: #{title};">#{spotify_root["title"]["text"]}</h1>
                        <p style="display: #{content};">#{spotify_root["content"]["text"]} </p>
                      </div>
                      <div class="track-list">
                        <iframe id="frame-track" class="frame-track" src="#{url}&theme=#{theme_name}" width="100%" height="#{height}" frameborder="0" allowtransparency="true"></iframe>
                      </div>
                    </div>
                  </main>
              </div>)
          end

        end # def content
      end # class Template
    end # module Plugin
  end # module Spotify
end # module Jekyll