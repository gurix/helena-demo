[![Build Status](https://travis-ci.org/gurix/helena-demo.svg?branch=master)](https://travis-ci.org/gurix/helena-demo)
[![Code Climate](https://codeclimate.com/github/gurix/helena-demo.png)](https://codeclimate.com/github/gurix/helena-demo)
[![Coverage Status](https://coveralls.io/repos/gurix/helena-demo/badge.png?branch=master)](https://coveralls.io/r/gurix/helena-demo?branch=master)

# Helena-Demo
This is a little demo application implementing http://github.com/gurix/helena.

Helena is an online survey/test framework designed for agile survey/test development, longitudinal studies and instant feedback.

# Installation

```
git clone https://github.com/gurix/helena-demo.git
cd helena-demo
bundle install
rake db:seed
rails s
```

Go to http://127.0.0.1:3000 and log in via twitter or with the user `hans.muster@somedomain.tld` and the password `test123`.
