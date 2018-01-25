require_relative 'line'

class CommentLine < Line
  PATTERN = /^\s*#/
end
