-- | The general naming scheme for functions and types in this module is as
-- | follows:
-- |
-- | * `STFn{N}` means, an uncurried function which accepts N arguments and
-- |   performs some effects. The first N arguments are the actual function's
-- |   argument. The last type argument is the return type.
-- | * `runSTFn{N}` takes an `STFn` of N arguments, and converts it into
-- |   the normal PureScript form: a curried function which returns an ST
-- |   action.
-- | * `mkSTFn{N}` is the inverse of `runSTFn{N}`. It can be useful for
-- |   callbacks.
-- |

module Control.Monad.ST.Uncurried where

import Data.Monoid (class Monoid, class Semigroup, mempty, (<>))
import Control.Monad.ST.Internal (ST, kind Region)

foreign import data STFn1 :: Region -> Type -> Type -> Type
foreign import data STFn2 :: Region -> Type -> Type -> Type -> Type
foreign import data STFn3 :: Region -> Type -> Type -> Type -> Type -> Type
foreign import data STFn4 :: Region -> Type -> Type -> Type -> Type -> Type -> Type
foreign import data STFn5 :: Region -> Type -> Type -> Type -> Type -> Type -> Type -> Type
foreign import data STFn6 :: Region -> Type -> Type -> Type -> Type -> Type -> Type -> Type -> Type
foreign import data STFn7 :: Region -> Type -> Type -> Type -> Type -> Type -> Type -> Type -> Type -> Type
foreign import data STFn8 :: Region -> Type -> Type -> Type -> Type -> Type -> Type -> Type -> Type -> Type -> Type
foreign import data STFn9 :: Region -> Type -> Type -> Type -> Type -> Type -> Type -> Type -> Type -> Type -> Type -> Type
foreign import data STFn10 :: Region -> Type -> Type -> Type -> Type -> Type -> Type -> Type -> Type -> Type -> Type -> Type -> Type

foreign import mkSTFn1 :: forall region a r.
  (a -> ST region r) -> STFn1 region a r
foreign import mkSTFn2 :: forall region a b r.
  (a -> b -> ST region r) -> STFn2 region a b r
foreign import mkSTFn3 :: forall region a b c r.
  (a -> b -> c -> ST region r) -> STFn3 region a b c r
foreign import mkSTFn4 :: forall region a b c d r.
  (a -> b -> c -> d -> ST region r) -> STFn4 region a b c d r
foreign import mkSTFn5 :: forall region a b c d e r.
  (a -> b -> c -> d -> e -> ST region r) -> STFn5 region a b c d e r
foreign import mkSTFn6 :: forall region a b c d e f r.
  (a -> b -> c -> d -> e -> f -> ST region r) -> STFn6 region a b c d e f r
foreign import mkSTFn7 :: forall region a b c d e f g r.
  (a -> b -> c -> d -> e -> f -> g -> ST region r) -> STFn7 region a b c d e f g r
foreign import mkSTFn8 :: forall region a b c d e f g h r.
  (a -> b -> c -> d -> e -> f -> g -> h -> ST region r) -> STFn8 region a b c d e f g h r
foreign import mkSTFn9 :: forall region a b c d e f g h i r.
  (a -> b -> c -> d -> e -> f -> g -> h -> i -> ST region r) -> STFn9 region a b c d e f g h i r
foreign import mkSTFn10 :: forall region a b c d e f g h i j r.
  (a -> b -> c -> d -> e -> f -> g -> h -> i -> j -> ST region r) -> STFn10 region a b c d e f g h i j r

foreign import runSTFn1 :: forall region a r.
  STFn1 region a r -> a -> ST region r
foreign import runSTFn2 :: forall region a b r.
  STFn2 region a b r -> a -> b -> ST region r
foreign import runSTFn3 :: forall region a b c r.
  STFn3 region a b c r -> a -> b -> c -> ST region r
foreign import runSTFn4 :: forall region a b c d r.
  STFn4 region a b c d r -> a -> b -> c -> d -> ST region r
foreign import runSTFn5 :: forall region a b c d e r.
  STFn5 region a b c d e r -> a -> b -> c -> d -> e -> ST region r
foreign import runSTFn6 :: forall region a b c d e f r.
  STFn6 region a b c d e f r -> a -> b -> c -> d -> e -> f -> ST region r
foreign import runSTFn7 :: forall region a b c d e f g r.
  STFn7 region a b c d e f g r -> a -> b -> c -> d -> e -> f -> g -> ST region r
foreign import runSTFn8 :: forall region a b c d e f g h r.
  STFn8 region a b c d e f g h r -> a -> b -> c -> d -> e -> f -> g -> h -> ST region r
foreign import runSTFn9 :: forall region a b c d e f g h i r.
  STFn9 region a b c d e f g h i r -> a -> b -> c -> d -> e -> f -> g -> h -> i -> ST region r
foreign import runSTFn10 :: forall region a b c d e f g h i j r.
  STFn10 region a b c d e f g h i j r -> a -> b -> c -> d -> e -> f -> g -> h -> i -> j -> ST region r

-- The reason these are written eta-expanded instead of as:
-- ```
-- append f1 f2 = mkSTFnN $ runSTFnN f1 <> runSTFnN f2
-- ```
-- is to help the compiler recognize that it can emit uncurried
-- JS functions (which are more efficient), when an appended
-- STFn is applied to all its arguments

instance semigroupSTFn1 :: Semigroup r => Semigroup (STFn1 region a r) where
  append f1 f2 = mkSTFn1 \a -> runSTFn1 f1 a <> runSTFn1 f2 a

instance semigroupSTFn2 :: Semigroup r => Semigroup (STFn2 region a b r) where
  append f1 f2 = mkSTFn2 \a b -> runSTFn2 f1 a b <> runSTFn2 f2 a b

instance semigroupSTFn3 :: Semigroup r => Semigroup (STFn3 region a b c r) where
  append f1 f2 = mkSTFn3 \a b c -> runSTFn3 f1 a b c <> runSTFn3 f2 a b c

instance semigroupSTFn4 :: Semigroup r => Semigroup (STFn4 region a b c d r) where
  append f1 f2 = mkSTFn4 \a b c d -> runSTFn4 f1 a b c d <> runSTFn4 f2 a b c d

instance semigroupSTFn5 :: Semigroup r => Semigroup (STFn5 region a b c d e r) where
  append f1 f2 = mkSTFn5 \a b c d e -> runSTFn5 f1 a b c d e <> runSTFn5 f2 a b c d e

instance semigroupSTFn6 :: Semigroup r => Semigroup (STFn6 region a b c d e f r) where
  append f1 f2 = mkSTFn6 \a b c d e f -> runSTFn6 f1 a b c d e f <> runSTFn6 f2 a b c d e f

instance semigroupSTFn7 :: Semigroup r => Semigroup (STFn7 region a b c d e f g r) where
  append f1 f2 = mkSTFn7 \a b c d e f g -> runSTFn7 f1 a b c d e f g <> runSTFn7 f2 a b c d e f g

instance semigroupSTFn8 :: Semigroup r => Semigroup (STFn8 region a b c d e f g h r) where
  append f1 f2 = mkSTFn8 \a b c d e f g h -> runSTFn8 f1 a b c d e f g h <> runSTFn8 f2 a b c d e f g h

instance semigroupSTFn9 :: Semigroup r => Semigroup (STFn9 region a b c d e f g h i r) where
  append f1 f2 = mkSTFn9 \a b c d e f g h i -> runSTFn9 f1 a b c d e f g h i <> runSTFn9 f2 a b c d e f g h i

instance semigroupSTFn10 :: Semigroup r => Semigroup (STFn10 region a b c d e f g h i j r) where
  append f1 f2 = mkSTFn10 \a b c d e f g h i j -> runSTFn10 f1 a b c d e f g h i j <> runSTFn10 f2 a b c d e f g h i j

instance monoidSTFn1 :: Monoid r => Monoid (STFn1 region a r) where
  mempty = mkSTFn1 \_ -> mempty

instance monoidSTFn2 :: Monoid r => Monoid (STFn2 region a b r) where
  mempty = mkSTFn2 \_ _ -> mempty

instance monoidSTFn3 :: Monoid r => Monoid (STFn3 region a b c r) where
  mempty = mkSTFn3 \_ _ _ -> mempty

instance monoidSTFn4 :: Monoid r => Monoid (STFn4 region a b c d r) where
  mempty = mkSTFn4 \_ _ _ _ -> mempty

instance monoidSTFn5 :: Monoid r => Monoid (STFn5 region a b c d e r) where
  mempty = mkSTFn5 \_ _ _ _ _ -> mempty

instance monoidSTFn6 :: Monoid r => Monoid (STFn6 region a b c d e f r) where
  mempty = mkSTFn6 \_ _ _ _ _ _ -> mempty

instance monoidSTFn7 :: Monoid r => Monoid (STFn7 region a b c d e f g r) where
  mempty = mkSTFn7 \_ _ _ _ _ _ _ -> mempty

instance monoidSTFn8 :: Monoid r => Monoid (STFn8 region a b c d e f g h r) where
  mempty = mkSTFn8 \_ _ _ _ _ _ _ _ -> mempty

instance monoidSTFn9 :: Monoid r => Monoid (STFn9 region a b c d e f g h i r) where
  mempty = mkSTFn9 \_ _ _ _ _ _ _ _ _ -> mempty

instance monoidSTFn10 :: Monoid r => Monoid (STFn10 region a b c d e f g h i j r) where
  mempty = mkSTFn10 \_ _ _ _ _ _ _ _ _ _ -> mempty
