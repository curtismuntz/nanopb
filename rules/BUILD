load("@rules_proto_grpc//:defs.bzl", "proto_plugin")

proto_plugin(
    name = "nanopb_plugin",
    #    exclusions = ["google/protobuf"],
    options = [
        #        "generate_mock_code=true",
        #        """-L'#include pb.h'""",
    ],
    outputs = [
        "{protopath}.pb.h",
        "{protopath}.pb.c",
    ],
    protoc_plugin_name = "nanopb",
    tool = "//generator:nanopb_generator",
    visibility = ["//visibility:public"],
)
