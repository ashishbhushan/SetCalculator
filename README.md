# Set Calculator in Ruby

### This project implements a Set Calculator for performing fundamental set operations using Ruby, as part of the coursework for CS 474: Object-Oriented Programming Languages and Environments at the University of Illinois at Chicago.

## Features
### The Set Calculator provides two implementations for sets:

1. Array-Based Representation (ArrayedSet): Uses Ruby's built-in Array class and maintains a sorted order.
2. Tree-Based Representation (BranchingSet): Implements a Binary Search Tree (BST) from scratch.

## Key Functionalities
**Set Initialization:** Initialize sets X and Y as either arrays or BSTs with user-provided numeric values.

**Lambda Transformations:** Apply Ruby lambda expressions to transform elements of a set.

**Set Operations:**

- Union (u): Merge X and Y.

- Intersection (i): Find common elements between X and Y.

- Add Element (a): Add a single number to X.

**Set Swapping (x):** Exchange the content of X and Y without changing their implementation type.

**Copy (c):** Clone the content of X into Y, creating independent copies of data.

**Display (l):** Display the contents of both sets in an ordered manner.

**Quit (q):** Exit the calculator, printing the final content of X and Y.

## Constraints

Supports only numeric values.

Ensures no duplicate elements within a set.

Uses semantic equivalence for element comparison.

## Design Highlights

**Object-Oriented Design:** Implements a superclass DoubleSet and subclasses ArrayedSet and BranchingSet for modularity and code reuse.

**BST Implementation:** Follows standard BST rules, with in-order traversal for displaying elements.

**User Interaction:** Operates in a continuous command loop for seamless interaction.

## How to Run

- Clone the repository.

- Run the SetCalculator.rb script.

- Enter commands as per the specification to interact with the calculator.