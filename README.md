# Heroku Buildpack for Logstash

This buildpack downloads and installs Logstash into a Heroku app slug.

It was originally based on [omc/heroku-buildpack-kibana](https://github.com/omc/heroku-buildpack-kibana), and several other buildpacks for logstash that didn't work for me or weren't maintained.

## Usage

As a standalone buildpack:

    # Create a new project with the --buildpack option
    mkdir logstash1 && cd logstash1 && git init
    heroku create logstash1 --buildpack https://github.com/mr-perseus/heroku-buildpack-logstash 

    # ...Or update an existing project with heroku buildpacks:set
    heroku buildpacks:set https://github.com/mr-perseus/heroku-buildpack-logstash --app="your-app" 

    # Let the buildpack know where to find Logstash download
    heroku config:set DOWNLOAD_URL="https://artifacts.elastic.co/downloads/logstash/logstash-7.13.2-linux-x86_64.tar.gz"

    # Create a logstash.conf in your current directory.
    # I've included an example in this repo. It's only here as an example.
    # Notice that there are environment variables referenced in the file, such as ${PORT}
    vim logstash.conf
    ...

    # Set any config variables used in your logstash.conf.
    # ${PORT} is automatically set by Heroku
    heroku config:set ELASTIC_USERNAME="elastic"
    heroku config:set ELASTIC_PASSWORD="xxxxxxx"

    # Create a Procfile to run the Logstash binary
    # Since the download unpacks to a folder with the version name, change the folder name to
    # match your version number
    echo 'web: logstash-7.13.2/bin/logstash -f logstash.conf' > Procfile

    # Push everything to trigger a deploy
    git add . && git commit -am "Logstash setup" && git push heroku master

    # Open the app in your browser
    heroku open
