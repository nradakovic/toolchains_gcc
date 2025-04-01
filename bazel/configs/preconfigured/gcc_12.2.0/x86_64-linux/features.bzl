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
load("@score_toolchain_gcc//rules:features.bzl",
    "flagset_info",
    "feature_info",
)

def debug_feature():
    """ TODO: Write docstrings
    """

def default_compile_flags_feature():
    """ TODO: Write docstrings
    """

def cxx17_feature():
    """ TODO: Write docstrings
    """

def cxx20_feature():
    """ TODO: Write docstrings
    """

def default_link_flags_feature():
    """ TODO: Write docstrings
    """

def minimal_warnings_feature():
    """ TODO: Write docstrings
    """

def opt_feature():
    """ TODO: Write docstrings
    """
def supports_pic_feature():
    """ TODO: Write docstrings
    """

def treat_warnings_as_errors_feature():
    """ TODO: Write docstrings
    """

def unfiltered_compile_flags_feature():
    """ TODO: Write docstrings
    """

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

PRECONFIGURED = [
    ""
    ":coverage",
]
