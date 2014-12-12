# =======================================================================================
# DataCompression - Ruby Code Samples
# EternalBox.rb
#
# Written by Tuan Anh Nguyen - Software Engineer
#                              www.MyAIvisions.com
# CopyRight - Dec 10, 2014
#
# =======================================================================================

class CEternalBox
  def initialize
    @char_node = CCharNode.new
    @decoded_string = ''
    @encoded_sequence = ''
    @encoded_sequence_index = 0
  end

  attr_accessor :char_node, :decoded_string, :encoded_sequence, :encoded_sequence_index
end
