require "frank"
require "http"
require "./views/index"

def headers
  headers = HTTP::Headers.new
  headers["Content-Type"] = "text/plain;charset=UTF-8"
  headers["User-Agent"] = "Crown"
  headers
end

def markdown(file)
  File.read(file)
end

def to_html(markdown)
  response = HTTP::Client.post("https://api.github.com/markdown/raw", headers, markdown)
  response.body
end

get "/" do |context|
  md = markdown("./README.md")
  context.response.content_type = "text/html"
  Views::Index.new to_html(md)
end
