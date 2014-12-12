# =======================================================================================
# DataCompression - Ruby Code Samples
# Codec.rb
#
# Written by Tuan Anh Nguyen - Software Engineer
#                              www.MyAIvisions.com
# CopyRight - Dec 10, 2014
#
# =======================================================================================

class CCodec

  def initialize
    @root = CCharNode.new
  end

  def encodeString( input_str )
    raise '--- ERROR ---: input_str == nil' if input_str == nil

    generateCharTree( input_str )
    encoded_str = ''
    input_str.each_char do | c |
      tree_traveller = CCharNode.new(@root)
      eternal_box = CEternalBox.new
      locateCharNode( c, tree_traveller, eternal_box )
      tree_traveller = eternal_box.char_node
      encodeChar( tree_traveller, eternal_box )
      encoded_str << eternal_box.encoded_sequence
  	  # puts "#{ c } - #{ eternal_box.encoded_sequence }"	 # ensuring that each char properly encoded
  	end
    return encoded_str
  end

  def decodeString( encoded_sequence )
    raise '--- ERROR ---: encoded_sequence == nil' if encoded_sequence == nil

    eternal_box = CEternalBox.new
    eternal_box.encoded_sequence = encoded_sequence
    decodeChar( @root, eternal_box )
    return eternal_box.decoded_string
  end

private

  def locateCharNode( input_char, tree_traveller, eternal_box )
    raise '--- ERROR ---: input_char == nil'     if input_char     == nil
    raise '--- ERROR ---: tree_traveller == nil' if tree_traveller == nil
    raise '--- ERROR ---: eternal_box == nil'    if eternal_box    == nil

    eternal_box.char_node = tree_traveller if tree_traveller.character == input_char
    char_found = false
    if tree_traveller.character != input_char
      if( tree_traveller.left_child != nil )
        char_found = locateCharNode( input_char, tree_traveller.left_child, eternal_box )
      end
      if( tree_traveller.right_child != nil && !char_found )
        locateCharNode( input_char, tree_traveller.right_child, eternal_box )
      end 	
    end
    return char_found
  end

  def encodeChar( tree_traveller, eternal_box )
    raise '--- ERROR ---: tree_traveller == nil'  if tree_traveller  == nil
    raise '--- ERROR ---: eternal_box == nil'     if eternal_box     == nil

  	if tree_traveller != @root
      eternal_box.encoded_sequence << tree_traveller.node_code
      encodeChar( tree_traveller.parent, eternal_box )
    else
      eternal_box.encoded_sequence.reverse!    	
    end
  end

  def decodeChar( tree_traveller, eternal_box )
    raise '--- ERROR ---: tree_traveller == nil'  if tree_traveller  == nil
    raise '--- ERROR ---: eternal_box == nil'     if eternal_box     == nil

    next_char = eternal_box.encoded_sequence[eternal_box.encoded_sequence_index];
    
    if( next_char == '0' && tree_traveller.left_child != nil )
      eternal_box.encoded_sequence_index += 1
      decodeChar( tree_traveller.left_child, eternal_box )
    end

    if( next_char == '1' && tree_traveller.right_child != nil )
      eternal_box.encoded_sequence_index += 1
      decodeChar( tree_traveller.right_child, eternal_box )
    end
    
    if( tree_traveller.left_child == nil && tree_traveller.right_child == nil )
      eternal_box.decoded_string << tree_traveller.character
      # puts "#{ tree_traveller.character } found " # ensuring that the right char is decoded

      if( eternal_box.encoded_sequence_index < eternal_box.encoded_sequence.length )
        decodeChar( @root, eternal_box )  
      end
    end
  end

  def generateCharHash( input_str )
    raise '--- ERROR ---: input_str == nil'  if input_str == nil

    char_hash = {}
    input_str.each_char do | c |
      char_hash[c] = ( char_hash.has_key? c ) ? char_hash[c] + 1 : 1 
    end
    char_hash = Hash[char_hash.sort_by { |k, v| v }]
  end

  def printCharNodeQueue( char_node_queue )
    raise '--- ERROR ---: char_node_queue == nil' if char_node_queue == nil
    puts 'Size: ' << char_node_queue.size.to_s
    char_node_queue.each do | char_node |
      puts "#{ char_node } (#{ char_node.node_code }) - #{ char_node.character } - #{ char_node.frequency }"
      puts "P: #{ char_node.parent } - L: #{ char_node.left_child } - R: #{ char_node.right_child }"
      puts ""
    end
  end

  def populateCharTree( char_node_queue, eternal_box)
    raise '--- ERROR ---: char_node_queue == nil' if char_node_queue == nil
    raise '--- ERROR ---: eternal_box == nil'     if eternal_box == nil

    first_two_nodes = char_node_queue[0..1]
    parent = CCharNode.new
    parent.left_child = first_two_nodes[0]
    parent.right_child = first_two_nodes[1]
    parent.frequency = first_two_nodes[0].frequency + first_two_nodes[1].frequency
    
    first_two_nodes[0].parent = parent
    first_two_nodes[0].node_code = '0'
    first_two_nodes[1].parent = parent
    first_two_nodes[1].node_code = '1'

    char_node_queue = char_node_queue[2 .. char_node_queue.length - 1]
    char_node_queue << parent
    # printCharNodeQueue char_node_queue  # ensuring that parent and children properly linked

    populateCharTree( char_node_queue, eternal_box) if( char_node_queue.length > 1 )
    eternal_box.char_node = char_node_queue[0] if (char_node_queue.length == 1)
  end

  def generateCharTree( input_str )
    raise '--- ERROR ---: input_str == nil'  if input_str == nil

    char_hash = generateCharHash( input_str )
    char_node_queue = []
    
    char_hash.each_pair do | k, v |
      temp_node = CCharNode.new	
      temp_node.character = k
      temp_node.frequency = v
      char_node_queue << temp_node
    end
    
    eternal_box = CEternalBox.new
    populateCharTree( char_node_queue, eternal_box)
    @root = eternal_box.char_node
  end

  @root

end














