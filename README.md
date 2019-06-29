# Using Kahn’s algorithm for Topological Sorting

Algorithm:
Steps involved in finding the topological ordering of a directed acyclic graph (DAG):

Step-1: Compute in-degree (number of incoming edges) for each of the vertex present in the DAG and initialize the count of visited nodes as 0.

Step-2: Pick all the vertices with in-degree as 0 and add them into a queue (Enqueue operation)

Step-3: Remove a vertex from the queue (Dequeue operation), add the vertex to the result and then.

Increment count of visited nodes by 1.
Decrease in-degree by 1 for all its neighboring nodes.
If in-degree of a neighboring nodes is reduced to zero, then add it to the queue.

Step 5: Repeat Step 3 until the queue is empty.

Step 5: If count of visited nodes is not equal to the number of nodes in the graph then the topological sort is not possible for the given graph.

Step 6: reverse the result

Time Complexity: The outer for loop will be executed V number of times and the inner for loop will be executed E number of times, Thus overall time complexity is O(V+E).

The overall time complexity of the algorithm is O(V+E)

Reference:
https://en.wikipedia.org/wiki/Topological_sorting#Kahn.27s_algorithm

https://www.geeksforgeeks.org/topological-sorting-indegree-based-solution/