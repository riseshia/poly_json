require "poly_json/version"

module PolyJson
  class Error < StandardError; end

  module_function

  def load(json_text)
    {}
  end
end
