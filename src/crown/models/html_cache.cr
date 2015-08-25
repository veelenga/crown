require "crypto/md5"

struct Crown::Models::HtmlCache
  def initialize()
    @cache = {} of String => Entry(String, String)
  end

  def save(path: String, md: String, html: String)
    @cache[path] = Entry.new(to_hex(md), html)
  end

  def fetch(path: String, md: String)
    entry = @cache[path]?
    return entry.value if entry && entry.key == to_hex(md)
    nil
  end

  struct Entry(K, V)
    getter key
    getter value

    def initialize(@key : K, @value : V)
    end
  end

  private def to_hex(data: String)
    Crypto::MD5.hex_digest(data)
  end
end
