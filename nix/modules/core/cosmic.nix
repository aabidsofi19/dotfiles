{ pkgs, username, ... }:
{
    services.desktopManager = {
        cosmic.enable = true;
    };

    services.displayManager.cosmic-greeter.enable = true;
}
