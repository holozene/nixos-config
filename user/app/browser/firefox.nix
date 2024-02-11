{ config, lib, pkgs, wmType, font, ... }:

{
  # Option installing firefox as default browser
  programs.firefox = {
    enable = true;
    preferences = {
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
      "font.name.serif.x-western" = font;
      "font.size.variable.x-western" = 20;
    };
  };

  home.sessionVariables = { DEFAULT_BROWSER = "${pkgs.firefox}/bin/firefox";};

  # https://nix-community.github.io/home-manager/options.xhtml#opt-programs.firefox.profiles._name_.userChrome
  
  # if (wmType == "wayland") then { DEFAULT_BROWSER = "${pkgs.firefox}/bin/firefox";}
                            
  xdg.mimeApps.defaultApplications = {
  "text/html" = "firefox.desktop";
  "x-scheme-handler/http" = "firefox.desktop";
  "x-scheme-handler/https" = "firefox.desktop";
  "x-scheme-handler/about" = "firefox.desktop";
  "x-scheme-handler/unknown" = "firefox.desktop";
  };

}
