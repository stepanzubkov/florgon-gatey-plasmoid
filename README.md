# Florgon Gatey Plasmoid

Plasmoid for logging service [Florgon Gatey](https://gatey.florgon.com/) built with it's [API](https://gatey.florgon.com/dev/api)

**WARNING:** Florgon Gatey now in beta and a lot of things may not work. Contact stepanzubkov@florgon.com (Me) if you find a bug.
 
![Screenshot_20230109_124032](https://user-images.githubusercontent.com/83695097/211279273-06226088-d657-42e3-9bd5-48d9145e2b05.png)


# Overview

With Florgon Gatey you can:

- Easy to connect your services
- Monitor events
- Explore errors, warnings from your app

It's free! Without paid subscription you can connect up to 3 apps. Manage your projects from official website or from this official widget.

# Usage

1. [Create account in Florgon](https://florgon.com/oauth/authorize?client_id=1&state=&redirect_uri=https://florgon.com/oauth/callback&scope=email,edit,sessions,security,admin,oauth_clients&response_type=token)
2. Go to [Gatey](https://gatey.florgon.com/)
3. Create project
4. Download this widget on pling or KDE Store
5. Place it on panel and go to "Widget Settings"
6. Login with "Login" button
7. Choose project in settings

Then you can use widget. 

# Contributions

Find bug or have interesting idea? Contribute this project! Issues and PRs are welcome.

Help with widget translation! See issue #1

For developers there are two shell scripts:

1. `build.sh` - Builds widget into plasma's widgets directory (`~/.local/share/plasma/plasmoids/`) and runs widget in *plasmoid viewer*

2. `build_and_restart.sh` - Executes `build.sh` script and restarting plasmashell

If you do not understand how to test this widget or how to register in Florgon Gatey, contact me in [telegram](https://t.me/@stepanzubkov)

[![Stargazers repo roster for @Stepan-Zubkov/florgon-gatey-plasmoid](https://reporoster.com/stars/Stepan-Zubkov/florgon-gatey-plasmoid)](https://github.com/Stepan-Zubkov/florgon-gatey-plasmoid/stargazers)

[![Forkers repo roster for @Stepan-Zubkov/florgon-gatey-plasmoid](https://reporoster.com/forks/Stepan-Zubkov/florgon-gatey-plasmoid)](https://github.com/Stepan-Zubkov/florgon-gatey-plasmoid/network/members)
