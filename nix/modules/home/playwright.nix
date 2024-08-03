# playwright.nix
# This module sets up Playwright for use with Nix and Home Manager.
# It installs the Playwright browsers and sets necessary environment variables.

{ pkgs, ... }:

{
  # Install Playwright browsers
  home.packages = with pkgs; [
    playwright-driver.browsers
  ];

  # Set environment variables for Playwright
  home.sessionVariables = 

  let
        playwright-driver = pkgs.playwright-driver;
        playwright-driver-browsers = pkgs.playwright-driver.browsers;

        playright-file = builtins.readFile "${playwright-driver}/package/browsers.json";
        playright-json = builtins.fromJSON playright-file;
        playwright-chromium-entry = builtins.elemAt (builtins.filter (
          browser: browser.name == "chromium"
        ) playright-json.browsers) 0;
        playwright-chromium-revision = playwright-chromium-entry.revision;
      in 
   {
    # Set the path where Playwright should look for browsers
    # This ensures Playwright uses the Nix-installed browsers
    # PLAYWRIGHT_BROWSERS_PATH = "${pkgs.playwright-driver.browsers}";
    # TODO: add MacOS support to omit this
    PLAYWRIGHT_CHROMIUM_EXECUTABLE_PATH = "${playwright-driver-browsers}/chromium-${playwright-chromium-revision}/chrome-linux/chrome";
    # This is used by npx playwright --{ui,debug,...}
    PLAYWRIGHT_BROWSERS_PATH = "${playwright-driver-browsers}";
    # Skip validation of host requirements
    # This can be useful in Nix environments where some
    # standard requirements might not be met in the usual way
    PLAYWRIGHT_SKIP_VALIDATE_HOST_REQUIREMENTS = "true";
  };

  # Note: To use this module, import it in your Home Manager configuration:
  # imports = [ ./path/to/playwright.nix ];
}
