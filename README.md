**HOW TO RUN**

- *with docker*

	1. make sure you installed docker and docker-compose version 3
	2. first create network `docker network create "local" -d bridge`
	3. copy `.env.example` to `.env`
	4. setup your any credential in `.env` file
	5. copy `application.example.yml` in `/config` into `application.yml`
	6. also setup your any credential in `application.yml`
	7. run command `docker-compose -f docker-compose.database.yml up --build -d` for run database instance
	8. run command `docker-compose -f docker-compose.app.yml up --build -d` for run application instance
	9. open `http://localhost:3000` in your browser
	10. enjoy!

- *without docker*
	1. make sure you installed ruby 2.7.0, or use ruby package manager to manage your ruby version
	2. run this if your device is apple chip
		- `gem uninstall nokogiri`
		- `bundle config set force_ruby_platform true`
	3. copy `application.example.yml` in `/config` into `application.yml`
	4. setup your any credential in `application.yml`
	5. run bundle install
	6. open `http://localhost:3000`
	7. enjoy!