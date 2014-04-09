SpreeBitcoin
============

Spree Extension enabling Coinbase as a payment method.  Plans to add BitPay as well (pull requests welcome).

**WARNING: This is still a work in progress & should be tested before Production use.** For a more tested and supported solution, see the official [Spree Coinbase Plugin](https://github.com/coinbase/coinbase-spree).

Installation
------------

Add spree_bitcoin to your Gemfile:

```ruby
gem 'spree_bitcoin', github: 'jdutil/spree_bitcoin'
```

Bundle your dependencies and run the installation generator:

```shell
bundle
bundle exec rails g spree_bitcoin:install
```

Testing
-------

Be sure to bundle your dependencies and then create a dummy test app for the specs to run against.

```shell
bundle
bundle exec rake test_app
bundle exec rspec spec
```

When testing your applications integration with this extension you may use it's factories.
Simply add this require statement to your spec_helper:

```ruby
require 'spree_bitcoin/factories'
```


Contributing
------------

In the spirit of [free software](http://www.fsf.org/licensing/essays/free-sw.html), **everyone** is encouraged to help improve this project.

Here are some ways *you* can contribute:

* by using prerelease versions
* by reporting [bugs](https://github.com/jdutil/spree_bitcoin/issues)
* by suggesting new features
* by [translating to a new language](https://github.com/jdutil/spree_bitcoin/tree/master/config/locales)
* by writing or editing documentation
* by writing specifications
* by writing code (*no patch is too small*: fix typos, add comments, clean up inconsistent whitespace)
* by refactoring code
* by resolving [issues](https://github.com/jdutil/spree_bitcoin/issues)
* by reviewing patches


Donating
--------

Bitcoin donations may be sent to: 1NEjbUJxad2eMcStJCBSuLkrkTSkC4Q5PP

Copyright (c) 2013 Jeff Dutil, released under the [New BSD License](https://github.com/jdutil/spree_bitcoin/tree/master/LICENSE).
