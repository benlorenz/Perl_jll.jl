# Autogenerated wrapper script for Perl_jll for x86_64-apple-darwin
export libperl, perl

using Readline_jll
JLLWrappers.@generate_wrapper_header("Perl")
JLLWrappers.@declare_library_product(libperl, "@rpath/libperl.dylib")
JLLWrappers.@declare_executable_product(perl)
function __init__()
    JLLWrappers.@generate_init_header(Readline_jll)
    JLLWrappers.@init_library_product(
        libperl,
        "lib/libperl.dylib",
        RTLD_LAZY | RTLD_DEEPBIND,
    )

    JLLWrappers.@init_executable_product(
        perl,
        "bin/perl",
    )

    JLLWrappers.@generate_init_footer()
end  # __init__()
