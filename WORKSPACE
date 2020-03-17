workspace(name = "com_github_nanopb_nanopb")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")

git_repository(
    name = "com_google_protobuf",
    commit = "09745575a923640154bcf307fba8aedff47f240a",
    remote = "https://github.com/protocolbuffers/protobuf",
    shallow_since = "1558721209 -0700",
)

load("@com_google_protobuf//:protobuf_deps.bzl", "protobuf_deps")

protobuf_deps()

http_archive(
    name = "rules_python",
    sha256 = "aa96a691d3a8177f3215b14b0edc9641787abaaa30363a080165d06ab65e1161",
    url = "https://github.com/bazelbuild/rules_python/releases/download/0.0.1/rules_python-0.0.1.tar.gz",
)

load("@rules_python//python:repositories.bzl", "py_repositories")

py_repositories()

load("@rules_python//python:pip.bzl", "pip_import", "pip_repositories")

pip_repositories()

http_archive(
    name = "build_stack_rules_proto",
    sha256 = "35779b6eadae57f58e65e717e8fcb2bc19408977ebb48412d6eff708048e0fb5",
    strip_prefix = "rules_proto-95ea73aef50fcf04e91f379589fe37be29073be2",
    urls = ["https://github.com/reflexe/rules_proto/archive/95ea73aef50fcf04e91f379589fe37be29073be2.tar.gz"],
)

load("@build_stack_rules_proto//python:deps.bzl", "python_proto_library")

python_proto_library()

pip_import(
    name = "protobuf_py_deps",
    requirements = "@build_stack_rules_proto//python/requirements:protobuf.txt",
)

load("@protobuf_py_deps//:requirements.bzl", protobuf_pip_install = "pip_install")

protobuf_pip_install()
