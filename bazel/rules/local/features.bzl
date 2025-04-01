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

""" TODO: Write docstrings
"""

load("@score_toolchains_gcc//providers:config.bzl", "FlagSetInfo", "FeatureInfo")

def _impl_flagset_info(ctx):
    """ TODO: Write docstrings
    """
    return FlagSetInfo(
        actions = ctx.attr.actions,
        flags = ctx.attr.flags,
        with_features = [ f[FeatureInfo].name for f in ctx.attr.features ],
        not_features = [ f[FeatureInfo].name for f in ctx.attr.features ],
    )

flagset_info = rule(
    implementation = _impl_flagset_info,
    attrs = {
        "actions": attr.string_list(
            default = [],
            doc = "", # TODO: Write docstrings
        ),
        "flags": attr.string_list(
            default = [],
            doc = "", # TODO: Write docstrings
        ),
        "with_features": attr.string_list(
            default = [],
            providers = [FeatureInfo],
            doc = "", # TODO: Write docstrings
        ),
        "not_features": attr.string_list(
            default = [],
            providers = [FeatureInfo],
            doc = "", # TODO: Write docstrings
        ),
    }
)

def _impl_feature_info(ctx):
    """ TODO: Write docstrings
    """
    name = ctx.attr.name
    flag_sets = []
    for flag_set_info in ctx.attr.flag_sets:
        flag_sets.append(
            flag_set(
                actions = flag_set_info[FlagSetInfo].actions,
                flag_groups = [
                    flags = flag_set_info[FlagSetInfo].flags,
                ],
                with_features = [
                    with_feature_set(
                        features = flag_set_info[FlagSetInfo].features,
                        not_features = flag_set_info[FlagSetInfo].features,
                    )
                ]
            )
        )

    return FeatureInfo(
        name = name,
        info = feature(
            name = name,
            implies = [i[FeatureInfo].name for i in ctx.attr.implies]
            enabled = ctx.attr.enabled,
            provides = ctx.attr.provides,
            flag_sets = flag_sets,
        ),
        override = ctx.attr.override,
        index = ctx.int.index,
    )

feature_info = rule(
    implementation = _impl_feature_info,
    attrs = {
        "implies": attr.label_list(
            default = [],
            providers = [FeatureInfo],
            doc = "", # TODO: Write docstrings
        ),
        "flag_sets": attr.label_list(
            default = [],
            providers = [FlagSetInfo],
            doc = "", # TODO: Write docstrings
        ),
        "enabled": attr.bool(
            default = True,
            doc = "", # TODO: Write docstrings
        ),
        "provides": attr.string_list(
            default = [],
            doc = "", # TODO: Write docstrings
        ),
        "override": attr.bool(
            default = False,
            doc = "", # TODO: Write docstrings
        ),
        "index": attr.int(
            default = -1,
            doc = "", # TODO: Wrote docstrings
        ),
    },
)
