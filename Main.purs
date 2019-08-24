module Main where

import Prim.Boolean (False, True, kind Boolean)

-- normal values

-- start with a data type, of many constructors
data Frukt
  = Banan
  | Raejuusto
  | Snus

-- then a function of that data type to a boolean value
isEdible :: Frukt -> Boolean

-- match on the cases of the data type constructors
isEdible frukt = case frukt of
  Banan -> true
  Raejuusto -> false
  Snus -> false

-- now we've reviewed regular old values and types, so now it's time for types and kinds

-- Types!

-- first, define our kind, which are types but one step up the ladder
foreign import kind Fruit -- awkward syntax, ignore "foreign import"

-- then our types of that kind, like constructors, but one step up
foreign import data Banana :: Fruit
foreign import data CottageCheese :: Fruit
foreign import data Tobacco :: Fruit

-- then declare our type class, like a function, but one step up
class IsEdible (fruit :: Fruit) (yes :: Boolean) -- Boolean kind from Prim modules
  | fruit -> yes -- we match on `fruit` to have `yes` determined, so fundep

-- then match our cases
instance isEdibleBanana :: IsEdible Banana True -- True type of Boolean kind from Prim modules
instance isEdibleCottageCheese :: IsEdible CottageCheese False -- False type of Boolean kind from Prim modules
instance isEdibleTobacco :: IsEdible Tobacco False

--- and so, how about a list?
data List a = Cons a (List a) | Nil
getEnd :: forall a. List a -> List a
getEnd xs = case xs of
  Cons a tail -> getEnd tail
  Nil -> Nil

foreign import kind List
foreign import data Cons :: Type -> List -> List
foreign import data Nil :: List

class GetEnd (xs :: List) (end :: List) | xs -> end
instance getEndCons :: GetEnd tail end => GetEnd (Cons ty tail) end
instance getEndNil :: GetEnd Nil Nil
