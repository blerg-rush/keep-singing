# "Keep Singing!"

A karaoke app to make hosting group karaoke nights easy.

Current features include:
* Importing individual video data from YouTube
* Background-importing entire YouTube channels
* Embedded video playback
* Database searching

Some of the planned features (see [Issues](https://github.com/TheWillGabriel/keep-singing/labels/enhancement) tab):
* User accounts
  * Favourites lists
  * Sortable song queues
  * OAuth 2.0 authorization for user-level YouTube API calls
* "Party" Sessions
  * Mobile-friendly "Host" control panel to set turn order and manage queues
  * Mobile-friendly "Guest" control panel to manage personal song queue
  * Optional guest login to link session with persistent user account
* Channel updates
  * Scheduled scraping of existing channels
  * Sheduled resuming of paused jobs
* YouTube search
  * Optional search for embeddable videos not already in system
  * Optional importing of high-quality finds

## Local setup

1. Clone the repository to your machine

```bash
git clone git@github.com:TheWillGabriel/keep-singing.git
```

2. Install gem dependencies

```bash
bundle install
```

3. Update Yarn packages

```bash
yarn install --check-files
```

4. Install Postgres
5. Edit config/database.yml to connect to the database
6. Create, migrate, and seed your database

```bash
rails db:create db:migrate db:seed
```

7. Create a .env file in the root directory (see .env.example) and copy your [YouTube API key](https://github.com/Fullscreen/yt#apps-that-do-not-require-user-interactions) to it
8. [Install Redis](https://redis.io/topics/quickstart) (required for background job storage)
9. [Install Elasticsearch](https://www.elastic.co/guide/en/elasticsearch/reference/current/install-elasticsearch.html) (required for video indexing and searching)
10. [Start Elasticsearch](https://www.elastic.co/guide/en/elasticsearch/reference/current/starting-elasticsearch.html) service
11. Install Foreman (Starts the Rails server, webpacker, Redis server, and Sidekiq background worker from Procfile.dev)

```bash
gem install foreman
```

* To start the app:

```bash
foreman start -f Procfile.dev
```

## Contributing

Pull requests are greatly appreciated! Please submit all pull requests to the _develop_ branch. CI checks will require that your tests pass and that there are no rubocop offenses, so before you push to your fork it's a good idea to run the following on your local machine:

```bash
bundle exec rspec
```
```bash
bundle exec rubocop -P
```
