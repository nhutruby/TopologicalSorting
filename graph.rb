require 'set'
class Graph
  attr_accessor :graph, :v, :in_degree

  def initialize(input = '')
    # Dictionary containing adjacency Set
    @graph = Hash.new{ |h, k| h[k] = Set.new}

    # Create a vector to store indegrees of all
    # vertices. Initialize all indegrees as 0.
    @in_degree = Hash.new(0)

    # A Number of vertices
    @v = 0
    input.split("\n").each do |line|
      from, to = line.split(/ => ?/).map { |line| line.strip }
      add_edge(from, to)
    end
  end

  # Function to add an edge to graph
  def add_edge(from, to)
    raise SelfDependencyError if from == to
    @graph[from].add(to) if to != nil
    @in_degree[from] = 0
    @in_degree[to] = 0 if to != nil
    @v = @in_degree.size
  end

  # The function to do Topological Sort for jobs
  def topological_sort
    # Traverse adjacency lists to fill indegrees of
    # vertices.  This step takes O(V+E) time
    @graph.each {|i,s|
      s.each {|j|
        @in_degree[j] += 1
      }
    }

    # Create an queue and enqueue all vertices with
    # indegree 0
    queue = []
    @in_degree.each {|k,v|
      queue.push(k) if v == 0
    }

    # Initialize count of visited vertices
    cnt = 0

    # Create a vector to store result (A topological
    # ordering of the vertices)
    top_order = []

    # One by one dequeue vertices from queue and enqueue
    # adjacents if indegree of adjacent becomes 0
    until queue.empty? do
      # Extract front of queue (or perform dequeue)
      # and add it to topological order
      u = queue.pop
      top_order.push(u)

      # Iterate through all neighbouring nodes
      # of dequeued node u and decrease their in-degree
      # by 1
      @graph[u].each {|i|
        @in_degree[i] -= 1

        # If in-degree becomes zero, add it to queue
        queue.push(i) if @in_degree[i] == 0
      }
      cnt += 1
    end
    # Check if there was a cycle
    raise CircularDependencyError if cnt != @v

    top_order.reverse!
    top_order.empty? ? '' : top_order
  end
end
class SelfDependencyError < StandardError; end
class CircularDependencyError < StandardError; end
