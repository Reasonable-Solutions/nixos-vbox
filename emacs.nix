{ pkgs ? import <nixpkgs> {} }:

let
  myEmacs = pkgs.emacs;
  emacsWithPackages = (pkgs.emacsPackagesNgGen myEmacs).emacsWithPackages;

in
  emacsWithPackages (epkgs: (with epkgs.melpaStablePackages; [
    company
    eshell-git-prompt
    evil
    evil-escape
    evil-leader
    evil-magit
    evil-org
    evil-surround
    flycheck
    git-gutter
    haskell-mode
    helm
    helm-ag
    helm-projectile
    helm-swoop
    magit
    org-tree-slide
    paredit
    powerline
    projectile
    rainbow-delimiters
    scss-mode
    skewer-mode
    use-package
    which-key
    yaml-mode
  ]) ++ (with epkgs.melpaPackages; [
    ace-jump-mode
    company-nixos-options
    dante
    dhall-mode
    editorconfig
    eshell-git-prompt
    evil-ediff
    evil-lispy
    flycheck
    handlebars-mode
    helm-nixos-options
    htmlize
    hydra
    markdown-mode
    multi-term
    multiple-cursors
    nix-mode
    nix-sandbox
    nixos-options
    outshine
    racket-mode
    reason-mode
    reason-mode
    restclient
    rjsx-mode
    shackle
    undo-tree      # ; <C-x u> to show the undo tree
  ]) ++ (with epkgs.elpaPackages; [
    auctex         # ; LaTeX mode
    beacon         # ; highlight my cursor when scrolling
    rainbow-mode
  ]) ++ [
    pkgs.notmuch   # From main packages set
  ]

)
