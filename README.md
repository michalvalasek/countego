# CountEgo

Simple example web application written in [Elixir](https://github.com/elixir-lang/elixir)/[Phoenix](https://github.com/phoenixframework/phoenix) which allows user to create live updating counters for public Facebook pages.
  * MongoDB as database via [Mongo.Ecto](https://github.com/michalmuskala/mongodb_ecto)
  * Custom simple authentication module
  * Two different layouts (public and admin)
  * Custom rails-style helpers for the admin UI
  * Client-side dependencies (javascripts, styles) managed via NPM
  * Brunch configured to integrate SCSS, jQuery, 3rd party jQuery plugin and to build separate bundles for public and for admin UI

Do you see something strange/wrong/unidiomatic? That's entirely possible (I'm just beginning with Elixir/Phoenix)! Please let me know in a comment and I'll be super happy to fix/improve it.

To start your Phoenix app:

  * Install dependencies with `mix deps.get`
  * Install Node.js dependencies with `npm install`
  * Create the `config/dev.secret.exs` file and fill in the admin user email and password
  * Seed the database with `mix run priv/repo/seeds.exs`
  * Start Phoenix endpoint with `mix phoenix.server`
  * Log in to the Admin UI and create your first counter by entering PageID of a public FB page.

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.
