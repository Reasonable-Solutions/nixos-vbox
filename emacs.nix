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
    magit          # ; Integrate git <C-x g>
    powerline
    projectile
    rainbow-delimiters
    scss-mode
    use-package
    which-key
    yaml-mode
    org-tree-slide
  ]) ++ (with epkgs.melpaPackages; [ 
    ace-jump-mode
    dhall-mode
    reason-mode
    editorconfig
    eshell-git-prompt
    evil-ediff
    handlebars-mode
    hydra
    markdown-mode
    multi-term
    multiple-cursors
    nix-mode
    restclient
    rjsx-mode
    reason-mode
    nix-sandbox
    nixos-options
    helm-nixos-options
    flycheck
    company-nixos-options
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
