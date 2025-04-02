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
load("@score_toolchain_gcc//configs/common/actions.bzl",
    "all_cpp_compile_actions",
    "all_c_compile_actions",
    "all_compile_actions",
    "all_link_actions",
)
load("@score_toolchain_gcc//rules/local:features.bzl",
    "flagset_info",
    "feature_info",
)

def debug_feature():
    """ TODO: Write docstrings
    """
    feature_info(name = "dbg")

def default_compile_flags_feature():
    """ TODO: Write docstrings
    """
    flagset_info(
        name = "default_compile_flags_feature_all_compile",
        actions = all_compile_actions,
        flags = ["-m64"],
    )

    flagset_info(
        name = "default_compile_flags_feature_all_cpp",
        actions = all_compile_actions,
        flags = ["-std=c++17"],
        not_features = [
            ":c++17",
            ":c++20",
        ],
    )

    flagset_info(
        name = "default_compile_flags_feature_all_c",
        actions = all_compile_actions,
        flags = ["-std=c11"],
    )

    flagset_info(
        name = "default_compile_flags_feature_all_compile_dbg",
        actions = all_compile_actions,
        flags = [
            "-Og",
            "-g3",
        ],
        with_features = [":dbg"],
    )

    flagset_info(
        name = "default_compile_flags_feature_all_compile_opt",
        actions = all_compile_actions,
        flags = [
            "-O2",
            "-DNDEBUG",
        ],
        with_features = [":opt"],
    )

    feature_info(
        name = "default_compile_flags",
        enabled = True,
        flag_sets = [
            "default_compile_flags_feature_all_compile",
            "default_compile_flags_feature_all_cpp",
            "default_compile_flags_feature_all_c",
            "default_compile_flags_feature_all_compile_dbg",
            "default_compile_flags_feature_all_compile_opt",
        ],
    )

def cxx17_feature():
    """ TODO: Write docstrings
    """
    flagset_info(
        name = "c++17_flags",
        actions = all_cpp_compile_actions,
        flags = ["-std=c++17"],
    )

    feature_info(
        name = "cxx17",
        provides = ["cxx_std"],
        flag_sets = [
            ":cxx17_flags",
        ]
    )

def cxx20_feature():
    """ TODO: Write docstrings
    """
    flagset_info(
        name = "cxx20_flags",
        actions = all_cpp_compile_actions,
        flags = ["-std=c++20"],
    )

    feature_info(
        name = "c++20",
        provides = ["cxx_std"],
        flag_sets = [
            ":cxx20_flags",
        ]
    )

def default_link_flags_feature():
    """ TODO: Write docstrings
    """
    flagset_info(
        name = "default_link_flags_feature_flags_all_link",
        actions = all_link_actions,
        flags = [
            "-static-libstdc++",
            "-static-libgcc",
        ]
    )
    feature_info(
        name = "default_link_flags",
        enabled = True,
        flag_sets = [
            ":default_link_flags_feature_flags_all_link",
        ]
    )

def opt_feature():
    """ TODO: Write docstrings
    """
    feature_info(name = "opt")

def supports_pic_feature():
    """ TODO: Write docstrings
    """
    feature_info(
        name = "supports_pic",
        enabled = True,
    )

def unfiltered_compile_flags_feature():
    """ TODO: Write docstrings
    """
    flagset_info(
        name = "unfiltered_compile_flags_set",
        actions = all_c_compile_actions + all_cpp_compile_actions,
        flags = [
            "-D__DATE__=\"redacted\"",
            "-D__TIMESTAMP__=\"redacted\"",
            "-D__TIME__=\"redacted\"",
            "-Wno-builtin-macro-redefined",
            "-no-canonical-prefixes",
            "-fno-canonical-system-headers",
        ],
    )

    feature_info(
        name = "unfiltered_compile_flags",
        enabled = True,
        flag_sets = [
            ":unfiltered_compile_flags_set",
        ]
    )

def coverage_feature():
    """ TODO: Write docstrings
    """
    flagset_info(
        name = "coverage_flags_compile",
        actions = [
            ACTION_NAMES.preprocess_assemble,
            ACTION_NAMES.c_compile,
            ACTION_NAMES.cpp_compile,
            ACTION_NAMES.cpp_header_parsing,
            ACTION_NAMES.cpp_module_compile,
        ],
        flags = [
            "-fprofile-arcs",
            "-ftest-coverage",
        ],
    )

    flagset_info(
        name = "coverage_flags_link",
        actions = [all_link_actions],
        flags = [
            "-fprofile-arcs",
            "-ftest-coverage",
            "-lgcov",
        ],
    )

    feature_info(
        name = "coverage",
        enabled = False,
        provides = ["profile"],
        flag_sets = [
            ":coverage_flags_compile",
            ":coverage_flags_link",
        ]
    )

# The order of the features is relevant, they are applied in this specific order.
# A command line parameter from a feature at the end of the list will appear
# after a command line parameter from a feature at the beginning of the list.
PRECONFIGURED = [
    "@score_toolchain_gcc@//preconfigured/gcc_12.2.0/x86_64-linux:dbg",
    "@score_toolchain_gcc@//preconfigured/gcc_12.2.0/x86_64-linux:default_compile_flags"
    "@score_toolchain_gcc@//preconfigured/gcc_12.2.0/x86_64-linux:c++17",
    "@score_toolchain_gcc@//preconfigured/gcc_12.2.0/x86_64-linux:c++20",
    "@score_toolchain_gcc@//preconfigured/gcc_12.2.0/x86_64-linux:default_link_flags",
    "@score_toolchain_gcc@//preconfigured/gcc_12.2.0/x86_64-linux:opt",
    "@score_toolchain_gcc@//preconfigured/gcc_12.2.0/x86_64-linux:supports_pic",
    "@score_toolchain_gcc@//preconfigured/gcc_12.2.0/x86_64-linux:unfiltered_compile_flags",
    "@score_toolchain_gcc@//preconfigured/gcc_12.2.0/x86_64-linux:coverage",
]
