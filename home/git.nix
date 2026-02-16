{ ... }:
{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Chris West";
        email = "cjwest4942@gmail.com";
      };
      alias = {
        ec = "config --edit --global";
        cm = "commit -m";
        cmn = "commit --no-verify -m";
        ca = "commit --amend";
        can = "commit --amend --no-edit";
        canv = "commit --amend --no-verify";
        a = "add";
        ap = "add -p";
        p = "pull";
        ps = "push";
        psf = "push -f";
        psn = "push --no-verify";
        s = "status";
        d = "diff";
        dc = "diff --cached";
        dl = "diff @..@~";
        cl = "clone";
        b = "branch";
        bf = "branch --force";
        c = "checkout";
        cb = "checkout -b";
        st = "stash";
        sta = "stash apply";
        stk = "stash -k";
        r = "reset";
        rh = "reset --hard";
        l = "log";
        l1 = "log --oneline";
        l1g = "log --oneline --graph";
        m = "merge";
        mc = "merge --continue";
        ma = "merge --abort";
        cp = "cherry-pick";
        clf = "clean -f";
        # git extension commands:
        # These commands are based on git commands, but have names unrelated to the underlying commands
        add-non-whitespace-changes = "!git diff -U0 -w --no-color | git apply --cached --ignore-whitespace --unidiff-zero -";
        anw = "add-non-whitespace-changes";
        root = "rev-parse --show-toplevel";
        current-commit = "rev-parse @";
        curc = "!git current-commit | tr -d '\n'";
        current-branch = "rev-parse --abbrev-ref @";
        curb = "!git current-branch | tr -d '\n'";
        uncommit = "reset --soft @~";
        fire = "!git add .; git commit -m 'emergency save'; gitpush";
      };
      color.ui = "auto"; # I don't know if this is necessary, but it was in my old config so I'm including it here too
    };
  };
}
