################# deps.bzl #######################
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def toolchain_gcc_dependencies():
    # Load rules_cc if the user has not defined them.
    if not native.existing_rule("rules_cc"):
        http_archive(
            name = "rules_cc",
            urls = ["https://github.com/bazelbuild/rules_cc/releases/download/0.1.1/rules_cc-0.1.1.tar.gz"],
            sha256 = "712d77868b3152dd618c4d64faaddefcc5965f90f5de6e6dd1d5ddcd0be82d42",
            strip_prefix = "rules_cc-0.1.1",
        )

    # Load bazel_skylib if the user has not defined them.
    if not native.existing_rule("bazel_skylib"):
        http_archive(
            name = "bazel_skylib",
            sha256 = "bc283cdfcd526a52c3201279cda4bc298652efa898b10b4db0837dc51652756f",
            urls = [
                "https://mirror.bazel.build/github.com/bazelbuild/bazel-skylib/releases/download/1.7.1/bazel-skylib-1.7.1.tar.gz",
                "https://github.com/bazelbuild/bazel-skylib/releases/download/1.7.1/bazel-skylib-1.7.1.tar.gz",
            ],
        )
    
    # Load gcc_toolchain_gcc if the user has not defined them.
    if not native.existing_rule("gcc_toolchain_gcc"):
        http_archive(
            name = "gcc_toolchain_gcc",
            build_file = "@score_toolchains_gcc//toolchain/third_party:gcc.BUILD",0
            url = "https://github.com/eclipse-score/toolchains_gcc/releases/download/0.0.1/x86_64-unknown-linux-gnu_gcc12.tar.gz",
            sha256 = "457f5f20f57528033cb840d708b507050d711ae93e009388847e113b11bf3600",
            strip_prefix = "x86_64-unknown-linux-gnu",
        )
