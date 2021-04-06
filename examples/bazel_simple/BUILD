load("@com_github_nanopb_nanopb//rules:murt.bzl", "nanopb_proto_library")
load("@rules_proto_grpc//cpp:defs.bzl", "cpp_proto_library")

proto_library(
    name = "simple",
    srcs = ["simple.proto"],
    deps = [],
)

nanopb_proto_library(
    name = "example1",
    protos = [":simple"],
)
