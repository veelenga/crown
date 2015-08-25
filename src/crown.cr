require "frank"
require "http/client"
require "./crown/views/index"
require "./crown/models/html_cache"

HTML_CACHE = Crown::Models::HtmlCache.new

def headers
  headers = HTTP::Headers.new
  headers["Content-Type"] = "text/plain;charset=UTF-8"
  headers["User-Agent"] = "Crown"
  headers
end

def markdown(file)
  File.read(file)
end

def github_md_to_html(md)
  response = HTTP::Client.post("https://api.github.com/markdown/raw", headers, md)
  response.body
end

def to_html(file_path)
  md = markdown(file_path)
  html = HTML_CACHE.fetch(file_path, md)
  unless html
    html = github_md_to_html(md)
    HTML_CACHE.save(file_path, md, html)
  end
  html
end

get "/" do |context|
  file_path = "./README.md"

  context.response.content_type = "text/html"
  Crown::Views::Index.new to_html(file_path)
end
