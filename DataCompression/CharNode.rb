# =======================================================================================
# DataCompression - Ruby Code Samples
# CharNode.rb
#
# Written by Tuan Anh Nguyen - Software Engineer
#                              www.MyAIvisions.com
# CopyRight - Dec 10, 2014
#
# =======================================================================================

class CCharNode
  
  def initialize(char_node = nil)
    @parent      = (char_node == nil)? nil : char_node.parent      
    @left_child  = (char_node == nil)? nil : char_node.left_child
    @right_child = (char_node == nil)? nil : char_node.right_child
    @node_code   = (char_node == nil)? 'X' : char_node.node_code # '0' : left_child
                                                                 # '1' : right_child
                                                                 # 'X' : root of the tree
    @character   = (char_node == nil)? '-' : char_node.character
    @frequency   = (char_node == nil)?  0  : char_node.frequency
  end

  def print
    puts 'CharNode: '
    puts "#{ self } (code: #{ self.node_code }) - #{ self.character } - #{ self.frequency }"
    puts "P: #{ self.parent } - L: #{ self.left_child } - R: #{ self.right_child }"
    puts ""  	
  end

  attr_accessor :parent, :left_child, :right_child, :node_code,
                :character, :frequency

end