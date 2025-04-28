# *******************************************************************************
# Copyright (c) 2025 Contributors to the Eclipse Foundation
#
# See the NOTICE file(s) distributed with this work for additional
# information regarding copyright ownership.
#
# This program and the accompanying materials are made available under the
# terms of the Apache License Version 2.0 which is available at
# https://www.apache.org/licenses/LICENSE-2.0
#
# SPDX-License-Identifier: Apache-2.0
# *******************************************************************************

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@score_toolchains_gcc//rules:gcc.bzl", "gcc_toolchain")

def _gcc_impl(mctx):
    """Implementation of the module extension."""

    for mod in mctx.modules:
        if not mod.is_root:
            fail("Only the root module can use the 'gcc' extension")

    toolchain_info = None
    features = []
    warning_flags = None

    for mod in mctx.modules:
        for tag in mod.tags.toolchain:
            toolchain_info = {
                "name": tag.name,
                "url": tag.url,
                "strip_prefix": tag.strip_prefix,
                "sha256": tag.sha256,
            }

        for tag in mod.tags.extra_features:
            for feature in tag.features:
                features.append(feature)

        for tag in mod.tags.warning_flags:
            warning_flags = {
                "minimal_warnings":tag.minimal_warnings,
                "strict_warnings":tag.strict_warnings,
                "treat_warnings_as_errors":tag.treat_warnings_as_errors
            }

    if toolchain_info:
        http_archive(
            name = "%s_gcc" % toolchain_info["name"],
            urls = [toolchain_info["url"]],
            build_file = "@score_toolchains_gcc//toolchain/third_party:gcc.BUILD",
            sha256 = toolchain_info["sha256"],
            strip_prefix = toolchain_info["strip_prefix"],
        )

        gcc_toolchain(
            name = toolchain_info["name"],
            gcc_repo = "%s_gcc" % toolchain_info["name"],
            extra_features = features,
            warning_flags = warning_flags,
        )

    else:
        fail("Cannot create gcc toolchain repository, some info is missing!")

gcc = module_extension(
    implementation = _gcc_impl,
    tag_classes = {
        "toolchain": tag_class(
            attrs = {
                "name": attr.string(doc = "Same name as the toolchain tag.", default="gcc_toolchain"),
                "url": attr.string(doc = "Url to the toolchain package."),
                "strip_prefix": attr.string(doc = "Strip prefix from toolchain package.", default=""),
                "sha256": attr.string(doc = "Checksum of the package"),
            },
        ),
        "warning_flags": tag_class(
            attrs = {
                "name": attr.string(doc = "Same name as the toolchain tag.", default="gcc_toolchain"),
                "minimal_warnings": attr.string_list(
                    doc = "List of extra flags for 'minimal_warnings' features.",
                    default= [],
                ),
                "strict_warnings": attr.string_list(
                    doc = "List of extra flags for 'strict_warnings' features.",
                    default= [],
                ),
                "treat_warnings_as_errors": attr.string_list(
                    doc = "List of extra flags for 'treat_warnings_as_errors' features.",
                    default= [],
                ),
            },
        ),
        "extra_features": tag_class(
            attrs = {
                "name": attr.string(doc = "Same name as the toolchain tag.", default="gcc_toolchain"),
                "features": attr.string_list(
                    doc = "List of extra compiler and linker features.",
                    default= [],
                ),
            },
        ),
    }
)
