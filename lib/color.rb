# frozen_string_literal: true

class String
  def black;          "\e[30m#{self}\e[0m" end
  def red;            "\e[31m#{self}\e[0m" end
  def green;          "\e[32m#{self}\e[0m" end
  def yellow;         "\e[33m#{self}\e[0m" end
  def blue;           "\e[34m#{self}\e[0m" end
  def magenta;        "\e[35m#{self}\e[0m" end
  def cyan;           "\e[36m#{self}\e[0m" end
  def white;          "\e[37m#{self}\e[0m" end

  def bright_black;     "\e[90m#{self}\e[0m" end  # gray
  def bright_red;       "\e[91m#{self}\e[0m" end
  def bright_green;     "\e[92m#{self}\e[0m" end
  def bright_yellow;    "\e[93m#{self}\e[0m" end
  def bright_blue;      "\e[94m#{self}\e[0m" end
  def bright_magenta;   "\e[95m#{self}\e[0m" end
  def bright_cyan;      "\e[96m#{self}\e[0m" end
  def bright_white;     "\e[97m#{self}\e[0m" end
  
  def bg_black;       "\e[40m#{self}\e[0m" end
  def bg_red;         "\e[41m#{self}\e[0m" end
  def bg_green;       "\e[42m#{self}\e[0m" end
  def bg_yellow;      "\e[43m#{self}\e[0m" end
  def bg_blue;        "\e[44m#{self}\e[0m" end
  def bg_magenta;     "\e[45m#{self}\e[0m" end
  def bg_cyan;        "\e[46m#{self}\e[0m" end
  def bg_white;       "\e[47m#{self}\e[0m" end

  def bg_bright_black;   "\e[90m#{self}\e[0m" end  # gray
  def bg_bright_red;     "\e[91m#{self}\e[0m" end
  def bg_bright_green;   "\e[92m#{self}\e[0m" end
  def bg_bright_yellow;  "\e[93m#{self}\e[0m" end
  def bg_bright_blue;    "\e[94m#{self}\e[0m" end
  def bg_bright_magenta; "\e[95m#{self}\e[0m" end
  def bg_bright_cyan;    "\e[96m#{self}\e[0m" end
  def bg_bright_white;   "\e[97m#{self}\e[0m" end
  
  # for color + efect, separate with ;
  # "\e[31;1mBla\e[0m" would be bold red
  def bold;           "\e[1m#{self}\e[22m" end
  def dim;            "\e[2m#{self}\e[23m" end
  def italic;         "\e[3m#{self}\e[23m" end
  def underline;      "\e[4m#{self}\e[24m" end
  def blink;          "\e[5m#{self}\e[25m" end
  def reverse_color;  "\e[7m#{self}\e[27m" end
end
