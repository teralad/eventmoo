# Eventmoo

This is an event service used to manage events and its bookings

## Getting Started

To get started with running this locally, you'll need the following -

```
mysql
rbenv/asdf/rvm
yarn
```

### Prerequisites

If you haven't already installed a version manager, you should look at installing rbenv/rvm/asdf. Once you're
done installing one, you should install ruby `2.5.3`.

You will also have to install `mysql`.

### Installing

The following commands are to be run in the root of the project to get started with installing relevant dependecies.

```
$ gem install bundler
$ bundle install
$ yarn install
```

To initialize the database, run

```
$ bundle exec rails db:create db:migrate
```
To populate the database, run

```
$ bundle exec rails db:seed
```

To start the server, please run

```
$ bundle exec rails s
```

## Running the tests

Run the tests using

```
$ bundle exec rake test
```

## Assumptions

- The user will provide country ISO when he is creating an account.
- Mobile numbers can be used in phone field with or without country code.
- Fixed line phone number can be used only when the entire country code is provided before the fixed line number.
- Anything followed after 'X' in phone number is ignored along with 'X'.
- Event is not owned by any user in the platform.
- Moderation for events is not required.
- If event is not valid that event is skipped from creation.
- Event is invalid if :
  - End date is before the start date
  - Start date is not present

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
