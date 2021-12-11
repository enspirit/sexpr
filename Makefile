tests:
	bundle exec rake test

package:
	bundle exec rake package

gem.push:
	ls pkg/sexpr-*.gem | xargs gem push
