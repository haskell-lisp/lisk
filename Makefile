all:
	stack setup
	stack build

push-all:
	git push local --all
	##git push origin --all
	git push gitlab --all

repl:
	stack ghci --ghci-options=-XTemplateHaskell
