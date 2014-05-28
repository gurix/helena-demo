[![Build Status](https://travis-ci.org/gurix/helena-demo.svg?branch=master)](https://travis-ci.org/gurix/helena-demo)

# Helena-Demo
This is a little demo application implementing http://github.com/gurix/helena.

Helena is an online survey/test framework designed for agile survey/test development, longitudinal studies and instant feedback.

# Installation

```sh
git clone https://github.com/gurix/helena-demo.git
cd helena-demo
bundle install
rake db:seed
rails s
```

Go to http://127.0.0.1:3000 and log in via twitter or with the user `hans.muster@somedomain.tld` and the password `test123`.
