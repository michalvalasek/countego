#!/bin/sh

echo "CountEgo setup"
echo "***"
read -p "Enter admin user's email: " admin_email
read -p "Enter admin user's password: " admin_pass

echo "Creating the dev config file..."
cp config/dev.secret.exs.template config/dev.secret.exs
sed -i '' "s/EMAIL/$admin_email/g; s/PASSWORD/$admin_pass/g" config/dev.secret.exs
echo "***"

mix deps.get # install elixir app dependencies
npm install # install the front dependencies (styles, javascripts)

echo "Creating the admin user..."
mix run priv/repo/seeds.exs # run the seed file (create the admin user)

echo "***"
echo "You can now run the app with: mix phoenix.server"
