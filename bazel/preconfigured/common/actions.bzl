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

load("@bazel_tools//tools/build_defs/cc:action_names.bzl", "ACTION_NAMES")

all_cpp_compile_actions = [
    ACTION_NAMES.cpp_compile,
    ACTION_NAMES.linkstamp_compile,
    ACTION_NAMES.cpp_header_parsing,
    ACTION_NAMES.cpp_module_compile,
    ACTION_NAMES.cpp_module_codegen,
    ACTION_NAMES.clif_match,
    ACTION_NAMES.lto_backend,
]

all_c_compile_actions = [
    ACTION_NAMES.c_compile,
]

all_assemble_actions = [
    ACTION_NAMES.assemble,
    ACTION_NAMES.preprocess_assemble,
]

all_compile_actions = all_c_compile_actions + all_cpp_compile_actions + all_assemble_actions

all_link_actions = [
    ACTION_NAMES.cpp_link_executable,
    ACTION_NAMES.cpp_link_dynamic_library,
    ACTION_NAMES.cpp_link_nodeps_dynamic_library,
]

all_actions = all_compile_actions + all_link_actions + [
    ACTION_NAMES.strip,
    ACTION_NAMES.cpp_link_static_library,
]
