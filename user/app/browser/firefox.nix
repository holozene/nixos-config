{ config, lib, pkgs, userSettings, ... }:

{
  # Option installing firefox as default browser
  programs.firefox = {
    enable = true;
    profiles.default = {
      isDefault = true;
      name = userSettings.username;
      search = {
        default = "DuckDuckGo";
        engines = {
          "MyNixOS" = {
            urls = [{ template = "https://mynixos.com/search?q={searchTerms}"; }];
            iconUpdateURL = "https://mynixos.com/favicon-32x32.png";
            updateInterval = 24 * 60 * 60 * 1000; # every day
            definedAliases = [ "@n" ];
          };
          
          "Nix Packages" = {
            urls = [{
              template = "https://search.nixos.org/packages";
              params = [
                { name = "type"; value = "packages"; }
                { name = "query"; value = "{searchTerms}"; }
              ];
            }];

            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@np" ];
          };

          "NixOS Wiki" = {
            urls = [{ template = "https://nixos.wiki/index.php?search={searchTerms}"; }];
            iconUpdateURL = "https://nixos.wiki/favicon.png";
            updateInterval = 24 * 60 * 60 * 1000; # every day
            definedAliases = [ "@nw" ];
          };

          "Bing".metaData.hidden = true;
          "Amazon.com".metaData.hidden = true;
          "eBay".metaData.hidden = true;
          "Wikipedia (en)".metaData.hidden = false;
        };
      };

      settings = {
        "browser.startup.page" = 3; # Resume Session on Start

        "browser.tabs.searchclipboardfor.middleclick" = true;
        "browser.tabs.insertAfterCurrent" = true;
        "browser.tabs.inTitlebar" = 1;
        "browser.link.open_newwindow" = 3;
        "browser.toolbars.bookmarks.visibility" = "always";
        "browser.download.autohideButton" = false;
        "browser.compactmode.show" = true;
        "browser.uidensity" = 1;

        "browser.download.useDownloadDir" = false;
        "browser.download.alwaysOpenPanel" = false;
        "browser.download.always_ask_before_handling_new_types" = true;
        "extensions.postDownloadThirdPartyPrompt" = false;

        "privacy.userContext.enabled" = true; # Enable Containers
        "privacy.userContext.ui.enabled" = true;

        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "datareporting.policy.dataSubmissionEnabled" = false;
        "datareporting.healthreport.uploadEnabled" = false;

        "dom.security.https_only_mode" = true;
        "browser.xul.error_pages.expert_bad_cert" = true;
        "network.IDN_show_punycode" = true;

        "browser.aboutConfig.showWarning" = false;
        "browser.uitour.enabled" = false;
        "browser.startup.homepage_override.mstone" = "ignore";
        "browser.messaging-system.whatsNewPanel.enabled" = false;
        "devtools.everOpened" = true;

        "widget.use-xdg-desktop-portal.file-picker" = 1;
        # "font.name.serif.x-western" = userSettings.font;
        # "font.size.variable.x-western" = 20;
      };
    };
  };

  home.sessionVariables = { DEFAULT_BROWSER = "${pkgs.firefox}/bin/firefox";};

  # https://nix-community.github.io/home-manager/options.xhtml#opt-programs.firefox.profiles._name_.userChrome
  
  # if (userSettings.wmType == "wayland") then { DEFAULT_BROWSER = "${pkgs.firefox}/bin/firefox";}
                            
  xdg.mimeApps.defaultApplications = {
  "text/html" = "firefox.desktop";
  "x-scheme-handler/http" = "firefox.desktop";
  "x-scheme-handler/https" = "firefox.desktop";
  "x-scheme-handler/about" = "firefox.desktop";
  "x-scheme-handler/unknown" = "firefox.desktop";
  };

}
