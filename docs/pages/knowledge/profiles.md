---
layout: default
parent: Knowledge
---

# Profiles 

## For what are profiles good for?
Here are all confogurations for rhasspy saved. For example configiurations for wake word detection, speech transcription or intent recognitiion.

## Files
`profiles/defaults.json`: This is the default profile for all profiles. It'll applied to all profiles on start.
`profiles/<profilename>/profile.json`: There is also a additional profile file for each profile, that overrides the default settings.

## Profiles folder
The `profiles` folder can be find in different locations, there also two kinds of profile folders. One System profile folder and a user profile folder.
The user profile folder overrides the system profile folder, you can either set them or use the default location.   
We are using Docker, so the system profile folder is in location `/usr/lib/rhasspy-voltron/rhasspy-profile/rhasspyprofile/profiles', and the user profile must be map the folder explicit in the start command `docker run ... -v /localpath/to/profiles:/profiles <IMAGE_NAME> --user-profiles /profiles`.

The arguments for docker to set them manually are:
- For the system profile: `--system-profiles <DIR>`
- For the user profile `--user-profiles <DIR>`

Most changes are in the user profile.