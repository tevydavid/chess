require_relative "display"

d = Display.new

while true
  d.render
  d.get_input
  system "clear"
end
