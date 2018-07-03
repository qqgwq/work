class Link < ApplicationRecord
  require 'digest/md5'
  include Redis::Objects
  counter :views

  def short_text string
    key = "XuLiang"
    chars = [*'a'..'z',*'0'..'9',*'A'..'Z']
    hex = Digest::MD5.hexdigest(key+string)
    hex_len = hex.length
    sub_hex_len = hex_len/8
    short_str = Array.new(4)
    (0...sub_hex_len).each do |i|
      out_chars = ""
         j = i + 1
         sub_hex = hex[i * 8...j * 8]
         idx = 0x3FFFFFFF & sub_hex.to_i(16)
         (0...6).each do |i|
           index = 0x0000003D & idx
           out_chars += chars[index]
           idx = idx >> 5
         end
       short_str[i] = out_chars
    end
    return short_str
  end
end
