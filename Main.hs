
------------------------

-- Exercise 1
data Prop  = Const Bool
           | Var   String
           | Prop `And` Prop
           | Prop `Or`  Prop
           | Not   Prop deriving (Show)

------------------------

-- Exercise 2a)
-- CONTRACT
one :: Prop
-- DEFINITION
one = (Const False) `Or` (Const True)

-- Exercise 2b)
-- CONTRACT
two :: Prop
-- DEFINITION
two = (Var "test") `And` (Not (Var "test"))

-- Exercise 2c)
-- CONTRACT
three :: Prop
-- DEFINITION
three = ((Not $ Var "a") `And` (Var "b")) `Or` ((Var "a") `And` (Not $ Var "b"))

------------------------

-- Exercise 3
mapProp :: (Prop -> Prop) -> Prop -> Prop
mapProp f (Var str)   = f (Var str)
mapProp f (Const x)   = f (Const x)
mapProp f (Not x)     = f (Not (mapProp f x))
mapProp f (x `Or`  y) = f ((mapProp f x) `Or` (mapProp f y))
mapProp f (x `And` y) = f ((mapProp f x) `And` (mapProp f y))

------------------------

-- Exercise 4
-- CONTRACT
simplify :: Prop -> Prop

-- PURPOSE
-- simplifies a Proposition by replacing
-- any or, and, or negation involving constants
-- with the resulting value

-- EXAMPLES
-- simplify (Const False `And` True) : Const False
-- simplify (Const True `Or` False)   : Const True
-- DEFINITION
simplify (Const False `And` _) = Const False
simplify (Const True `And` x ) = x
simplify (Const True `Or`  _ ) = Const True
simplify (Const False `Or` x ) = x
simplify (Not (Const False))   = Const True
simplify (Not (Const True))    = Const False
simplify (Var str)             = Var str
simplify x                     = x

-- TESTS

------------------------

-- Exercise 5
-- Contract
replace :: (String, Bool) -> Prop -> Prop

-- PURPOSE
-- Takes a Tuple of a variable name
-- and its corresponding boolean value and a Prop

-- EXAMPLES
-- replace ("test", True) (Var "test") : Const True
-- replace ("abc", False) (Var "abc" `And` Const True) : Const False `And` Const True

-- DEFINITION
replace (name, value) prop = mapProp (helper (name, value)) prop
        where helper (name, value) (Var str) = if str == name then Const value else Var str
              helper (name, value) x         = x
-- TESTS

------------------------

-- Exercise 6
-- CONTRACT
evaluate :: [(String, Bool)] -> Prop -> Prop

-- PURPOSE
-- Takes a list of replacements and a Proposition
-- and returns a simplified equivalent Proposition

-- EXAMPLES
-- evaluate [("test1", True), ("test2", False)] (Var "test1") `And` (Not (Var "test2")) : Const True

-- DEFINITION
evaluate []     prop = mapProp simplify prop
evaluate (r:rs) prop = evaluate rs (replace r prop)
-- TESTS
