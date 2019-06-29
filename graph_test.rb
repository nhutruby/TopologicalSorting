require_relative 'graph'
require 'test/unit'

class TestUntitled < Test::Unit::TestCase

  # Case 1- if input == ""
  # It should return an empty sequence.
  def test_returns_empty_string_if_no_jobs
    graph = Graph.new("")
    assert graph.topological_sort().empty?
  end

  #  Case 2- if input == "a =>"
  # It should return a single job sequence.
  def test_returns_single_job_string_if_contains_one_job
    graph = Graph.new("a =>")
    assert_equal ['a'], graph.topological_sort
  end

  # Case 3- if input == "a =>
  #                      b =>
  #                      c =>"
  # It should return a secuence that contains all jobs in no particular order.
  def test_return_multiple_idenpendent_jobs_in_any_order
    graph = Graph.new("a =>
               b =>
               c =>")
    graph.topological_sort.each do |job|
      assert (%w[a b c].include?(job))
    end
  end

  # Case 4- if input == "a =>
  #                      b => c
  #                      c =>"
  # It should return a secuence that contains all jobs and c will be placed before b.
  def test_retuns_job_in_a_specific_order_if_only_one_has_dependency
    graph = Graph.new("a =>
               b => c
               c =>")
    assert_equal ['a', 'c', 'b'], graph.topological_sort
  end

  # Case 5- if input == "a =>
  #                      b => c
  #                      c => f
  #                      d => a
  #                      e => b
  #                      f =>"
  # It should return a secuence that contains all jobs and where b will be placed before c,
  # f before c, a before d, b before e
  def test_retuns_ordered_jobs_considering_all_dependecies
    graph = Graph.new("a =>
               b => c
               c => f
               d => a
               e => b
               f =>")
    assert_equal ['a', 'd', 'f', 'c', 'b', 'e'], graph.topological_sort
  end

  # Case 6- if input == "a =>
  #                      b =>
  #                      c => c"
  # It should raise an error stating that jobs can’t depend on themselves.
  def test_raise_error_if_contains_self_dependent_jobs
    assert_raises(SelfDependencyError) do
      Graph.new("a =>
               b =>
               c => c")
    end
  end

  # Case 7- if input == "a =>
  #                      b => c
  #                      c => f
  #                      d => a
  #                      e =>
  #                      f => b"
  # It should raise an error stating that jobs can’t have circular dependencies.
  def test_raise_error_if_contains_circular_dependency
    graph = Graph.new("a =>
               b => c
               c => f
               d => a
               e =>
               f => b")
    assert_raises(CircularDependencyError) do
      graph.topological_sort
    end
  end
end
