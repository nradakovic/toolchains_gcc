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

load("@score_toolchain_gcc//preconfigured/common/actions.bzl",
    "all_cpp_compile_actions",
    "all_c_compile_actions",
    "all_compile_actions",
)
load("@score_toolchain_gcc//rules/local:features.bzl",
    "flagset_info",
    "feature_info",
)

def minimal_warnings_feature():
    """ TODO: Write docstrings
    """
    flagset_info(
        name = "treat_warnings_as_errors_flags",
        actions = all_compile_actions,
        flags = [
            "-Wall",
            "-Wno-error=deprecated-declarations",
        ],
        not_features = [":third_party_warnings"],
    )

    feature_info(
        name = "minimal_warnings",
        enabled = True,
        flag_sets = [
            ":minimal_warnings_flags",
        ]
    )

def strict_warnings():
    """ TODO: Write docstrings
    """
    flagset_info(
        name = "strict_warnings_flags_all",
        actions = [all_compile_actions],
        flags = [
            "-Wextra",
            "-Wpedantic",
        ],
        not_features = [":third_party_warnings"],
    )

    flagset_info(
        name = "strict_warnings_flags_cpp",
        actions = [all_cpp_compile_actions],
        not_features = [":third_party_warnings"],
    )

    flagset_info(
        name = "strict_warnings_flags_c",
        actions = [all_c_compile_actions],
        not_features = [":third_party_warnings"],
    )

    feature_info(
        name = "strict_warnings",
        implies = [":minimal_warnings"],
        flag_sets = [
            ":strict_warnings_flags_all",
            ":strict_warnings_flags_cpp",
            ":strict_warnings_flags_c",
        ],
        index = 7,
        not_features = [":third_party_feature"]
    )

def third_party_warnings():
    """ TODO: Write docstrings
    """
    flagset_info(
        name = "third_party_warnings_flags",
        actions = [all_compile_actions],
    )

    feature_info(
        name = "third_party_warnings",
        flag_sets = [":third_party_warnings_flags"],
        index = 10,
    )

def treat_warnings_as_errors_feature():
    """ TODO: Write docstrings
    """
    flagset_info(
        name = "treat_warnings_as_errors_flags",
        actions = all_compile_actions,
        flags = [
            "-Werror",
        ],
        not_features = [":third_party_warnings"],
    )

    feature_info(
        name = "treat_warnings_as_errors",
        enabled = True,
        flag_sets = [
            ":treat_warnings_as_errors_flags"
        ]
    )
