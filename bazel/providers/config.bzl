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

""" TODO:  Write docstrings
"""

FeatureInfo = provider(
    fields = {
        "name": "Name of the feature",
        "info": "Provider holding data structure of feature function",
        "override": "Override the existing feature in default block",
        "index": "Position of feature in final feature list",
    }
)

ActionConfigInfo = provider(
    fields = {
        "name": "Name of the feature",
        "data": "Provider holding data structure of action_config function",
    }
)

FlagSetInfo = provider(
    fields = {
        "actions": "List of strings representing actions for which this feature is implemented",
        "flags": "List of strings flag for which this feature is implemented",
        "features": "List of providers for which this feature is implemented",
        "not_features": "List of strings flag for which this feature is not implemented",
    }
)
