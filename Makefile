
cli=./compiler/cli.js
riot=test/lib/node-riot.js


bench:
	@ node test 100

test: node-riot
	@ node test

test-compiler:
	@ node compiler/test

# Node version of Riot for testing
node-riot:
	@echo "\n/* auto-generated! */\n\nwindow = {}" > $(riot)
	@cat lib/* >> $(riot)
	@cat test/lib/nodefy.js >> $(riot)


# browser playground
browser: riot
	@ $(cli) test/browser/test.htm


# compile demo application
demo: riot
	@ $(cli) demo/todo.htm


# create riot.js
riot:
	@echo "!function() {" > riot.js
	@cat lib/* >> riot.js
	@echo "}()" >> riot.js
	@echo wrote riot.js


min: riot
	uglifyjs riot.js --mangle > riot.min.js


.PHONY: test demo