{ sources =
    [ "*.purs" ]
, name =
    "my-project"
, dependencies =
    [ "aff", "console", "typelevel-prelude" ]
, packages =
    ./packages.dhall
}
