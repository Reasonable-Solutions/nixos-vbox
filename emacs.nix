{ pkgs ? import <nixpkgs> {} }: 

let
  myEmacs = pkgs.emacs; 
  emacsWithPackages = (pkgs.emacsPackagesNgGen myEmacs).emacsWithPackages;

in
  emacsWithPackages (epkgs: (with epkgs.melpaStablePackages; [ 
    company
    evil
    evil-escape
    evil-leader
    evil-magit
    evil-org
    evil-surround
    flycheck
    git-gutter
    helm
    helm-ag
    scss-mode
    rainbow-delimiters
    helm-projectile
    helm-swoop
    magit          # ; Integrate git <C-x g>
    projectile
    which-key
    powerline
  ]) ++ (with epkgs.melpaPackages; [ 
    multiple-cursors
    restclient
    nix-mode
    ace-jump-mode
    rjsx-mode
    handlebars-mode
    eshell-git-prompt
    shackle
    hydra
    multi-term
    evil-ediff
    undo-tree      # ; <C-x u> to show the undo tree
  ]) ++ (with epkgs.elpaPackages; [ 
    rainbow-mode
    auctex         # ; LaTeX mode
    beacon         # ; highlight my cursor when scrolling
    exwm
  ]) ++ [
    pkgs.notmuch   # From main packages set 
  ]

)
