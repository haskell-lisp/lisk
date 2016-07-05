# Lisk

This Lisk project is the successor to the
[old project](https://github.com/haskell-lisp/historic-lisk)
started by Chris Done at the end of 2010. It used
[haskell-src-exts](http://hackage.haskell.org/package/haskell-src-exts)’s
AST and pretty printer in order to convert from Lisk to Haskell. Chris has
given his blessing to re-use the name for a new effort :-)


## Goals

100% native compatibility/interop with Haskell (a la Erlang's
[LFE](http://lfe.github.io/)).


## Current Status

Nothing but air. Some planning, some conversation, not much else.


## Wish List

**Command line tools**: ``lisk``, ``liskc``, ``liski``

**Stack config**: examples for compiling Lisk source as well as Lisk+Haskell
mixed source

**Compile-to-Haskell**:

1. Parse `*.lsk` files
1. Convert to Haskell AST
1. Compile in-memory code
1. Save as Haskell object files


## Setting Up a Dev Environment

Dependencies:
 * Haskell
 * Stack

Run:

```
$ stack setup
$ stack build
```
