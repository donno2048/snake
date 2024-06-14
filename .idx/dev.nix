{ pkgs, ... }: {
  packages = [
    pkgs.python3Minimal
    pkgs.nasm
  ];
  idx.previews.previews.web = {
    command = ["./main.sh"];
    manager = "web";
    env = { PORT = "$PORT"; };
  };
}
