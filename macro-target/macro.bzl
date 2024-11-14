def macro_java_binary(name, srcs, main_class):
    native.java_binary(
        name = name,
        srcs = srcs,
        main_class = main_class,
    )
