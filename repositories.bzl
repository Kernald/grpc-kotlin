load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

# For use with maven_install's artifacts.
# maven_install(
#     ...
#     artifacts = [
#         # Your own deps
#     ] + IO_GRPC_GRPC_KOTLIN_ARTIFACTS + IO_GRPC_GRPC_JAVA_ARTIFACTS,
# )
IO_GRPC_GRPC_KOTLIN_ARTIFACTS = [
    "com.google.guava:guava:29.0-jre",
    "com.squareup:kotlinpoet:1.5.0",
    "org.jetbrains.kotlinx:kotlinx-coroutines-core:1.3.9",
    "org.jetbrains.kotlinx:kotlinx-coroutines-core-jvm:1.3.9",
    "org.jetbrains.kotlinx:kotlinx-coroutines-debug:1.3.9",
]

# For use with maven_install's override_targets.
# maven_install(
#     ...
#     override_targets = dict(
#         IO_GRPC_GRPC_JAVA_OVERRIDE_TARGETS.items() +
#         IO_GRPC_GRPC_KOTLIN_OVERRIDE_TARGETS.items(),
#         "your.target:artifact": "@//third_party/artifact",
#     )
IO_GRPC_GRPC_KOTLIN_OVERRIDE_TARGETS = dict()

# Call this after compat_repositories() to load all dependencies.
def grpc_kt_repositories():
    """Imports dependencies for kt_jvm_grpc.bzl"""
    if not native.existing_rule("io_bazel_rules_kotlin"):
        io_bazel_rules_kotlin()
    if not native.existing_rule("com_google_protobuf"):
        com_google_protobuf()
    if not native.existing_rule("io_grpc_grpc_java"):
        io_grpc_grpc_java()

def io_bazel_rules_kotlin():
    rules_kotlin_version = "v1.5.0"
    rules_kotlin_sha = "12d22a3d9cbcf00f2e2d8f0683ba87d3823cb8c7f6837568dd7e48846e023307"
    http_archive(
        name = "io_bazel_rules_kotlin",
        urls = ["https://github.com/bazelbuild/rules_kotlin/releases/download/%s/rules_kotlin_release.tgz" % rules_kotlin_version],
        sha256 = rules_kotlin_sha,
    )

def com_google_protobuf():
    protobuf_version = "3.19.4"
    protobuf_sha = "ba0650be1b169d24908eeddbe6107f011d8df0da5b1a5a4449a913b10e578faf"

    http_archive(
        name = "com_google_protobuf",
        sha256 = protobuf_sha,
        strip_prefix = "protobuf-%s" % protobuf_version,
        urls = ["https://github.com/protocolbuffers/protobuf/releases/download/v%s/protobuf-all-%s.tar.gz" % (protobuf_version, protobuf_version)],
    )

def io_grpc_grpc_java():
    http_archive(
        name = "io_grpc_grpc_java",
        sha256 = "16cf4556c08b580efede083a9a972eb45060bfbf324cdafc4f9be098ac9e0f01",
        strip_prefix = "grpc-java-1.44.0",
        url = "https://github.com/grpc/grpc-java/archive/v1.44.0.zip",
    )
