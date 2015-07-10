require "ecr/macros"
require "../helpers/*"

class Crown::Views::Index

  include Helpers::UrlHelper

  getter :content

  def initialize(content)
    @content = content
  end

  ecr_file "#{__DIR__}/index.ecr"
end
