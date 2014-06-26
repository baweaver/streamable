require "streamable/version"

def stream(data, *methods)
  methods.reduce(data) { |d, m| m.is_a?(Symbol) ? Kernel.send(m, d) : m[d] }
end

def multistream(data: [], methods: [])
  methods.reduce(data) { |d, m| m.is_a?(Symbol) ? Kernel.send(m, *d) : m[*d] }
end
