#!/usr/local/bin/ruby -ws

# strict: stop on first failure
$s ||= false

require 'ruby_to_c'

old_classes = []
ObjectSpace.each_object(Class) do |klass|
  old_classes << klass
end

ARGV.each do |name|
  require name
end

new_classes = []
ObjectSpace.each_object(Class) do |klass|
  new_classes << klass
end

new_classes -= old_classes

new_classes.each do |klass|
  puts RubyToC.translate_all_of(klass, ! $s)
end
