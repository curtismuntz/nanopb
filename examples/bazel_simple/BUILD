load("@com_github_nanopb_nanopb//rules:murt.bzl", "example_compile")
load("@rules_proto_grpc//cpp:defs.bzl", "cpp_proto_library")

proto_library(
    name = "simple",
    srcs = ["simple.proto"],
    deps = [],
)

example_compile(
    name = "example1",
    #    transitive = True,
    #    _plugins = [
    #        "@rules_proto_grpc//cpp:cpp_plugin",
    #        "@com_github_nanopb_nanopb//rules:nanopb_plugin",
    #    ],
    protos = [":simple"],
)

#cpp_proto_library(
#    name = "example1_pbz",
#    protos = [":simple"],
#)

#cc_library(
#    name = "example2",
#    hdrs = ["example2.h"],
#    deps = [
#        ":example1",
#        "@com_google_protobuf//:protobuf",
#    ],
#)
