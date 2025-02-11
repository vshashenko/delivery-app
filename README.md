## What it is
A full-stack toy demo webapp for a delivery business.

Features:
- List deliveries
- Filter deliveries using UI fields
- Filter deliveries using natural language (backed by OpenAI gpt-4o-mini)
- Create a new delivery
- Client and server side validation
- Responsive UI

![Example](index-page-demo.png)

## How to use it

Make sure you have this preinstalled.

```
# Ruby 3.3 or above
> ruby --version
ruby 3.3.6
```

```
# Rails 8.0 or above
> rails --version
Rails 8.0.1
```

If not, follow the [official installation guide]( https://guides.rubyonrails.org/install_ruby_on_rails.html).

```
# Make sure you are in the app's root directory
> cd delivery-app
```

Generate an API key on the OpenAI web site.
Put your key into `.env` file in the root of `delivery-app`. Like this:
```
OPENAI_API_KEY=<your_key>
```

Start the server.
```
> RAILS_ENV=development bin/rails db:reset
>
> RAILS_ENV=development bin/rails server
>
# Watch the output to see the server has started up
```

In your browser, open http://localhost:3000

&#9432; If gpt queries don't work, look for an error message in the Rails server output in the terminal.
