require "ecr/macros"

class Views::Index

  getter :content

  def initialize(content)
    @content = content
  end

  ecr_file "./views/index.ecr"
end
