#!/usr/local/bin/ruby -w

require 'test/unit'
require 'rewriter'

class TestRewriter < Test::Unit::TestCase

  def setup
    @rewrite = Rewriter.new
  end

  def test_case
    input = [:case,
      [:lvar, "var"],
      [:when, [:array, [:lit, 1]], [:str, "1"]],
      [:when, [:array, [:lit, 2], [:lit, 3]], [:str, "2, 3"]],
      [:when, [:array, [:lit, 4]], [:str, "4"]],
      [:str, "else"]]

    expected = [:if,
      [:call, [:lvar, "var"], "==", [:array, [:lit, 1]]],
      [:str, "1"],
      [:if,
        [:or,
          [:call, [:lvar, "var"], "==", [:array, [:lit, 2]]],
          [:call, [:lvar, "var"], "==", [:array, [:lit, 3]]]],
        [:str, "2, 3"],
        [:if,
          [:call, [:lvar, "var"], "==", [:array, [:lit, 4]]],
          [:str, "4"],
          [:str, "else"]]]]

    assert_equal expected, @rewrite.process(input)
  end
end
