load("@rules_proto//proto:defs.bzl", "ProtoInfo")
load("@rules_cc//cc:defs.bzl", "cc_library")
load("//rules:filter_files.bzl", "filter_files")
load(
    "@rules_proto_grpc//:defs.bzl",
    "ProtoLibraryAspectNodeInfo",
    "ProtoPluginInfo",
    "proto_compile_aspect_attrs",
    "proto_compile_aspect_impl",
    "proto_compile_attrs",
    "proto_compile_impl",
)

# Create aspect
example_aspect = aspect(
    implementation = proto_compile_aspect_impl,
    provides = [ProtoLibraryAspectNodeInfo],
    attr_aspects = ["deps"],
    attrs = dict(
        proto_compile_aspect_attrs,
        _plugins = attr.label_list(
            doc = "List of protoc plugins to apply",
            providers = [ProtoPluginInfo],
            default = [
                Label("@com_github_nanopb_nanopb//rules:nanopb_plugin"),
            ],
        ),
        _prefix = attr.string(
            doc = "String used to disambiguate aspects when generating outputs",
            default = "example_aspect",
        ),
    ),
    toolchains = ["@rules_proto_grpc//protobuf:toolchain_type"],
)

# Create compile rule to apply aspect
_rule = rule(
    implementation = proto_compile_impl,
    attrs = dict(
        proto_compile_attrs,
        protos = attr.label_list(
            mandatory = False,  # TODO: set to true in 4.0.0 when deps removed below
            providers = [ProtoInfo],
            doc = "List of labels that provide the ProtoInfo provider (such as proto_library from rules_proto)",
        ),
        deps = attr.label_list(
            mandatory = False,
            providers = [ProtoInfo, ProtoLibraryAspectNodeInfo],
            aspects = [example_aspect],
            doc = "DEPRECATED: Use protos attr",
        ),
        _plugins = attr.label_list(
            providers = [ProtoPluginInfo],
            default = [
                Label("@com_github_nanopb_nanopb//rules:nanopb_plugin"),
            ],
            doc = "List of protoc plugins to apply",
        ),
    ),
    toolchains = [str(Label("@rules_proto_grpc//protobuf:toolchain_type"))],
)

# Create macro for converting attrs and passing to compile
def example_compile(**kwargs):
    name = kwargs.get("name")
    name_pb = name + "_pb"
    _rule(
        name = name_pb,
        **{
            k: v
            for (k, v) in kwargs.items()
            if k in ["protos" if "protos" in kwargs else "deps"] + proto_compile_attrs.keys()
        }  # Forward args
    )

    PDEPS = [
        #        "//:nanopb_cclib",
        #        "@com_google_protobuf//:protobuf",
    ]

    # Filter files to sources and headers
    filter_files(
        name = name_pb + "_srcs",
        target = name_pb,
        extensions = ["c", "cc"],
    )

    filter_files(
        name = name_pb + "_hdrs",
        target = name_pb,
        extensions = ["h"],
    )

    print(PDEPS)

    native.filegroup(
        name = name + "_internal",
        srcs = ["//srcs:nanopb_cclib"],
    )

    cc_library(
        name = name,
        srcs = [name_pb + "_srcs"],
        hdrs = [name_pb + "_hdrs"],
        #        deps = PROTO_DEPS + (kwargs.get("deps", []) if "protos" in kwargs else []),
        deps = PDEPS + ["//srcs:nanopb_cclib"],
        includes = [name_pb, name],
        #        alwayslink = kwargs.get("alwayslink"),
        #        copts = kwargs.get("copts"),
        #        defines = kwargs.get("defines"),
        #        include_prefix = kwargs.get("include_prefix"),
        #        linkopts = kwargs.get("linkopts"),
        #        linkstatic = kwargs.get("linkstatic"),
        #        local_defines = kwargs.get("local_defines"),
        #        nocopts = kwargs.get("nocopts"),
        #        strip_include_prefix = kwargs.get("strip_include_prefix"),
        visibility = kwargs.get("visibility"),
        tags = kwargs.get("tags"),
    )
