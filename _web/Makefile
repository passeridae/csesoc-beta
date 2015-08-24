all: beta.js beta.min.js

beta.js: beta.coffee
	node node_modules/coffee-script/bin/coffee -c beta.coffee

beta.min.js: beta.js
	uglifyjs beta.js > beta.min.js
