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

load("@score_toolchains_gcc_tests//:features.bzl",
    "strict_warnings_feature",
    "third_party_warnings_feature",
)

strict_warnings_feature()
third_party_warnings_feature()

cc_binary(
    name = "main_cpp",
    srcs = ["main.cpp"],
)
