# Logical-Processor
A program which can process logical propositions of any length consisting of and, or and not operators. 
Insteed of using fixed logical values you can also use strings as variables and replace them by logical values later on.

How do you evaluate such a Proposition:

  *Main> evaluate [("varname1", boolean value1), ("varname2", boolean value2), ...] Proposition 
  
An example of a proposition evaluated with this program:

  *Main> evaluate [("a", True), ("b", False)] (((Not $ Var "a") `And` (Var "b")) `Or` ((Var "a") `And` (Not $ Var "b")))
  *Main> Const True

# What have I learned
  - Declaring types
  - higher-order functions
