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
    evil-org
    evil-surround
    lsp-mode
    lsp-ui
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
    helm-nixos-options
    htmlize
    hydra
    markdown-mode
    multi-term
    nix-mode
    nix-sandbox
    nixos-options
    racket-mode
    reason-mode
    restclient
    rjsx-mode
    shackle
  ]) ++ (with epkgs.elpaPackages; [
    rainbow-mode
  ]) ++ [
  ]

)
