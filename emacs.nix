{ pkgs ? import <nixpkgs> {} }: 

let
  myEmacs = pkgs.emacs; 
  emacsWithPackages = (pkgs.emacsPackagesNgGen myEmacs).emacsWithPackages; 
in
  emacsWithPackages (epkgs: (with epkgs.melpaStablePackages; [ 
    magit          # ; Integrate git <C-x g>
    which-key
    evil
    evil-escape
    evil-leader
    evil-org
    evil-surround
    evil-magit
    flycheck
    projectile
    helm
    helm-ag
    helm-swoop
    helm-projectile
    company
  ]) ++ (with epkgs.melpaPackages; [ 
    restclient
    ace-jump-mode
    hydra
    evil-ediff
    undo-tree      # ; <C-x u> to show the undo tree
  ]) ++ (with epkgs.elpaPackages; [ 
    auctex         # ; LaTeX mode
    beacon         # ; highlight my cursor when scrolling
    exwm
  ]) ++ [
    pkgs.notmuch   # From main packages set 
  ])
