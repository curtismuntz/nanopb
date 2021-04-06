load("@rules_proto_grpc//cpp:defs.bzl", "cpp_proto_library")

def nanopb_proto_compile(**kwargs):
    proto_compile(
        plugins = [
            str(Label("@com_github_nanopb_nanopb//rules:nanopb")),
        ],
        **kwargs
    )
