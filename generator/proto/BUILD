load("@rules_proto_grpc//python:defs.bzl", "python_proto_library")

proto_library(
    name = "nanopb_proto",
    srcs = [
        "nanopb.proto",
    ],
    visibility = ["//visibility:public"],
    deps = ["@com_google_protobuf//:descriptor_proto"],
)

python_proto_library(
    name = "proto_lib_python",
    protos = [":nanopb_proto"],
    transitive = True,
)

py_library(
    name = "nanopb_proto_py",
    srcs = [
        "__init__.py",
        "_utils.py",
    ],
    visibility = ["//visibility:public"],
    deps = [":proto_lib_python"],
)
