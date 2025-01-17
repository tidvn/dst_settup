#!/bin/bash

screen -ls | grep -o '[0-9]*\.' | grep -o '[0-9]*' | xargs -n 1 kill

screen -dmS soyam bash -c "curl -fsSL https://gist.githubusercontent.com/tidvn/975d46eedc88f0c65636b89e5ffd9154/raw/run_cluster.sh | bash -s -- soyam"
# screen -dmS tidvn bash -c "curl -fsSL https://gist.githubusercontent.com/tidvn/975d46eedc88f0c65636b89e5ffd9154/raw/run_cluster.sh | bash -s -- tidvn"
