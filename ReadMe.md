ForkThis
========

Crawling sites
--------------

Crawling saves a list of links (which may or may not yet have been crawled):

`en.wikipedia.org/meta/links.json`:

```json
{
  'http://en.wikipedia.org/wiki/Physics': [
    {
      'http://en.wikipedia.org/wiki/Academic_discipline' => { depth: 1 },
      'http://www.scholarpedia.org/article/Encyclopedia_of_physics' => { depth: 1 }
    }
  ]
]
```

And also a list of urls which have been crawled, with a last crawl timestamp:

`en.wikipedia.org/meta/visited_links.json`:

```json
{
  'http://en.wikipedia.org/wiki/Academic_discipline': { visited: '2013-03-04T10:39:22+00:00' }  /* DateTime.now.utc.iso8601 */
}
```

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

Running a Server
----------------

```sh
rails server
```

