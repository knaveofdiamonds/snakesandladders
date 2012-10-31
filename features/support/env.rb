$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', '..', 'lib'))

require 'snakes_and_ladders'

# Helper method to deal with the index offsetting.
def player(p)
  p.to_i - 1
end
