# Superclass DoubleSet for managing two sets: X and Y
# noinspection RubyNilAnalysis
class DoubleSet
  def initialize
    @set_x = nil
    @set_y = nil
  end

  # Set first set = BST
  def set_x(set_elements)
    @set_x = BranchingSet.new(set_elements)
  end

  # Set second set = ArrayedSet
  def set_y(set_elements)
    @set_y = ArrayedSet.new(set_elements)
  end

  # Apply a lambda function to each element of X
  def apply_lambda(lambda_function)
    @set_x.apply_lambda(lambda_function)
  end

  # Add an element to set X
  def add_to_x(set_element)
    @set_x.add(set_element)
  end

  # Union of both sets
  def union
    @set_x.union(@set_y)
  end

  # Intersection of both sets
  def intersection
    @set_x.intersection(@set_y)
  end

  # Swap X, Y with each other
  def swap
    @set_x, @set_y = @set_y, @set_x
  end

  # Copy X to Y
  def copy_x_to_y
    @set_y = @set_x.clone
  end

  # Print elements of both sets
  def list_sets
    puts "Set X => #{@set_x}"
    puts "Set Y => #{@set_y}"
  end

  # Print both sets and exit
  def quit
    list_sets
    puts "Exit!"
    exit
  end
end

# Subclass ArrayedSet
class ArrayedSet < DoubleSet

  # When initialized, make sure no duplicate elements are added
  def initialize(set_elements = [])
    @set_elements = set_elements.uniq.sort
  end

  # Add element to the set - it should be unique
  def add(set_element)
    @set_elements << set_element unless @set_elements.include?(set_element)
    @set_elements.sort!
  end

  def apply_lambda(operation)
    @set_elements.map! { |set_element| operation.call(set_element) }
  end

  def union(other_set)
    other_set.set_elements.each { |set_element| add(set_element) }
  end

  def intersection(other_set)
    @set_elements &= other_set.set_elements
  end

  def clone
    ArrayedSet.new(@set_elements.clone)
  end

  def set_elements
    @set_elements
  end

  def to_s
    @set_elements.join(', ')
  end
end

# Subclass BranchingSet
class BranchingSet < DoubleSet
  attr_accessor :root

  def initialize(set_elements = [])
    @root = nil
    set_elements.each { |set_element|
      add(set_element)
    }
  end

  # Add element to set
  def add(set_element)
    @root = insert(@root, set_element)
  end

  # Apply lambda function
  def apply_lambda(lambda_function)
    traverse_and_apply(@root, lambda_function)
  end

  def union(other_set)
    other_set.set_elements.each { |set_element|
      add(set_element)
    }
  end

  def intersection(other_set)
    other_set_elements = other_set.set_elements
    new_set_elements = []
    inorder.each { |set_element|
      new_set_elements << set_element if other_set_elements.include?(set_element)
    }
    @root = nil
    new_set_elements.each { |set_element| add(set_element) }
  end

  def clone
    cloned = BranchingSet.new
    inorder.each { |set_element|
      cloned.add(set_element)
    }
    cloned
  end

  def set_elements
    inorder
  end

  # Inorder
  def inorder
    inorder_traversal(@root)
  end

  def to_s
    inorder.join(', ')
  end

  # Insert node into the BST - recursive calling
  def insert(node, set_element)
    return Node.new(set_element) if node.nil?
    if set_element < node.value
      node.left = insert(node.left, set_element)
    elsif set_element > node.value
      node.right = insert(node.right, set_element)
    end
    node
  end

  # Inorder traversal
  def inorder_traversal(node)
    return [] if node.nil?
    inorder_traversal(node.left) + [node.value] + inorder_traversal(node.right)
  end

  # Apply operation to each node
  def traverse_and_apply(node, operation)
    return if node.nil?
    node.value = operation.call(node.value)
    traverse_and_apply(node.left, operation)
    traverse_and_apply(node.right, operation)
  end
end

# Node for each node in BST
class Node
  attr_accessor :value, :left, :right

  def initialize(value)
    @value = value
    @left = nil
    @right = nil
  end
end

# Set Calculator - Main program
def run_set_calculator
  # new DoubleSet object
  calc = DoubleSet.new
  puts "Set X will always be a BST and Set Y will be an ArrayedSet - as given in mp1 description!"
  loop do
    # Get input and process accordingly
    print "> "
    input = gets.chomp.split(' ', 2)
    command = input[0]
    args = input[1]

    if command == 'X'
      elements = args.split(',').map(&:to_i)
      calc.set_x(elements)
      puts "Set X (BST): #{calc.instance_variable_get(:@set_x)}"
    elsif command == 'Y'
      elements = args.split(',').map(&:to_i)
      calc.set_y(elements)
      puts "Set Y (Array): #{calc.instance_variable_get(:@set_y)}"
    elsif command == 'm'
      operation = eval(args)
      calc.apply_lambda(operation)
      puts "Set X after applying lambda function: #{calc.instance_variable_get(:@set_x)}"
    elsif command == 'a'
      value = args.to_i
      calc.add_to_x(value)
      puts "Set X after adding #{value}: #{calc.instance_variable_get(:@set_x)}"
    elsif command == 'u'
      calc.union
      puts "Set X union Y: #{calc.instance_variable_get(:@set_x)}"
    elsif command == 'i'
      calc.intersection
      puts "Set X intersection Y: #{calc.instance_variable_get(:@set_x)}"
    elsif command == 'x'
      calc.swap
      puts "Swapped! Set X: #{calc.instance_variable_get(:@set_x)}, Set Y: #{calc.instance_variable_get(:@set_y)}"
    elsif command == 'l'
      calc.list_sets
    elsif command == 'c'
      calc.copy_x_to_y
      puts "Set Y after copying from X: #{calc.instance_variable_get(:@set_y)}"
    elsif command == 'q'
      calc.quit
    else
      puts "Unknown command"
    end
  end
end

# Done!
run_set_calculator