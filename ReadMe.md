ForkThis
========

Installation
------------

```sh
gem install rails -v 3.2.11
rails _3.2.11_ new my_forking_app --skip-active-record
rm public/index.html
```

Add to `Gemfile`:

```ruby
gem 'fork_this', :git => 'git://github.com/harlantwood/fork_this.git'
gem 'polystore', :git => 'git://github.com/harlantwood/polystore.git'
```

Then:

```sh
bundle install
```

Add to `config/routes.rb`:

```ruby
mount ForkThis::Engine => "/"
```

Create a new file `.env` in the application root to store your environment variables for
development:

```sh
cat > .env
POLYSTORES=file,github
POLYSTORE_GITHUB_USER=xxxxx
POLYSTORE_GITHUB_PASS=yyyyy
BASE_DOMAIN=lvh.me       # for development
BASE_DOMAIN=example.com  # for production, change to your actual domain
DOMAIN_CONNECTOR=via
COLLECTION_LABEL=Page
SITE_NAME=My Forking Site
^D
```

And finally: 

```sh
rails server
```

