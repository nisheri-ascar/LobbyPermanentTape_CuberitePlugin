**currently wip, dont use.**
---
# LobbyPermanentTape Cuberite Plugin
This plugin is made for very specific usecase of utilizing Cuberite as a lobby. 
Its named LobbyPermanentTape since its a simple workaround that works well but will likely cause problems in future, might be foreshadowing lol

## What is it for?
This plugin is an alternative for [AutoServer Plugin](https://modrinth.com/plugin/autoserver). It works similarly except LobbyPermanentTape works by checking *an HTTP Server* if its up and also doesn't require for backend to have a `bootListener`.

## How it works
1. Periodically check every 10 seconds if `HTTPServer` returns 200 OK, ignores when recieves Connection Refused.
2. Once 200 OK is received, wait for another 60 seconds to ensure the server is finished starting.
3. Once finished, kick all existing players. Causing them to transfer to main server.
4. Kick all incoming players while `IsServerAlive` flag is true.

## Problems with this implementation
- The logic is too naive. There could be much robust implementation that potentially can skip the 60 second wait period.
