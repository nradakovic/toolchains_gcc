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

def _impl(rctx):

    rctx.template(
        "BUILD",
        rctx.attr._cc_tolchain_build,
        {
            "%{gcc_repo}": rctx.attr.gcc_repo,
            "%{custom_warnings}": rctx.attr.custom_warnings,
            "%{extra_features}": rctx.attr.extra_features,
        },
    )

    rctx.template(
        "cc_toolchain_config.bzl",
        rctx.attr._cc_toolchain_config_bzl,
        {},
    )

gcc_toolchain = repository_rule(
    implementation = _impl,
    attrs = {
        "gcc_repo": attr.string(),
        "extra_features": attr.string_list(),
        "warnings": attr.string_dict(),
        "_cc_toolchain_config_bzl": attr.label(
            default = "@score_toolchains_gcc//toolchain/internal:cc_toolchain_config.bzl",
        ),
        "_cc_tolchain_build": attr.label(
            default = "@score_toolchains_gcc//toolchain/internal:toolchain.BUILD",
        ),
    },
)
