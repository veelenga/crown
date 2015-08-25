require "../spec_helper"

def regular_cache
  cache = Crown::Models::HtmlCache.new
    .tap(&.save "./README.md", "readme_md", "<html/>")
    .tap(&.save "./Contribution.md", "contr_md", "<html><body/></html>")
end

describe Crown::Models::HtmlCache do
  it "saves and fetches regular data" do
    regular_cache.fetch("./README.md", "readme_md").should eq "<html/>"
  end

  it "fetches nil if appropriate data not exists" do
    regular_cache.fetch("./NO_SUCH_FILE.md", "readme_md").should be nil
  end

  it "fetches nil if md changed" do
    regular_cache.fetch("./README.md", "new_markdown").should be nil
    regular_cache.fetch("./README.md", "contr_md").should be nil
  end
end
