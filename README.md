Reproduces an issue with buildozer with finding a rule with a certain name when
that rule is actually a macro being assigned to a value.

For instance, in `//hello-world/BUILD.bazel`, there is a target that creates a
`java_binary` via a macro:

```starlark
macro_java_binary(
    name = "hello-world",
    srcs = ["src/main/java/com/mattnworb/example/Main.java"],
    main_class = "com.mattnworb.example.Main",
)
```

```shell
❯ buildozer 'print label srcs' //hello-world
//hello-world [src/main/java/com/mattnworb/example/Main.java]
```

but if the macro is made to return something, and that value is assigned to a
variable in the BUILD.bazel file, then buildozer can no longer find the
rule/target:

```starlark
foo = macro_java_binary(
    name = "hello-world",
    srcs = ["src/main/java/com/mattnworb/example/Main.java"],
    main_class = "com.mattnworb.example.Main",
)
```

```shell
❯ buildozer 'print label srcs' //hello-world
/Users/mattbrown/code/buildozer-issue-repro/hello-world/BUILD.bazel: error while executing commands [{[print label srcs]}] on target //hello-world: rule 'hello-world' not found
```

even though buildozer can execute the command against the target in question,
when expanding wildcards:

```shell
❯ buildozer 'print label srcs' //hello-world:*
//hello-world [src/main/java/com/mattnworb/example/Main.java]
```