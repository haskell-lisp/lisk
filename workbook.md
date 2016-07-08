# workbook

## Prefix Notation

```
$ ghci
```
```haskell
Prelude> ((+) 1 2)
3
Prelude> ((+) `foldl` 0) [1..6]
21
Prelude> ((sum) [1..6])
21
Prelude> ((==) 1 1)
True
Prelude> ((==) 1 2)
False
Prelude> ((/=) 1 1)
False
Prelude> ((/=) 1 2)
True
Prelude> ((&&) True False)
False
Prelude> ((&&) True True)
True
Prelude> ((||) True False)
True
Prelude> ((succ) 1)
2
Prelude> ((++) [1,2] [3,4])
[1,2,3,4]
Prelude> ((:) 1 [2,3])
[1,2,3]
Prelude> ((head) [1,2,3,4])
1
Prelude> ((tail) [1,2,3,4])
[2,3,4]
Prelude> import Data.List
Prelude Data.List> ((\\) [1,2,3,4] [1,4])
[2,3]
Prelude> (\ x -> ((+) x 1)) 4
5
Prelude> (\ x y -> ((+) x y)) 3 5
8
Prelude> f x = (\ y -> ((+) x y))
Prelude> (f 10) 25
35
Prelude> [1, 2, 3] >>= \x -> [x + 1, x - 1] >>= \y -> return (y * x)
[2,0,6,2,12,6]
Prelude> ((>>=)
           [1, 2, 3]
           (\ x ->
             (>>=)
               [((+) x 1), ((-) x 1)]
               (\ y -> return ((*) y x))))
[2,0,6,2,12,6]
```


## Template Haskell

### Converting Haskell prefix notation to AST

```
$ ghci -XTemplateHaskell
```
```haskell
Prelude> :m + Language.Haskell.TH
```
```haskell
Prelude Language.Haskell.TH> runQ[| 1 + 2 |]
```haskell
InfixE (Just (LitE (IntegerL 1)))
       (VarE GHC.Num.+)
       (Just (LitE (IntegerL 2)))
```
```haskell
Prelude Language.Haskell.TH> runQ[| ((+) 1 2) |]
```
```haskell
AppE (AppE (VarE GHC.Num.+)
           (LitE (IntegerL 1)))
     (LitE (IntegerL 2))
```
```haskell
Prelude Language.Haskell.TH> runQ[| (\ x -> ((+) x 1)) |]
```
```haskell
LamE [VarP x_0] (AppE
                  (AppE
                    (VarE GHC.Num.+)
                    (VarE x_0))
                 (LitE (IntegerL 1)))
```

### Manually Creating AST

```haskell
Prelude Language.Haskell.TH> AppE (AppE (VarE (mkName "+")) (LitE (IntegerL 1))) (LitE (IntegerL 2))
```
```haskell
AppE (AppE (VarE +) (LitE (IntegerL 1))) (LitE (IntegerL 2))
```

Now evaluate that:

```haskell
Prelude Language.Haskell.TH> $( return
  (AppE (AppE (VarE (mkName "+")) (LitE (IntegerL 1))) (LitE (IntegerL 2))) )
```
```
3
```

## Generating Syntax

Using ``Language.Haskell.Exts.Build``:

```haskell
*Main Lib> :m + Language.Haskell.Exts.Build
```
```haskell
Main Lib Language.Haskell.Exts.Build> intE 1
```
```haskell
Lit (Int 1)
```
```haskell
*Main Lib Language.Haskell.Exts.Build> sym "+"
```
```haskell
Symbol "+"
```
```haskell
*Main Lib Language.Haskell.Exts.Build> infixApp (intE 1) (op (sym "+")) (intE 2)
```
```haskell
InfixApp (Lit (Int 1)) 
         (QVarOp (UnQual (Symbol "+"))) 
         (Lit (Int 2))
```


## Tokenizing

Using ``Language.Haskell.Exts.Lexer``:

```haskell
*Main Lib> :m + Language.Haskell.Exts.Lexer
```
```haskell
*Main Lib Language.Haskell.Exts.Lexer> lexTokenStream "+ 1 2"
```
```haskell
ParseOk [Loc {loc = SrcSpan "<unknown>.hs" 1 1 1 2, unLoc = IntTok (1,"1")},
         Loc {loc = SrcSpan "<unknown>.hs" 1 3 1 4, unLoc = VarSym "+"},
         Loc {loc = SrcSpan "<unknown>.hs" 1 5 1 6, unLoc = IntTok (2,"2")}]
```


## Parsing Haskell

Using ``Language.Haskell.Exts.Parser``:

```haskell
*Main Lib> :m + Language.Haskell.Exts.Parser
```
```haskell
*Main Lib Language.Haskell.Exts.Parser> parseExp "1 + 2"
```
```haskell
ParseOk (InfixApp (Lit (Int 1))
                  (QVarOp (UnQual (Symbol "+")))
                  (Lit (Int 2)))
```
```haskell
*Main Lib Language.Haskell.Exts.Parser> parseExp "((+) 1 2)"
```
```haskell
ParseOk (Paren (App
                 (App (Var (UnQual (Symbol "+")))
                      (Lit (Int 1)))
                 (Lit (Int 2))))
```


## Parsing Lisp

### ``atto-lisp``

TBD


## Compiling Haskell

### ``HscMain``

TBD
