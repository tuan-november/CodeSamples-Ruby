
# =======================================================================================
# DataCompression - Ruby Code Samples
# main.rb
#
# Written by Tuan Anh Nguyen - Software Engineer
#                              www.MyAIvisions.com
# CopyRight - Dec 10, 2014
#
# =======================================================================================

require './CharNode.rb'
require './EternalBox.rb'
require './Codec.rb'

input_str = 'We wish you a Merry Chistmas... We wish you a Merry Christmas... And a Happy New Year...'
puts input_str

CodecMgr = CCodec.new
encoded_str = CodecMgr.encodeString input_str
puts encoded_str

decoded_str = CodecMgr.decodeString encoded_str
puts decoded_str

