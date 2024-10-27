#!/bin/sh

# Default to starting extractor if no COMMAND is provided
COMMAND=${COMMAND:-start-extractor}
PORT=${SERVER_PORT:-3000}

# Start the server with the given command and port
exec node dist/server.js $COMMAND
