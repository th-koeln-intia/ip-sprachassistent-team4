---
layout: default
title: Profiles
parent: Knowledge
---

<details close markdown="block">
  <summary>
    Table of contents
  </summary>
  {: .text-delta }
1. TOC
{:toc}
</details>

# Profiles 

## For what are profiles good for?
Here are all configurations for rhasspy saved. For example configurations for Wake Word detection, speech transcription 
or intent recognition.
 
## Files
`profiles/defaults.json`: This is the default profile for all profiles. It'll apply to all profiles on start.
`profiles/<profilename>/profile.json`: There is also an additional profile file for each profile, that overrides 
the default settings.
 
## Profiles folder
The `profiles` folder can be found in different locations, there are also two kinds of profile folders. One system 
profile folder and a user profile folder.
The user profile folder overrides the system profile folder, you can either set them or use the default location.   
If you are using Docker, so the system profile folder is in location 
`/usr/lib/rhasspy-voltron/rhasspy-profile/rhasspyprofile/profiles`, and the user profile must be mapped the folder 
explicit in the start command 
`docker run ... -v /localpath/to/profiles:/profiles <IMAGE_NAME> --user-profiles /profiles`.
 
The arguments for Docker to set them manually are:
- For the system profile: `--system-profiles <DIR>`
- For the user profile `--user-profiles <DIR>`
 
Most changes are in the user profile.
 
If you installed rhasspy without Docker, the user folder is in the location ``$HOME/.config/rhasspy/profiles``.
Here you find your profiles and your ``profile.json``.
