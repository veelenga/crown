module Crown::Helpers::UrlHelper
  macro content_of(url)
    %{ {{ `curl -s #{url}` }} }
  end
end
