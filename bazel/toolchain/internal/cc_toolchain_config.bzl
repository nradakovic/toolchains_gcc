"""C/C++ toolchain definition"""

load("@bazel_tools//tools/build_defs/cc:action_names.bzl", "ACTION_NAMES")
load(
    "@bazel_tools//tools/cpp:cc_toolchain_config_lib.bzl",
    "action_config",
    "feature",
    "flag_group",
    "flag_set",
    "tool",
    "tool_path",
    "with_feature_set",
)
load("@score_toolchains_gcc//providers:config.bzl", "FlagSetInfo", "FeatureInfo")

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

def _impl(ctx):
    # dbg_feature = feature(name = "dbg")
    # opt_feature = feature(name = "opt")

    assemble_action = action_config(
        action_name = ACTION_NAMES.assemble,
        tools = [tool(tool = ctx.executable.cc_binary)],
    )
    preprocess_assemble_action = action_config(
        action_name = ACTION_NAMES.preprocess_assemble,
        tools = [tool(tool = ctx.executable.cc_binary)],
    )
    c_compile_action = action_config(
        action_name = ACTION_NAMES.c_compile,
        tools = [tool(tool = ctx.executable.cc_binary)],
    )
    cpp_compile_action = action_config(
        action_name = ACTION_NAMES.cpp_compile,
        tools = [tool(tool = ctx.executable.cxx_binary)],
    )
    cpp_link_executable_action = action_config(
        action_name = ACTION_NAMES.cpp_link_executable,
        tools = [tool(tool = ctx.executable.cxx_binary)],
    )
    cpp_link_dynamic_library_action = action_config(
        action_name = ACTION_NAMES.cpp_link_dynamic_library,
        tools = [tool(tool = ctx.executable.cxx_binary)],
    )
    cpp_link_nodeps_dynamic_library_action = action_config(
        action_name = ACTION_NAMES.cpp_link_nodeps_dynamic_library,
        tools = [tool(tool = ctx.executable.cxx_binary)],
    )
    cpp_link_static_library_action = action_config(
        action_name = ACTION_NAMES.cpp_link_static_library,
        tools = [tool(tool = ctx.executable.ar_binary)],
        implies = ["archiver_flags"],
    )
    strip_action = action_config(
        action_name = ACTION_NAMES.strip,
        tools = [tool(tool = ctx.executable.strip_binary)],
        flag_sets = [
            flag_set(
                flag_groups = [
                    flag_group(
                        flags = [
                            "-g",
                            "-p",
                        ],
                    ),
                    flag_group(
                        iterate_over = "stripopts",
                        flags = ["%{stripopts}"],
                    ),
                    flag_group(
                        flags = [
                            "%{input_file}",
                            "%{output_file}",
                        ],
                    ),
                ],
            ),
        ],
    )

    action_configs = [
        assemble_action,
        c_compile_action,
        cpp_compile_action,
        cpp_link_dynamic_library_action,
        cpp_link_executable_action,
        cpp_link_nodeps_dynamic_library_action,
        cpp_link_static_library_action,
        preprocess_assemble_action,
        strip_action,
    ]

    features = []
    for ft in ctx.attr.feature_list:
        feature.append(ft[FeatureInfo].info)

    toolchain_full_name = "%s-%s" % (ctx.attr.flavour, ctx.attr.version)
    tool_paths = []

    return cc_common.create_cc_toolchain_config_info(
        ctx = ctx,
        abi_version = toolchain_full_name,
        abi_libc_version = "unknown",
        builtin_sysroot = ctx.file.sysroot.path,
        compiler = "gcc",
        cxx_builtin_include_directories = [],
        features =  features,
        action_configs = action_configs,
        host_system_name = "local",
        target_system_name = "x86_64-linux",
        target_cpu = "x86_64",
        target_libc = "unknown",
        toolchain_identifier = toolchain_full_name,
        tool_paths = tool_paths,
    )

cc_toolchain_config = rule(
    implementation = _impl,
    provides = [CcToolchainConfigInfo],
    attrs = {
        "ar_binary": attr.label(allow_single_file = True, executable = True, cfg = "exec", mandatory = True),
        "cc_binary": attr.label(allow_single_file = True, executable = True, cfg = "exec", mandatory = True),
        "cxx_binary": attr.label(allow_single_file = True, executable = True, cfg = "exec", mandatory = True),
        "gcov_binary": attr.label(allow_single_file = True, executable = True, cfg = "exec", mandatory = True),
        "strip_binary": attr.label(allow_single_file = True, executable = True, cfg = "exec", mandatory = True),
        "sysroot": attr.label(allow_single_file = True, mandatory = True),
        "version": attr.string(mandatory = True),
        "feature_list": attr.label_list(
            default = [],
            providers = [FeatureInfo],
        )
    },
)
