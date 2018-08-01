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
    helm
    helm-ag
    helm-projectile
    helm-swoop
    magit          # ; Integrate git <C-x g>
    projectile
    uniquify
    which-key
  ]) ++ (with epkgs.melpaPackages; [ 
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
    auctex         # ; LaTeX mode
    beacon         # ; highlight my cursor when scrolling
    exwm
  ]) ++ [
    pkgs.notmuch   # From main packages set 
  ]

)
