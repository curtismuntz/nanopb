package(default_visibility = ["//visibility:public"])

licenses(["notice"])

cc_library(
    name = "nanopb_cclib",
    srcs = [
        "pb_common.c",
        "pb_decode.c",
        "pb_encode.c",
    ],
    hdrs = [
        "pb.h",
        "pb_common.h",
        "pb_decode.h",
        "pb_encode.h",
    ],
    includes = [
        ".",
        "srcs",
    ],
    strip_include_prefix = ".",
    visibility = ["//visibility:public"],
)
