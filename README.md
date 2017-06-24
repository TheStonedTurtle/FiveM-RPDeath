<h1>Goal:</h1>
  Prevent automatic respawn to allow medical units to respond to a scene. This script will override all default respawn points and will make people respawn at one of 5 hospitals (random).

<h2>Installation instructions: </h2>
<ol>
  <li>Drag the RPDeath folder into your server's resource folder. ex (cfx-server/resources)</li>
  <li>Edit the citmp-server.yml file located in the main folder. ex (cfx-server/)</li>
  <li>Add the following code: `- RPDeath` under the `AutoStartResources` option. Example below.<br/>
   AutoStartResources:<br/>
    - chat<br/>
    - spawnmanager<br/>
    - fivem-map-skater<br/>
    - baseevents<br/>
    - rconlog<br/>
    - hardcap # prevents too many players from joining<br/>
    - scoreboard<br/>
    - RPDeath</li>
  <li>All done, restart your server and the mod should automatically start.</li>
</ol>

<h2>Requires:</h2>
  <b>- spawnmanager</b>

<h2>Usage Commands:</h2>

  <h3>Respawn Command:</h3>
    <b>/respawn</b> : Will respawn you one of 5 hosptial locations. Must be dead, hospital chosen at random.

  <h3>Revive Command:</h3>
    <b>/revive</b> : Will revive you at your current spot. Must be dead.<br/>
    <b>/revive *id*</b> : Will revive the player ID at their current location. Player must be dead.

  <h3>Toggle Command:</h3>
    <b>/toggleDeath</b> : Upon dying you will automatically respawn at a random hospital after 3 seconds.
