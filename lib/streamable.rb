require "streamable/version"

module Streamable
  def stream(data, *methods)
    methods.reduce(data) { |d, m| m.is_a?(Symbol) ? send(m, d) : m[d] }
  end

  def multistream(data: [], methods: [])
    methods.reduce(data) { |d, m| m.is_a?(Symbol) ? send(m, *d) : m[*d] }
  end
end
