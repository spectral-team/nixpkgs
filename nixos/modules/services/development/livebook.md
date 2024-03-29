# Livebook {#module-services-livebook}

[Livebook](https://livebook.dev/) is a web application for writing
interactive and collaborative code notebooks.

## Basic Usage {#module-services-livebook-basic-usage}

Enabling the `livebook` service creates a user
[`systemd`](https://www.freedesktop.org/wiki/Software/systemd/) unit
which runs the server.

```
{ ... }:

{
  services.livebook = {
    enableUserService = true;
    port = 20123;
    # See note below about security
    environmentFile = pkgs.writeText "livebook.env" ''
      LIVEBOOK_PASSWORD = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
    '';
  };
}
```

::: {.note}

The Livebook server has the ability to run any command as the user it
is running under, so securing access to it with a password is highly
recommended.

Putting the password in the Nix configuration like above is an easy
way to get started but it is not recommended in the real world because
the `livebook.env` file will be added to the world-readable Nix store.
A better approach would be to put the password in some secure
user-readable location and set `environmentFile = /home/user/secure/livebook.env`.

:::
