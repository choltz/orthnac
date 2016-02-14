# Public: return the current relative path
def current_path
  URI.parse(current_url).path
end
