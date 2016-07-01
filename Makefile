

# riot support
SOURCES=$(shell find src -type f -iname '*.tag')
OBJECTS=$(foreach x, $(basename $(SOURCES)), .tmp/$(x).js)

all: .gb src/www/tags.js

# gb does incremental compile anyway, so run it every time
.gb:
	gb build

# Concatenate all the tags together
src/www/tags.js: $(OBJECTS)
	cat $(OBJECTS) > $@

.tmp/%.js: %.tag
	riot $^ $@

# static web server for testing
testserve: src/www/tags.js .gb
	./bin/staticsrv

clean:
	rm -rf .tmp
	rm -rf pkg
	rm -rf src/www/tags.js
	rm -rf bin
